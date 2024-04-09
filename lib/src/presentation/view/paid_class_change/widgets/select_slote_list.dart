import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/application/paid_class/paid_class_bloc.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class PaidSelectSloteList extends StatelessWidget {
  const PaidSelectSloteList(
      {super.key,
      required this.state,
      required this.isSelectSlot,
      required this.selectedSlote});
  final PaidClassState state;
  final ValueNotifier<int> isSelectSlot;
  final ValueNotifier<int> selectedSlote;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Time',
            style: AppTypography.dmSansRegular.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.022)),
        SizedBox(height: kSize.height * 0.018),
        state.slotDetails.slotes!.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                itemCount: state.slotDetails.slotes!.length,
                padding: EdgeInsets.only(top: kSize.height * 0.01),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 9,
                    childAspectRatio: 2.6),
                itemBuilder: (context, index) {
                  return timeTile(
                      kSize, state.slotDetails.slotes![index], index);
                },
              )
            : const Center(child: Text('No slotes found!')),
      ],
    );
  }

  Widget timeTile(Size kSize, dynamic sloteData, int index) {
    return ValueListenableBuilder(
      valueListenable: isSelectSlot,
      builder: (context, value, child) {
        return InkWell(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          onTap: () {
            if (sloteData.availability == 'Available') {
              selectedSlote.value = sloteData.id!;
              isSelectSlot.value = index;
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: sloteData.availability == 'Available'
                    ? AppColors.greenColor
                    : AppColors.secondaryColor,
                border: Border.all(
                    color: sloteData.availability == 'Available'
                        ? AppColors.transparent
                        : AppColors.borderGreyColor),
                borderRadius: BorderRadius.circular(kSize.height * 0.0118)),
            child: sloteData.availability == 'Available'
                ? isSelectSlot.value == index
                    ? Image.asset(
                        AppImages.tickIcon,
                        height: kSize.height * .018,
                        color: AppColors.secondaryColor,
                      )
                    : Text(formatedTime(sloteData.slote!),
                        style: AppTypography.dmSansRegular.copyWith(
                            fontSize: kSize.height * 0.0165,
                            color: sloteData.availability == 'Available'
                                ? AppColors.secondaryColor
                                : AppColors.borderGreyColor))
                : Text(formatedTime(sloteData.slote!),
                    style: AppTypography.dmSansRegular.copyWith(
                        fontSize: kSize.height * 0.0165,
                        color: sloteData.availability == 'Available'
                            ? AppColors.secondaryColor
                            : AppColors.borderGreyColor)),
          ),
        );
      },
    );
  }

  String formatedTime(String timeString) {
    DateTime time = DateFormat.Hms().parse(timeString);
    // Format the time to AM/PM format
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }
}
