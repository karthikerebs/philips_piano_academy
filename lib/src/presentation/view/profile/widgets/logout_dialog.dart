import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/auth/bloc/auth_bloc.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/pref_key/preference_key.dart';
import 'package:music_app/src/infrastructure/core/preference_helper.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSize.height * .02)),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(kSize.height * .02)),
        padding: EdgeInsets.symmetric(
            horizontal: kSize.width * .03, vertical: kSize.height * .04),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Logout",
                  textAlign: TextAlign.center,
                  style: AppTypography.dmSansBold.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.028)),
              SizedBox(
                height: kSize.height * .02,
              ),
              Text("Are you sure want to logout?",
                  textAlign: TextAlign.center,
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.022)),
              SizedBox(
                height: kSize.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FooterButton(
                      label: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      boxShadow: [],
                      backgroundColor: AppColors.blackColor.withOpacity(.2)),
                  SizedBox(
                    width: kSize.width * .03,
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listenWhen: (previous, current) =>
                        previous.logoutStatus != current.logoutStatus,
                    listener: (context, state) {
                      if (state.logoutStatus is StatusLoading) {
                        CustomLoading.show(context);
                      } else if (state.logoutStatus is StatusSuccess) {
                        PreferenceHelper()
                            .setBool(key: AppPrefeKeys.logged, value: false);
                        PreferenceHelper()
                            .setString(key: AppPrefeKeys.token, value: "");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouterConstants.splashRoute,
                          (route) => false,
                        );
                      } else if (state.logoutStatus is StatusFailure) {
                        CustomLoading.dissmis(context);
                        final status = state.logoutStatus as StatusFailure;
                        CustomMessage(
                                context: context,
                                message: status.errorMessage,
                                style: MessageStyle.error)
                            .show();
                      } else if (state.logoutStatus is StatusAuthFailure) {
                        CustomMessage(
                                context: context,
                                message:
                                    'Access Denied. Kindly reauthenticate.',
                                style: MessageStyle.error)
                            .show();
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouterConstants.splashRoute, (route) => false);
                      }
                    },
                    child: FooterButton(
                        label: 'Logout',
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                        backgroundColor: AppColors.blackColor),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
