import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/domain/models/response_models/piad_class_model/paid_class.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/view/paid_class/widgets/cancel_dialog_box.dart';

class PaidClassTile extends StatelessWidget {
  const PaidClassTile(
      {super.key,
      required this.index,
      required this.paidClassList,
      required this.reasonController});
  final int index;
  final List<PaidClass> paidClassList;
  final TextEditingController reasonController;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
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
              vertical: kSize.height * 0.0243, horizontal: kSize.width * 0.097),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(index < 9 ? 'Class 0${index + 1}' : 'Class ${index + 1}',
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.028)),
                  SizedBox(height: kSize.height * .01),
                  rowData(kSize,
                      "Booked Date : ${DateFormat("dd MMM, yyyy").format(DateTime.parse(paidClassList[index].bookedDate!))}"),
                  rowData(kSize,
                      "Slot : ${formatedTime(paidClassList[index].sloteTime ?? "")}"),
                  rowData(kSize,
                      'Paid Amount : ${paidClassList[index].paidAmount ?? ""}'),
                  rowData(kSize, paidClassList[index].status ?? ""),
                ],
              ),
              paidClassList[index].status != "Cancelled" &&
                      DateTime.parse(paidClassList[index].bookedDate ?? '')
                          .isAfter(DateTime.now())
                  ? CommonButton(
                      label: 'Cancel Class',
                      onTap: () {
                        if (reasonController.text.isNotEmpty) {
                          reasonController.clear();
                        }
                        PaidClassCancelDialogBox(
                                id: paidClassList[index].id.toString(),
                                parentContext: context,
                                reasonController: reasonController)
                            .show();
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        index == paidClassList.length - 1
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox()
      ],
    );
  }

  Widget rowData(Size kSize, String data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSize.height * .005),
      child: Text(data,
          style: AppTypography.dmSansRegular.copyWith(
              color: AppColors.greyColor, fontSize: kSize.height * 0.0189)),
    );
  }

  String formatedTime(String timeString) {
    DateTime time = DateFormat.Hms().parse(timeString);
    // Format the time to AM/PM format
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }
}
