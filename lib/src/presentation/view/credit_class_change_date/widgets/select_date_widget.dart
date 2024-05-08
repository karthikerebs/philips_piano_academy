import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/application/credit_class/credit_class_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget(
      {super.key,
      required this.dateController,
      required this.dateFormat,
      required this.branchId});
  final TextEditingController dateController;
  final DateFormat dateFormat;
  final String branchId;
  @override
  Widget build(BuildContext context) {
    final state = context.read<ProfileBloc>().state;
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Date',
            style: AppTypography.dmSansRegular.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.028)),
        SizedBox(height: kSize.height * .03),
        CustomDatePicker(
          lastDate: DateTime.parse(
              state.profileData.profileDetails!.validTo.toString()),
          hintColor: AppColors.primaryColor,
          dateController: dateController,
          errorMessage: '',
          hintText: 'Select Date',
          onChanged: (value) {
            dateController.text = dateFormat.format(value);
            context.read<CreditClassBloc>().add(GetSlotsEvent(
                date: formattedDate(dateController.text), branchId));
          },
          firstDate: DateTime.now(),
        ),
        SizedBox(
          height: kSize.height * .02,
        ),
      ],
    );
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("dd/MM/yyyy").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
