import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/application/credit_class/credit_class_bloc.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class UpcomingSloteList extends StatefulWidget {
  const UpcomingSloteList(
      {super.key,
      required this.state,
      required this.isSelectSlot,
      required this.selectedSlote,
      required this.dateController});
  final CreditClassState state;
  final ValueNotifier<int> isSelectSlot;
  final ValueNotifier<int> selectedSlote;
  final TextEditingController dateController;

  @override
  State<UpcomingSloteList> createState() => _UpcomingSloteListState();
}

class _UpcomingSloteListState extends State<UpcomingSloteList> {
  int? selectedSlotId;
  String? selectedDate;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Expanded(child: timeWidget(kSize));
  }

  Widget timeWidget(Size kSize) {
    return ListView.builder(
      itemCount: widget.state.dateAndSlotList.length,
      itemBuilder: (context, index) {
        final date = widget.state.dateAndSlotList[index].date as String;
        final slotes =
            widget.state.dateAndSlotList[index].slotes as List<dynamic>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(date))),
            SizedBox(height: kSize.height * 0.018),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 9,
                  childAspectRatio: 2.6),
              itemCount: slotes.length,
              itemBuilder: (context, slotIndex) {
                final slot = slotes[slotIndex];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedSlote.value = slot.id!;
                      widget.dateController.text = formattedDate(date);
                      handleSlotSelection(slot.id!, date);
                    });
                  },
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: slot.availability == 'Available'
                              ? AppColors.greenColor
                              : AppColors.secondaryColor,
                          border: Border.all(
                              color: slot.availability == 'Available'
                                  ? AppColors.transparent
                                  : AppColors.borderGreyColor),
                          borderRadius:
                              BorderRadius.circular(kSize.height * 0.0118)),
                      child: isSlotSelected(slot.id!, date)
                          ? Image.asset(
                              AppImages.tickIcon,
                              height: kSize.height * .018,
                              color: AppColors.secondaryColor,
                            )
                          : Text(formatedTime(slot.slote!),
                              style: AppTypography.dmSansRegular.copyWith(
                                  fontSize: kSize.height * 0.0165,
                                  color: slot.availability == 'Available'
                                      ? AppColors.secondaryColor
                                      : AppColors.borderGreyColor))),
                );
              },
            ),
            SizedBox(height: kSize.height * 0.018),
          ],
        );
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

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String formatedTime(String timeString) {
    DateTime time = DateFormat.Hms().parse(timeString);
    // Format the time to AM/PM format
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }
}
