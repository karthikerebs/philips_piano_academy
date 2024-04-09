import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/core/widgets/validators.dart';
import 'package:music_app/src/presentation/view/unused/success/success_view.dart';

class ClassCancellatonView extends StatefulWidget {
  const ClassCancellatonView({super.key});

  @override
  State<ClassCancellatonView> createState() => _ClassCancellatonViewState();
}

class _ClassCancellatonViewState extends State<ClassCancellatonView> {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reason for leaving?',
                      style: AppTypography.dmSansMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.0284)),
                  SizedBox(height: kSize.height * 0.018),
                  CustomTextField(
                      textColor: AppColors.secondaryColor,
                      errorMessage: 'Please enter any reason',
                      maxLines: 6,
                      validator: (value) {
                        return FormValidators.emptyValidate(value);
                      },
                      fillColor: AppColors.lightBlackColor,
                      hintstyle: AppTypography.dmSansRegular
                          .copyWith(fontSize: 12, color: AppColors.greyColor),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.transparent),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Type your Reason here......',
                      controller: controller),
                  SizedBox(height: kSize.height * 0.023),
                  Center(
                    child: FooterButton(
                      label: 'Send Request',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuccessView(),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
