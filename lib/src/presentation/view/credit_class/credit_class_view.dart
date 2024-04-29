import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/credit_class/credit_class_bloc.dart';
import 'package:music_app/src/domain/models/response_models/credit_class_model/credit_class.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/credit_class/widgets/cancel_dialog_box.dart';
import 'package:music_app/src/presentation/view/credit_class/widgets/class_detail_data.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';

class CreditClassView extends StatefulWidget {
  const CreditClassView({super.key});

  @override
  State<CreditClassView> createState() => _CreditClassViewState();
}

class _CreditClassViewState extends State<CreditClassView> {
  @override
  void initState() {
    context.read<CreditClassBloc>().add(const GetCreditClassEvent());
    super.initState();
  }

  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: CustomAppBar(title: "Credit Class"),
      body: RefreshIndicator(
        color: AppColors.blackColor,
        onRefresh: () async {
          context.read<CreditClassBloc>().add(const GetCreditClassEvent());
        },
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Column(
            children: [
              SizedBox(height: kSize.height * .02),
              BlocConsumer<CreditClassBloc, CreditClassState>(
                listener: (context, state) {
                  if (state.status is StatusAuthFailure) {
                    CustomMessage(
                            context: context,
                            message: 'Access Denied. Kindly reauthenticate.',
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
                    return const Column(
                      children: [
                        SizedBox(height: 150),
                        CircularProgressIndicator(
                            color: AppColors.primaryColor),
                      ],
                    );
                  } else if (state.status is StatusSuccess) {
                    if (state.creditClasses.isNotEmpty) {
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                              color: AppColors.greyColor,
                              thickness: 1,
                            );
                          },
                          itemCount: state.creditClasses.length,
                          // shrinkWrap: true,
                          primary: true,
                          itemBuilder: (context, index) {
                            return creditClassTile(
                                kSize, index, state.creditClasses);
                          },
                        ),
                      );
                    } else {
                      return const Column(
                        children: [
                          SizedBox(height: 150),
                          Text('Credit class not found!'),
                        ],
                      );
                    }
                  } else if (state.status is StatusFailure) {
                    final status = state.status as StatusFailure;
                    return Center(
                      child: Text(status.errorMessage),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget creditClassTile(
      Size kSize, int index, List<CreditClass> creditClasses) {
    return Column(
      children: [
        index == 0
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: kSize.height * 0.0243, horizontal: kSize.width * 0.057),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              // width: kSize.width * .8,
              child: RichText(
                  text: TextSpan(
                      text: '${creditClasses[index].details ?? ''}',
                      children: [
                        if (creditClasses[index].addedBy == "Admin")
                          TextSpan(
                              text: '\n(Added by admin.)',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400))
                      ],
                      style: AppTypography.dmSansMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height *
                              0.02))) /* Text(
                    creditClasses[index].addedBy == "Admin"
                        ? "${creditClasses[index].details ?? ''} added by admin."
                        : '${creditClasses[index].details ?? ''}',
                    maxLines: 2,
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.02)) */
              ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClassDetailData(index: index, creditClasses: creditClasses),
                if (creditClasses[index].bookStatus == true)
                  CommonButton(
                    label: "Book Class",
                    onTap: () {
                      showDialog(
                        // barrierDismissible: false,
                        context: context,
                        builder: (context) =>
                            alertDialog(kSize, creditClasses[index]),
                      );
                    },
                  )
                else if (creditClasses[index].attendance == "Present")
                  CommonButton(
                    label: "View Note",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouterConstants.creditClassNoteRoute,
                          arguments: [
                            "Credit Class Notes",
                            creditClasses[index].id.toString()
                          ]);
                    },
                  )
              ],
            ),
          ]),
        ),
        index == creditClasses.length - 1
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox()
      ],
    );
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  /// cancel button

  Widget cancelButton(CreditClass creditClass) {
    return CommonButton(
      label: "Cancel Class",
      onTap: () {
        if (reasonController.text.isNotEmpty) {
          reasonController.clear();
        }
        CreditClassCancelDialogBox(
                isEmergencyCancel: false,
                id: creditClass.id.toString(),
                parentContext: context,
                reasonController: reasonController)
            .show();
      },
    );
  }

  /// emergency cancel button

  Widget emergencyCancelButton(CreditClass creditClass) {
    return CommonButton(
      label: 'Emergency Cancel',
      onTap: () {
        if (reasonController.text.isNotEmpty) {
          reasonController.clear();
        }
        CreditClassCancelDialogBox(
                isEmergencyCancel: true,
                id: creditClass.id.toString(),
                parentContext: context,
                reasonController: reasonController)
            .show();
      },
    );
  }

  Widget alertDialog(Size kSize, CreditClass creditClass) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSize.height * .02)),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(kSize.height * .02)),
        padding: EdgeInsets.symmetric(
            horizontal: kSize.width * .03, vertical: kSize.height * .04),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Warning",
                  textAlign: TextAlign.center,
                  style: AppTypography.dmSansBold.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.028)),
              SizedBox(
                height: kSize.height * .02,
              ),
              Text("Cancellation is not possible for this class.",
                  textAlign: TextAlign.center,
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.022)),
              SizedBox(
                height: kSize.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FooterButton(
                      label: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      boxShadow: [],
                      backgroundColor: AppColors.blackColor.withOpacity(.2)),
                  SizedBox(
                    width: kSize.width * .03,
                  ),
                  FooterButton(
                      label: 'Continue',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouterConstants.creditClassChangeRoute,
                            arguments: creditClass.id);
                      },
                      backgroundColor: AppColors.blackColor),
                ],
              )
            ]),
      ),
    );
  }
}
