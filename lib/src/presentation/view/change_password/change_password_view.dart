import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/core/widgets/validators.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * .06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: kSize.height * .05),
                  CustomTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      errorMessage: "Please enter valid password",
                      validator: (value) {
                        return FormValidators.emptyValidate(value);
                      }),
                  SizedBox(height: kSize.height * .01),
                  CustomTextField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      errorMessage: "Password does not match",
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (passwordController.text == value) {
                          return true;
                        } else {
                          return false;
                        }
                      }),
                  SizedBox(height: kSize.height * .02),
                  BlocListener<ProfileBloc, ProfileState>(
                    listenWhen: (previous, current) =>
                        previous.changePasswordStatus !=
                        current.changePasswordStatus,
                    listener: (context, state) {
                      if (state.changePasswordStatus is StatusLoading) {
                        CustomLoading.show(context);
                      } else if (state.changePasswordStatus is StatusSuccess) {
                        CustomLoading.dissmis(context);
                        Navigator.pop(context);
                        CustomMessage(
                                context: context,
                                message: "Password updated successfully",
                                style: MessageStyle.success)
                            .show();
                      } else if (state.changePasswordStatus is StatusFailure) {
                        CustomLoading.dissmis(context);
                        final status =
                            state.changePasswordStatus as StatusFailure;
                        CustomMessage(
                                context: context,
                                message: status.errorMessage,
                                style: MessageStyle.error)
                            .show();
                      } else if (state.changePasswordStatus
                          is StatusAuthFailure) {
                        CustomMessage(
                                context: context,
                                message:
                                    'Access Denied. Kindly reauthenticate.',
                                style: MessageStyle.error)
                            .show();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouterConstants.splashRoute,
                          (route) => false,
                        );
                      }
                    },
                    child: CommonButton(
                      label: 'Change Password',
                      padding: EdgeInsets.symmetric(
                          horizontal: kSize.width * .06,
                          vertical: kSize.height * .02),
                      fontSize: kSize.height * .021,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ProfileBloc>().add(ChangePasswordEvent(
                              password: passwordController.text));
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
