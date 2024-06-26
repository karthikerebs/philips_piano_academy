import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/application/credit_class/credit_class_bloc.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class SelectSloteList extends StatefulWidget {
  const SelectSloteList(
      {super.key,
      required this.state,
      required this.isSelectSlot,
      required this.selectedSlote});
  final CreditClassState state;
  final ValueNotifier<int> isSelectSlot;
  final ValueNotifier<int> selectedSlote;

  @override
  State<SelectSloteList> createState() => _SelectSloteListState();
}

class _SelectSloteListState extends State<SelectSloteList> {
  int? selectedSlotId;
  String? selectedDate;
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
                    childAspectRatio: 2.6),
                itemBuilder: (context, index) {
                  final date =
                      widget.state.dateAndSlotList[index].date as String;

                  return timeTile(
                      kSize, widget.state.slotList[index], index, date);
                },
              )
            : const Center(child: Text('No slotes found!')),
      ],
    );
  }

  Widget timeTile(Size kSize, dynamic sloteData, int index, String date) {
    return ValueListenableBuilder(
      valueListenable: widget.isSelectSlot,
      builder: (context, value, child) {
        return InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () {
              if (sloteData.availability == 'Available') {
                widget.selectedSlote.value = sloteData.id!;
                widget.isSelectSlot.value = index;
                handleSlotSelection(sloteData.id, date);
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
              child: isSlotSelected(sloteData.id!, date)
                  ? Image.asset(
                      AppImages.tickIcon,
                      height: kSize.height * .018,
                      color: AppColors.secondaryColor,
                    )
                  : Text(
                      formatedTime(sloteData.slote!),
                      style: AppTypography.dmSansRegular.copyWith(
                          fontSize: kSize.height * 0.0165,
                          color: sloteData.availability == 'Available'
                              ? AppColors.secondaryColor
                              : AppColors.borderGreyColor),
                    ),
            ));
      },
    );
  }

  void handleSlotSelection(int slotId, String date) {
    setState(() {
      // If the selected slot is the same as the currently selected slot, deselect it
      if (selectedSlotId == slotId && selectedDate == date) {
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

  String formatedTime(String timeString) {
    DateTime time = DateFormat.Hms().parse(timeString);
    // Format the time to AM/PM format
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }
}
