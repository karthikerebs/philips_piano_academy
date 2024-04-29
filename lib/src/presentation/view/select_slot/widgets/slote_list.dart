/* import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/application/slot_booking/slot_booking_bloc.dart';
import 'package:music_app/src/domain/models/response_models/slot_model/slote.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class SloteList extends StatefulWidget {
  const SloteList(
      {super.key,
      required this.state,
      required this.isSelectSlot,
      required this.selectedSlote,
      required this.day});
  final SlotBookingState state;
  final ValueNotifier<int> isSelectSlot;
  final ValueNotifier<Slote> selectedSlote;
  final String day;
  @override
  State<SloteList> createState() => _SloteListState();
}

class _SloteListState extends State<SloteList> {
  int? selectedSlotId;
  String? selectedDate;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Time',
              style: AppTypography.dmSansRegular.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.022)),
          SizedBox(height: kSize.height * 0.018),
          widget.state.slotList.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  itemCount: widget.state.slotList.length,
                  padding: EdgeInsets.only(top: kSize.height * 0.01),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 9,
                      childAspectRatio: 2.2),
                  itemBuilder: (context, index) {
                    return timeTile(kSize, widget.state.slotList[index], index);
                  },
                )
              : const Center(child: Text('no slots found!')),
        ],
      ),
    );
  }

  Widget timeTile(Size kSize, Slote sloteData, int index) {
    return ValueListenableBuilder(
      valueListenable: widget.isSelectSlot,
      builder: (context, value, child) {
        return InkWell(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          onTap: () {
            if (sloteData.availability == 'Available') {
              widget.selectedSlote.value = sloteData;
              widget.isSelectSlot.value = index;
              handleSlotSelection(sloteData.id!, widget.day);
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
            child: /* sloteData.availability == 'Available'
                ? widget.isSelectSlot.value == index */
                isSlotSelected(sloteData.id!, widget.day)
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
            /* : Text(formatedTime(sloteData.slote!),
                    style: AppTypography.dmSansRegular.copyWith(
                        fontSize: kSize.height * 0.0165,
                        color: sloteData.availability == 'Available'
                            ? AppColors.secondaryColor
                            : AppColors.borderGreyColor)) */
            ,
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

  void handleSlotSelection(int slotId, String date) {
    setState(() {
      // If the selected slot is the same as the currently selected slot, deselect it
      if (selectedSlotId == slotId && widget.day == date) {
        selectedSlotId = null;
        selectedDate = null;
      } else {
        selectedSlotId = slotId;
        selectedDate = date;
      }
    });
  }

  bool isSlotSelected(int slotId, String date) {
    return selectedSlotId == slotId && selectedDate == date;
  }
}
 */