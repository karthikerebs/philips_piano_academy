import 'package:flutter/material.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: CustomAppBar(title: "Settings"),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kSize.width * .06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*  Row(
                  children: [
                    Image.asset(AppImages.notificationSettingsIcon,
                        height: kSize.height * .05),
                    SizedBox(
                      width: kSize.width * .02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Allow Notification',
                            style: AppTypography.quickSandsBold.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.024)),
                        Text('Turn On/Off Notifications',
                            style: AppTypography.quickSandRegular.copyWith(
                                color: AppColors.greyColor,
                                fontSize: kSize.height * 0.018)),
                      ],
                    ),
                    const Spacer(),
                    CustomSwitch(
                      enabled: (value) {},
                    )
                  ],
                ), 
                SizedBox(height: kSize.height * .01),*/
                dataTile(
                    kSize: kSize,
                    icon: AppImages.openSourceIcon,
                    label: "About us",
                    onTap: () {
                      _launchURL(
                          'https://philipspianoacademy.com/about-us.html');
                    }),
                dataTile(
                    kSize: kSize,
                    icon: AppImages.privacyIcon,
                    label: "Privacy Policy",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouterConstants.privacyPolicyRoute);
                    }),
                /*            dataTile(
                    kSize: kSize,
                    icon: AppImages.cookeeIcon,
                    label: "Cookies Prefernce"), */
                dataTile(
                    kSize: kSize,
                    icon: AppImages.openSourceIcon,
                    label: "Terms and Conditions",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouterConstants.termsAndConditionsRoute);
                    }),
              ],
            ),
          )),
    );
  }

  Widget dataTile(
      {required Size kSize,
      required String icon,
      required String label,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kSize.height * .015),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: kSize.height * .05,
            ),
            SizedBox(
              width: kSize.width * .02,
            ),
            Text(label,
                style: AppTypography.quickSandsBold.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.024)),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
