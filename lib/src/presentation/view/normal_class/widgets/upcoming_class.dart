import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_class_model/date.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/cancel_dialog_box.dart';

class UpComingClassDetails extends StatefulWidget {
  const UpComingClassDetails({super.key, required this.reasonController});
  final TextEditingController reasonController;
  @override
  State<UpComingClassDetails> createState() => _UpComingClassDetailsState();
}

class _UpComingClassDetailsState extends State<UpComingClassDetails> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return BlocConsumer<NormalClassBloc, NormalClassState>(
      listener: (context, state) {
        if (state.upcomingClassStatus is StatusAuthFailure) {
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
        if (state.upcomingClassStatus is StatusLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state.upcomingClassStatus is StatusSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                /*    Padding(
                  padding: EdgeInsets.only(
                      bottom: kSize.height * .018, top: kSize.height * .04),
                  child: RichText(
                      text: TextSpan(
                          children: [
                        TextSpan(
                            text: "here",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context,
                                    RouterConstants.cancelMutipleClassRoute);
                              },
                            style: AppTypography.dmSansMedium.copyWith(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                                fontSize: kSize.height * 0.0189))
                      ],
                          text: "Cancel Multiple Classes ",
                          style: AppTypography.dmSansMedium.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.0189))),
                ), */
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.upcomingClassList.length,
                  primary: false,
                  padding: EdgeInsets.only(top: kSize.height * .01),
                  itemBuilder: (context, index) {
                    final months =
                        state.upcomingClassList[index].month as String;
                    final dates =
                        state.upcomingClassList[index].dates as List<dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kSize.width * .06,
                              vertical: kSize.height * .025),
                          child: Text(months,
                              style: AppTypography.dmSansRegular.copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: kSize.height * 0.019)),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: dates.length,
                          primary: false,
                          padding: const EdgeInsets.only(top: 0),
                          itemBuilder: (context, index) {
                            return upComingClassTile(kSize, index, dates[index],
                                dates as List<Date>);
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                              color: AppColors.greyColor,
                              thickness: 1,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state.upcomingClassStatus is StatusFailure) {
          final status = state.upcomingClassStatus as StatusFailure;
          return Center(
            child: Text(status.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget upComingClassTile(
      Size kSize, int index, Date classData, List<Date> classes) {
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
              vertical: kSize.height * 0.0343, horizontal: kSize.width * 0.097),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(index < 9 ? "Class 0${index + 1}" : "Class ${index + 1}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.blackColor,
                          fontSize: kSize.height * 0.0289)),
                  SizedBox(height: kSize.height * .01),
                  Text("Date : ${formattedDate(classData.date ?? "")}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                  SizedBox(height: kSize.height * .01),
                  Text(
                      "Slot : ${formatedTime(classData.slote!) /* DateFormat.jm().format(DateFormat("hh:mm:ss").parse(classData.slote!)) */}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                  SizedBox(height: kSize.height * .01),
                  Text(
                      "Status : ${classData.status!.replaceFirst(classData.status![0], classData.status![0].toUpperCase())}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                  SizedBox(height: kSize.height * .01),
                ],
              ),
              if (classData.cancelStatus == true)
                CommonButton(
                    label: "Cancel Class",
                    onTap: () {
                      if (widget.reasonController.text.isNotEmpty) {
                        widget.reasonController.clear();
                      }
                      CancelDialogBox(
                              date: classData.date ?? '',
                              isEmergencyCancel: false,
                              parentContext: context,
                              reasonController: widget.reasonController)
                          .show();
                    })
              else if (classData.emergencyCancel == true)
                Column(
                  children: [
                    CommonButton(
                        label: "Emergency Cancel",
                        onTap: () {
                          if (widget.reasonController.text.isNotEmpty) {
                            widget.reasonController.clear();
                          }
                          CancelDialogBox(
                                  date: classData.date ?? '',
                                  isEmergencyCancel: true,
                                  parentContext: context,
                                  reasonController: widget.reasonController)
                              .show();
                        }),
                    SizedBox(
                      width: 120,
                      child: Text(
                        "You have limited no.of emergency cancel.",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: AppColors.redColor, fontSize: 10),
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
        index == classes.length - 1
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox()
      ],
    );
  }

  String formatedTime(String timeString) {
    DateTime time = DateFormat.Hms().parse(timeString);
    // Format the time to AM/PM format
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMM, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
