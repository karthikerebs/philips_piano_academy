import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/domain/models/response_models/home_data_model/credit_class.dart';
// import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class WeeklyAttendence extends StatefulWidget {
  const WeeklyAttendence(
      {super.key, required this.dates, required this.creditClassdates});
  final List<dynamic> dates;
  final List<CreditClass> creditClassdates;
  @override
  State<WeeklyAttendence> createState() => _WeeklyAttendenceState();
}

class _WeeklyAttendenceState extends State<WeeklyAttendence> {
  final List<int> steps = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      width: kSize.width * .55,
      child: widget.dates.isNotEmpty
          ? Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: kSize.width * 0.7085,
                      child: const Divider(
                        color: AppColors.blackColor,
                        thickness: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          widget.dates.length < 4 ? widget.dates.length : 4,
                          (index) {
                        bool isCurrentWeek = index < week();
                        Color widgetColor = isCurrentWeek
                            ? AppColors.primaryColor
                            : AppColors.greyColor;
                        return data(kSize, index, widgetColor);
                      }),
                    )
                  ],
                ),
                if (widget.creditClassdates.isNotEmpty) SizedBox(height: 35),
                if (widget.creditClassdates.isNotEmpty)
                  Text("Upcoming Credit/Paid Classes",
                      textAlign: TextAlign.center,
                      style: AppTypography.dmSansMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.0189)),
                if (widget.creditClassdates.isNotEmpty) SizedBox(height: 35),
                if (widget.creditClassdates.isNotEmpty)
                  Stack(
                    children: [
                      SizedBox(
                        width: kSize.width * 0.7085,
                        child: const Divider(
                          color: AppColors.blackColor,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            widget.creditClassdates.length < 4
                                ? widget.creditClassdates.length
                                : 4, (index) {
                          bool isCurrentWeek = index < week();
                          Color widgetColor = isCurrentWeek
                              ? AppColors.primaryColor
                              : AppColors.greyColor;
                          return creditdata(kSize, index, widgetColor);
                        }),
                      )
                    ],
                  )
              ],
            )
          : Center(child: Text('No classes found!')),
    );
  }

  Widget data(Size kSize, int index, Color color) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            height: kSize.height * 0.022,
            width: kSize.height * 0.022,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              border: Border.all(color: AppColors.primaryColor),
              shape: BoxShape.circle,
            ),
            child: /*  index == 4
                ? Image.asset(
                    AppImages.lockIcon,
                    height: kSize.height * 0.0118,
                    color: AppColors.greyColor,
                  )
                : */
                Container(
                    height: kSize.height * 0.0117,
                    width: kSize.height * 0.0117,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor),
                      shape: BoxShape.circle,
                    )),
          ),
        ),
        Positioned(
          // right: kSize.width * -0.0444,
          top: index % 2 != 0 ? kSize.height * -0.0277 : kSize.height * .0277,
          // left: kSize.width * -0.0544,
          child: SizedBox(
            width: kSize.width * .25,
            child: Text(
                DateFormat("dd/MM/yyyy")
                    .format(DateTime.parse(widget.dates[index])),
                textAlign: TextAlign.center,
                maxLines: 1,
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.012)),
          ),
        )
      ],
    );
  }

  Widget creditdata(Size kSize, int index, Color color) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            height: kSize.height * 0.022,
            width: kSize.height * 0.022,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              border: Border.all(color: AppColors.primaryColor),
              shape: BoxShape.circle,
            ),
            child: /*  index == 4
                ? Image.asset(
                    AppImages.lockIcon,
                    height: kSize.height * 0.0118,
                    color: AppColors.greyColor,
                  )
                : */
                Container(
                    height: kSize.height * 0.0117,
                    width: kSize.height * 0.0117,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor),
                      shape: BoxShape.circle,
                    )),
          ),
        ),
        Positioned(
          // right: kSize.width * -0.0444,
          top: index % 2 != 0 ? kSize.height * -0.0277 : kSize.height * .0277,
          // left: kSize.width * -0.0544,
          child: SizedBox(
            width: kSize.width * .25,
            child: Text(
                DateFormat("dd/MM/yyyy").format(DateTime.parse(
                    widget.creditClassdates[index].bookedDate ?? "")),
                textAlign: TextAlign.center,
                maxLines: 1,
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.012)),
          ),
        )
      ],
    );
  }

  int week() {
    String date = DateTime.now().toString();
    String firstDay = '${date.substring(0, 8)}01${date.substring(10)}';
    int weekDay = DateTime.parse(firstDay).weekday;
    DateTime testDate = DateTime.now();
    int weekOfMonth;
    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    return weekOfMonth;
  }

  int totalWeeks() {
    var now = DateTime.now();
    var firstDayOfMonth = DateTime(now.year, now.month, 1);
    var lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    var weeksInMonth =
        (lastDayOfMonth.difference(firstDayOfMonth).inDays / 7).ceil();
    return weeksInMonth;
  }
}
