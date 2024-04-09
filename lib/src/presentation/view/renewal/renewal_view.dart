import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/application/renewal/renewal_bloc.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';

// import '../renewal_fee/renewal_fee_details_view.dart';
// import 'widgets/card_details.dart';

class RenewalView extends StatefulWidget {
  const RenewalView({super.key});
  @override
  State<RenewalView> createState() => _RenewalViewState();
}

class _RenewalViewState extends State<RenewalView> {
  @override
  void initState() {
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
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        toolbarHeight: kSize.height * .25,
        leadingWidth: 5,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: const SizedBox(),
        title: title(kSize),
      ),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!requestRenewal())
                    Text(
                      "Your renewal has been activated 4 days prior to the end of your current plan.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: AppColors.redColor),
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
                            dataTile(kSize, "Total Fee ",
                                "₹${sumTotalFee(state.renewalFees.renewalFee ?? 0, state.renewalFees.extraClassFee ?? 0)} (18% gst included)"),
                            SizedBox(
                              height: 15,
                            ),
                            BlocListener<RenewalBloc, RenewalState>(
                              listenWhen: (previous, current) =>
                                  previous.checkRenewalStatus !=
                                  current.checkRenewalStatus,
                              listener: (context, state) {
                                if (state.checkRenewalStatus is StatusSuccess) {
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
                              child: FooterButton(
                                  label: "Apply Renewal",
                                  boxShadow: [],
                                  backgroundColor: requestRenewal()
                                      ? AppColors.blackColor
                                      : AppColors.blackColor.withOpacity(.3),
                                  fontSize: 15,
                                  onPressed: () {
                                    if (requestRenewal()) {
                                      context
                                          .read<RenewalBloc>()
                                          .add(CheckRenewalEvent());
                                    }
                                  }),
                            )
                          ],
                        );
                        /*  return ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: kSize.height * .015,
                            );
                          },
                          shrinkWrap: true,
                          itemCount: state.planList.length,  
                          primary: false,
                          padding: EdgeInsets.only(
                            top: kSize.height * .02,
                          ),
                          itemBuilder: (context, index) {
                            return CardDetails(
                              onChanged: (value) {
                                selectedType.value = value;
                              },
                              paymentTypes: paymentTypes,
                              selectType: selectType,
                              planDetails: state.planList[index],
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouterConstants.renewalFeeDetailsRoute,
                                    arguments: SendRequestModel(
                                        payType: "Full",
                                        planId: state.planList[index].id));
                              },
                            );
                          },
                        ); */
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
                  /*    Center(
                    child: RichText(
                        text: TextSpan(
                            text: AppStrings.haveQuestion,
                            style: AppTypography.dmSansRegular.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.0189),
                            children: [
                          TextSpan(
                              text: ' Reach Us',
                              style: AppTypography.dmSansRegular.copyWith(
                                  color: AppColors.primaryColor,
                                  decorationColor: AppColors.primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: kSize.height * 0.0184))
                        ])),
                  ), 
                  SizedBox(height: kSize.height * 0.0189),*/
                ],
              ),
            ),
          )),
    );
  }

  Widget title(Size kSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kSize.height * .05),
        CustomBackButton(onTap: () {
          Navigator.pop(context);
        }),
        SizedBox(height: kSize.height * 0.018),
        Center(
          child: Text('Renewal and Extra Class Fees',
              style: AppTypography.dmSansBold.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.03)),
        ),
        SizedBox(height: kSize.height * 0.02),
        Center(
          child: Text(AppStrings.chooseYourPlanDescription,
              style: AppTypography.dmSansRegular.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.02)),
        ),
        SizedBox(height: kSize.height * 0.03),
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

  bool requestRenewal() {
    final state = context.read<ProfileBloc>().state;
    final DateTime validTo = DateFormat("yyyy-MM-dd")
        .parse(state.profileData.profileDetails!.validTo!);
    DateTime currentDate = DateTime.now();
    int daysDifference = validTo.difference(currentDate).inDays;
    if (daysDifference <= 4) {
      return true;
    } else {
      return false;
    }
  }
}
