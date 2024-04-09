import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/infrastructure/fcm_service/fcm_service.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/primary_button.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/core/widgets/validators.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/application/auth/bloc/auth_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameControler = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final showPassword = ValueNotifier(false);
  final fcmService = FcmService();
  String firebaseToken = "";
  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.loginStatus != current.loginStatus,
        listener: (context, state) {
          if (state.loginStatus is StatusLoading) {
            CustomLoading.show(context);
          } else if (state.loginStatus is StatusSuccess) {
            if (state.loginResponse.approval == "Pending" ||
                state.loginResponse.approval == "Approved") {
              if (state.loginResponse.slote == 0) {
                context.read<ProfileBloc>().add(GetBasicDetailsEvent());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouterConstants.slotSelectionRoute,
                  (route) => false,
                );
              } else {
                context.read<ProfileBloc>().add(GetBasicDetailsEvent());
                context.read<ProfileBloc>().add(const GetProfileDataEvent());
              }
            }
          } else if (state.loginStatus is StatusFailure) {
            final status = state.loginStatus as StatusFailure;
            CustomLoading.dissmis(context);
            CustomMessage(
                    context: context,
                    message: status.errorMessage,
                    style: MessageStyle.error)
                .show();
          }
        },
        child: BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status is StatusSuccess) {
              context.read<HomeBloc>().add(const GetHomeEvent());
              context.read<HomeBloc>().add(const GetBlogsDataEvent());
              context.read<HomeBloc>().add(const GetVideosDataEvent());
              context.read<ProfileBloc>().add(const GetNotiFyCount());
            } else if (state.status is StatusFailure) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouterConstants.loginRoute, (route) => false);
            } else if (state.status is StatusAuthFailure) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouterConstants.splashRoute, (route) => false);
            }
          },
          child: BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status is StatusSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.bottomNavRoute, (route) => false,
                    arguments: 0);
              } else if (state.status is StatusFailure) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.loginRoute, (route) => false);
              } else if (state.status is StatusAuthFailure) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.splashRoute, (route) => false);
              }
            },
            child: SizedBox(
                height: kSize.height,
                width: kSize.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                      padding: EdgeInsets.only(
                          left: kSize.width * 0.027,
                          right: kSize.width * 0.027),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(AppImages.logo,
                                  height: kSize.height * 0.28),
                            ),
                            SizedBox(height: kSize.height * 0.03),
                            CustomTextField(
                                fillColor: AppColors.textfieldFillColor,
                                hintText: "Username",
                                controller: usernameControler,
                                keyboardType: TextInputType.name,
                                errorMessage: "Please enter valid user name",
                                validator: (value) {
                                  return FormValidators.userNameValidate(value);
                                }),
                            SizedBox(
                              height: kSize.height * 0.01910,
                            ),
                            ValueListenableBuilder(
                              valueListenable: showPassword,
                              builder: (context, value, child) {
                                return CustomTextField(
                                    fillColor: AppColors.textfieldFillColor,
                                    hintText: "Password",
                                    controller: passwordController,
                                    obscureText: !showPassword.value,
                                    maxLines: 1,
                                    errorMessage: "Please enter valid password",
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                        right: kSize.width * 0.05,
                                      ),
                                      child: InkWell(
                                        onTap: (() {
                                          showPassword.value =
                                              !showPassword.value;
                                        }),
                                        child: Icon(
                                            showPassword.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: AppColors.blackColor),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      return FormValidators.emptyValidate(
                                          value);
                                    });
                              },
                            ),
                            SizedBox(height: kSize.height * 0.0410),
                            SizedBox(
                                width: kSize.width,
                                child: PrimaryButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(LoginEvent(
                                            fcmToken: firebaseToken,
                                            username: usernameControler.text,
                                            password: passwordController.text));
                                      }
                                    },
                                    label: AppStrings.login)),
                            SizedBox(height: kSize.height * 0.0190),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: kSize.width,
                        child: Image.asset(
                          AppImages.loginBottom,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kSize.height * .04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.dontHaveAccount,
                              style: AppTypography.dmSansRegular.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: kSize.height * 0.0184)),
                          TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerRight,
                                  foregroundColor: AppColors.primaryColor),
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(const GetBrachesEvent());
                                Navigator.pushNamed(
                                  context,
                                  RouterConstants.registerRoute,
                                );
                              },
                              child: Text(AppStrings.createOne,
                                  style: AppTypography.dmSansRegular.copyWith(
                                      color: AppColors.secondaryColor,
                                      decorationColor: AppColors.secondaryColor,
                                      decoration: TextDecoration.underline,
                                      fontSize: kSize.height * 0.0184)))
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void getToken() async {
    await FcmService().initialize();
    firebaseToken = await FcmService().getFirebaseTokken();
    log("firebase token ${firebaseToken}");
  }
}
