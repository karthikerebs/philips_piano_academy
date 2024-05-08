import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsView extends StatefulWidget {
  const TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Color.fromARGB(0, 255, 255, 255))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(
        Uri.parse('https://philipspianoacademy.erebs.in/terms&conditions'));
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
              color: const Color.fromARGB(255, 2, 2, 2),
              onTap: () {
                Navigator.pop(context);
              }),
          title: Text('Terms and Conditions',
              style: AppTypography.dmSansRegular.copyWith(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: kSize.height * 0.028)),
        ),
        body: WebViewWidget(
            controller:
                controller) /* SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * .03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kSize.height * .05,
                  ),
                  Row(
                    children: [
                      CustomBackButton(onTap: () {
                        Navigator.pop(context);
                      }),
                      Spacer(),
                      Center(
                        child: Text('Terms and Conditions',
                            style: AppTypography.dmSansBold.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.028)),
                      ),
                      Spacer(),
                    ],
                  ),
                  const BulletList(
                    [
                      'We are an academy who engage in private in  one-on-one lessons and we take a limited number of students to groom.Every week, students will receive one hour of class in the time slot that both student and instructor have selected.',
                      'In the case of our instructor not being able to attend a lesson due to an occasional professional reason or illness, the class will be provided via correspondence or rescheduled at a suitable time.',
                      'Lessons fees are payable in advance for a whole month, no later than five days before the start of the new month.We accept payment by bank transfer,cheque,online payment and cash.',
                      "Students are expected to attend classes regularly and with puncuality.If you are late for a lesson your lesson time will not be extended into someone else's lesson.",
                      "24 hours of notice is required for any lesson cancellation.In the event of cancellation with the notice period, we will try our ability to reschedule the class. ",
                      "A maximum of only month of break would be permitted to take in a year. If a students takes more than a month of break, he or she would lose their current spot.",
                      "If you miss your spot at Philip's Piano Academy, we will be giving your current spot to new students from the waiting list."
                    ],
                  ),
                ],
              ),
            ),
          )), */
        );
  }
}
