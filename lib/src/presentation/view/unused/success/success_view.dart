import 'package:flutter/material.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(AppImages.successIcon,
                    height: kSize.height * 0.1777),
              ),
              SizedBox(height: kSize.height * 0.0177),
              Text('Your Request Submitted\nSuccessfully!',
                  textAlign: TextAlign.center,
                  style: AppTypography.dmSansMedium.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.0284)),
              const Spacer(),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: AppStrings.haveQuestion,
                        style: AppTypography.dmSansRegular.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: kSize.height * 0.0189),
                        children: [
                      TextSpan(
                          text: ' Reach Us',
                          style: AppTypography.dmSansRegular.copyWith(
                              color: AppColors.primaryColor,
                              decorationColor: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: kSize.height * 0.0184))
                    ])),
              ),
              SizedBox(height: kSize.height * 0.0177),
            ],
          )),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouterConstants.bottomNavRoute, (route) => false,
          arguments: 3);
    });
  }
}
