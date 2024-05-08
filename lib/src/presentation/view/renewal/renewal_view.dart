import 'dart:convert';
import 'dart:io';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/renewal/renewal_bloc.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/pref_key/preference_key.dart';
import 'package:music_app/src/infrastructure/core/preference_helper.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';

////////////////////////////////////////////

class ProfileController extends GetxController {
  var lastDay = '2020-04-22'.obs;
  var validto = '2020-04-22'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLastDay();
  }

  final isLoading = false.obs;

  void fetchLastDay() async {
    isLoading.value = true;
    final accessToken =
        await PreferenceHelper().getString(key: AppPrefeKeys.token);
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $accessToken'};

    try {
      final response = await http.get(
          Uri.parse('${AppUrls.baseUrl}/profile-details'),
          headers: headers);
      final jsonData = json.decode(response.body);

      lastDay.value = jsonData['profile_details']['last_day'] ?? '';
      validto.value = jsonData['profile_details']['valid_to'] ?? '';

      print(lastDay.value);
    } catch (e) {
      print('Error fetching last day: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

////////////////////////////////////////////
class LastDayModel {
  String lastDay;
  String validTo;
  String class_mode;

  LastDayModel(
      {required this.lastDay, required this.validTo, required this.class_mode});

  factory LastDayModel.fromJson(Map<String, dynamic> json) {
    return LastDayModel(
      lastDay: json['profile_details']['last_day'] ?? '',
      validTo: json['profile_details']['valid_to'] ?? '',
      class_mode: json['profile_details']['class_mode'] ?? '',
    );
  }
}

class RenewalView extends StatefulWidget {
  const RenewalView({super.key});
  @override
  State<RenewalView> createState() => _RenewalViewState();
}

class _RenewalViewState extends State<RenewalView> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.fetchLastDay();
    context.read<RenewalBloc>().add(const GetRenewalFeesEvent());
    super.initState();
  }

  List<String> paymentTypes = ["Full", "Monthly"];
  final selectType = ValueNotifier(0);
  final selectedType = ValueNotifier("Full");
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: CustomAppBar(title: "Renewal"),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.08),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isCheckRequestRenewal())
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You can only renew after the subscription has expired.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.redColor),
                        ),
                      ),
                    SizedBox(height: kSize.height * 0.018),
                    BlocConsumer<RenewalBloc, RenewalState>(
                      listener: (context, state) {
                        if (state.status is StatusAuthFailure) {
                          CustomMessage(
                                  context: context,
                                  message:
                                      'Access Denied. Kindly reauthenticate.',
                                  style: MessageStyle.error)
                              .show();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouterConstants.splashRoute,
                            (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.status is StatusLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.primaryColor),
                          );
                        } else if (state.status is StatusSuccess) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              dataTile(kSize, "Renewal Fee ",
                                  "₹${state.renewalFees.renewalFee!.round()}"),
                              dataTile(kSize, "Extra Class Fee ",
                                  "₹${state.renewalFees.extraClassFee!.round()}"),
                              dataTile(kSize, "Extra Class No ",
                                  "${state.renewalFees.extraClass}"),
                              Divider(
                                color: AppColors.blackColor,
                              ),
                              dataTile(
                                kSize,
                                "Total Fee ",
                                "₹${sumTotalFee(
                                  state.renewalFees.renewalFee ?? 0,
                                  state.renewalFees.extraClassFee ?? 0,
                                )} (18% gst included)",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              BlocListener<RenewalBloc, RenewalState>(
                                listenWhen: (previous, current) =>
                                    previous.checkRenewalStatus !=
                                    current.checkRenewalStatus,
                                listener: (context, state) {
                                  if (state.checkRenewalStatus
                                      is StatusSuccess) {
                                    Navigator.pushNamed(context,
                                        RouterConstants.renewalFeeDetailsRoute,
                                        arguments:
                                            "${state.renewalFees.extraClassFee}");
                                  } else if (state.checkRenewalStatus
                                      is StatusFailure) {
                                    CustomMessage(
                                            context: context,
                                            message:
                                                'Renewal request already sent.',
                                            style: MessageStyle.error)
                                        .show();
                                  } else if (state.checkRenewalStatus
                                      is StatusAuthFailure) {
                                    final status = state.checkRenewalStatus
                                        as StatusAuthFailure;
                                    CustomMessage(
                                            context: context,
                                            message: status.errorMessage,
                                            style: MessageStyle.error)
                                        .show();
                                  }
                                },
                                child:
                                    //  profileController.isLoading.value
                                    //     ? CircularProgressIndicator(
                                    //         strokeWidth: 2,
                                    //         color: AppColors.primaryColor)
                                    //     :
                                    FooterButton(
                                        label: "Apply Renewal",
                                        boxShadow: [],
                                        backgroundColor: isCheckRequestRenewal()
                                            ? AppColors.blackColor
                                            : AppColors.blackColor
                                                .withOpacity(.3),
                                        fontSize: 15,
                                        onPressed: () {
                                          if (isCheckRequestRenewal()) {
                                            context
                                                .read<RenewalBloc>()
                                                .add(CheckRenewalEvent());
                                          }
                                        }),
                              )
                            ],
                          );
                        } else if (state.status is StatusFailure) {
                          final status = state.status as StatusFailure;
                          return Center(
                            child: Text(status.errorMessage),
                          );
                        } else if (state.status is StatusAuthFailure) {
                          final status = state.status as StatusAuthFailure;
                          return Center(
                            child: Text(status.errorMessage),
                          );
                        } else {
                          return const Center(child: Text("no plans found!"));
                        }
                      },
                    ),
                    SizedBox(height: kSize.height * 0.0489),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget title(Size kSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: kSize.height * .05),
        CustomBackButton(onTap: () {
          Navigator.pop(context);
        }),
        SizedBox(width: kSize.width * 0.15),
        // Text('Account Renewal',
        //     style: AppTypography.dmSansBold.copyWith(
        //         color: AppColors.primaryColor, fontSize: kSize.height * 0.027)),
        /////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        // SizedBox(height: kSize.height * 0.02),
        // Center(
        //   child: Text(AppStrings.chooseYourPlanDescription,
        //       style: AppTypography.dmSansRegular.copyWith(
        //           color: AppColors.primaryColor,
        //           fontSize: kSize.height * 0.02)),
        // ),
        // SizedBox(height: kSize.height * 0.03),
      ],
    );
  }

  Widget dataTile(Size kSize, String label, String data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.dmSansRegular.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.023),
          ),
          Text(
            "${data}",
            style: AppTypography.dmSansMedium.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.023),
          ),
        ],
      ),
    );
  }

  num sumTotalFee(num renewalFee, num extraClassFee) {
    var totalSumFee = renewalFee + extraClassFee;
    return totalSumFee.round();
  }

  bool isCheckRequestRenewal() {
    final DateTime validTo = DateFormat("yyyy-MM-dd")
        // .parse("2024-04-21");
        .parse(profileController.lastDay.value);
    DateTime currentDate = DateTime.now();
    return validTo.isBefore(currentDate);
  }
}
