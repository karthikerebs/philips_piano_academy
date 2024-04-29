import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(
        Uri.parse('https://philipspianoacademy.erebs.in/privacy-policy'));
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          elevation: 0,
          leadingWidth: kSize.width * .1,
          leading: CustomBackButton(
              color: const Color.fromARGB(255, 0, 0, 0),
              onTap: () {
                Navigator.pop(context);
              }),
          title: Text('Privacy Policy',
              style: AppTypography.dmSansRegular.copyWith(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: kSize.height * 0.028)),
        ),
        body: WebViewWidget(
            controller:
                controller) /*     SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kSize.width * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
              Text(
                    "Welcome to Philip's Piano Academy! We're dedicated to nurturing your musical talent with personalized lessons and a supportive community. This policy explains how we handle your personal information.",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.02)),
                SizedBox(height: kSize.height * .02),
                Text("What information do we collect?",
                    style: AppTypography.dmSansBold.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.02)),
                SizedBox(height: kSize.height * .015),
                Text(
                    "Student information: Names, contact details, payment information..\nLesson data: Attendance, progress reports, practice logs (optional).",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.018)),
                SizedBox(height: kSize.height * .015),
                Text("How do we use your information?",
                    style: AppTypography.dmSansBold.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.02)),
                SizedBox(height: kSize.height * .015),
                Text(
                    "Schedule lessons, process payments, communicate updates Track progress, personalize learning goals, tailor lesson plans Manage waiting list, assign new students in case of breaks.",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.018)),
                SizedBox(height: kSize.height * .015),
                Text(
                    "We will not:\nShare your information with third parties without your consent.\nUse your information for marketing purposes unless you opt-in.",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.018)),
                SizedBox(height: kSize.height * .015),
                Text(
                    "Your control:\nAccess and update your information anytime.\nRequest deletion of your data.\nOpt-out of communication, marketing, or data collection.",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.018)),
                SizedBox(height: kSize.height * .015),
                Text(
                    "Safety and security:\nWe take reasonable measures to protect your information from unauthorized access, disclosure, alteration, or destruction",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.018)),
                SizedBox(height: kSize.height * .015),
                Text(
                    "Additional policies:\nPlease refer to our Terms & Conditions for details on lesson scheduling, payments, cancellation, and breaks.",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.018)), 
              ],
            ),
          )),*/
        );
  }
}
