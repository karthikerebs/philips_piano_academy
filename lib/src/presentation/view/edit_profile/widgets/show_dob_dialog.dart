/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/domain/models/pm_models/pm_edit_profile_model/pm_edit_profile_model.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';

class ShowDobDialogBox {
  final BuildContext parentContext;
  final TextEditingController controller;
    final TextEditingController addressController;
      final TextEditingController alternativeMobileController;
        final TextEditingController dobController;
          final TextEditingController guardianController;
            final TextEditingController nameController;
 const ShowDobDialogBox({required this.parentContext,required this.controller,required this.addressController,required this.alternativeMobileController,required this.dobController,required this.guardianController,required this.nameController})
    showDateOfBirth() {
      final kSize=MediaQuery.of(parentContext).size;
   return  showDialog(
        context: parentContext,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(
                left: kSize.width * .06,
                bottom: kSize.height * .04,
                right: kSize.width * .06),
            title: Center(
                child: Text(
              "Edit",
              style: AppTypography.dmSansMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.0284),
            )),
            actions: [
              CustomDatePicker(
                borderRadius: BorderRadius.circular(kSize.height * 0.142),
                dateController: controller,
                fillColor: AppColors.textFieldFillColor,
                borderColor: AppColors.transparent,
                initialDatePickerMode: DatePickerMode.year,
                suffixIcon: const SizedBox(),
                errorMessage: '',
                hintText: '',
                onChanged: (value) {
                  controller.text = dateFormat.format(value);
                },
              ),
              SizedBox(height: kSize.height * .03),
              Center(
                  child: CommonButton(
                label: "Submit",
                onTap: () {
                  Navigator.pop(context);
                  context.read<ProfileBloc>().add(EditProfileEvent(
                      params: PmEditProfileModel(
                          address: addressController.text,
                          alternativeMobile: alternativeMobileController.text,
                          dob: formattedDate(dobController.text),
                          guardian: guardianController.text,
                          name: nameController.text)));
                },
              ))
            ],
          );
        });
  }
  String formattedDate(String date) {
    DateTime parseDate = DateFormat("dd-MM-yyyy").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
} */
