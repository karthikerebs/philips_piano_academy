import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';

class ClassRescheduleView extends StatefulWidget {
  const ClassRescheduleView({super.key});

  @override
  State<ClassRescheduleView> createState() => _ClassRescheduleViewState();
}

class _ClassRescheduleViewState extends State<ClassRescheduleView> {
  TextEditingController leavedateController = TextEditingController();
  TextEditingController reseduleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: kSize.width * 0.12,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: kSize.width * 0.04),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kSize.height * 0.044,
                ),
                Text('Apply Leave',
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.0284)),
                SizedBox(height: kSize.height * 0.018),
                CustomDatePicker(
                  dateController: leavedateController,
                  errorMessage: 'Please select date',
                  hintText: 'Select Date',
                  onChanged: (value) {},
                ),
                SizedBox(height: kSize.height * 0.0355),
                Text('Reschedule Date',
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.0284)),
                SizedBox(height: kSize.height * 0.018),
                CustomDatePicker(
                  dateController: reseduleController,
                  errorMessage: 'Please select date',
                  hintText: 'Select Date',
                  onChanged: (value) {},
                ),
                SizedBox(height: kSize.height * 0.023),
                Center(
                  child: FooterButton(
                    label: 'Apply Leave',
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )),
    );
  }
}
