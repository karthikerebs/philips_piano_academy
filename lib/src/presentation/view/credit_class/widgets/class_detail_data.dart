import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/domain/models/response_models/credit_class_model/credit_class.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class ClassDetailData extends StatelessWidget {
  const ClassDetailData(
      {super.key, required this.index, required this.creditClasses});
  final int index;
  final List<CreditClass> creditClasses;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*     SizedBox(
          width: kSize.width * .5,
          child: Text(
              /* index < 9 ? 'Class 0${index + 1}' : "Class ${index + 1}" */ creditClasses[
                              index]
                          .addedBy ==
                      "Admin"
                  ? "${creditClasses[index].details ?? ''} added by admin."
                  : '${creditClasses[index].details ?? ''}',
              maxLines: 2,
              style: AppTypography.dmSansMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.022)),
        ), */
        SizedBox(height: kSize.height * .01),
        if (creditClasses[index].status == 'Booked')
          rowData(kSize,
              'Booked Date : ${DateFormat("dd MMM, yyyy").format(DateTime.parse(creditClasses[index].bookedDate ?? ""))}'),
        if (creditClasses[index].status == 'Booked')
          rowData(kSize,
              "Slot : ${formatedTime(creditClasses[index].sloteTime ?? "")}"),
        rowData(kSize, "Status : ${creditClasses[index].status ?? ""}"),
        if ((creditClasses[index].status != 'Pending'))
          if (creditClasses[index].bookedDate != null)
            if (DateTime.parse(creditClasses[index].bookedDate)
                .isBefore(DateTime.now()))
              rowData(kSize,
                  "Attendance : ${creditClasses[index].attendance ?? ""}"),
        if (creditClasses[index].status != 'Pending' ||
            creditClasses[index].status != 'Cancelled')
          if (creditClasses[index].dueDate != null)
            rowData(kSize,
                "Due Date : ${formattedDate(creditClasses[index].dueDate ?? "")}")
      ],
    );
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMM, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
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
