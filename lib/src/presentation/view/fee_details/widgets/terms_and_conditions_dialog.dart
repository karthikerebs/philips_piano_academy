import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/view/fee_details/widgets/bullet_list.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  const TermsAndConditionsDialog({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: kSize.width * .05, vertical: kSize.height * .03),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSize.height * .01)),
      backgroundColor: Colors.black.withOpacity(0.5),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kSize.height * .01)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Terms and Conditions',
                  style: AppTypography.dmSansBold.copyWith(
                      fontSize: kSize.height * .03,
                      color: AppColors.blackColor),
                ),
                const SizedBox(height: 10),
                /*      Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    """
* Enrollment and Registration
    * All students must complete the registration process to enroll in classes.
    *  Registration through the app requires accurate completion with correct personal information.
    * The school reserves the right to refuse enrollment based on capacity or any other relevant reason.

* Tuition Fees and Payments
    * Lesson fees are payable in advance for a whole month, no later than five days before the start of the new month.
    * Breaks without payment of fees are prohibited, but makeup lessons for missed classes will be offered.
    * Payments can be made through the school's app using various online payment methods, and receipts will be issued for all transactions.
    * Fees are non-refundable except under exceptional circumstances as determined by the school management.

* Deposit Refund Policy
    * Refund requests must be made at least  30 days prior to the start of the program or service.
    * Deposits may be subject to a non-refundable portion, as outlined in the initial agreement.
    * Any outstanding dues or fees owed to the school will be deducted from the refund amount.
    * Refunds will be processed within 5-7days of the approved request.
    * The school reserves the right to withhold the deposit in case of violation of terms and conditions or non-compliance with school policies.

* Attendance and Punctuality
    * Regular attendance is essential for progress. Students are expected to attend all scheduled lessons punctually.
    * If you arrive late for a lesson, the duration will not be extended into another student's scheduled lesson time.
    * Any lesson cancellations require a minimum of 18-hours notice and can be conveniently managed through the app..
    * Missed lessons without prior notice through the app will not be compensated for or rescheduled.
    * Make-up lessons may be arranged for missed classes with advance notice, and this can be managed conveniently through the app.

* Curriculum and Progress
    * The school will provide a structured curriculum tailored to each student's skill level and learning objectives.
    * Progress will be regularly assessed, and feedback will be provided to students and parents/guardians.

* Code of Conduct
    * Students are expected to conduct themselves respectfully towards teachers, staff, and fellow students.
    * Any disruptive behavior may result in disciplinary action, including suspension or expulsion from classes.

* Materials and Equipment
    * Students are responsible for purchasing required textbooks, sheet music, and other learning materials as advised by the instructor.
    * The school will provide suitable instruments for lessons conducted on-site.

* Safety and Liability
    * The school will take reasonable measures to ensure the safety of students and staff during classes.
    * Parents/guardians are responsible for their children's safety when dropping off and picking up students from the school premises.

* Communication
    * The school will communicate important information, such as schedule changes or policy updates, via email, phone, or other appropriate means.
    * Parents/guardians are encouraged to maintain open communication with instructors regarding their child's progress and any concerns.

* Privacy Policy
    * The school respects the privacy of students and parents/guardians and will handle personal information in accordance with applicable privacy laws.

* Termination of Enrollment
    * The school reserves the right to terminate a student's enrollment due to persistent misconduct, non-payment of fees, or other serious breaches of these terms and conditions.

* Amendments
* The school reserves the right to amend these terms and conditions at any time. Updated terms will be communicated to all enrolled students and parents/guardians.
By enrolling in classes at Phiilips Piano Academy, students and parents/guardians agree to abide by these terms and conditions.
                """,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ), */
                const BulletList([
                  """Enrollment and Registration
* All students must complete the registration process to enroll in classes.
*  Registration through the app requires accurate completion with correct personal information.
* The school reserves the right to refuse enrollment based on capacity or any other relevant reason.""",
                  """ Tuition Fees and Payments
* Lesson fees are payable in advance for a whole month, no later than five days before the start of the new month.
* Breaks without payment of fees are prohibited, but makeup lessons for missed classes will be offered.
* Payments can be made through the school's app using various online payment methods, and receipts will be issued for all transactions.
* Fees are non-refundable except under exceptional circumstances as determined by the school management.""",
                  """" Deposit Refund Policy
* Refund requests must be made at least  30 days prior to the start of the program or service.
* Deposits may be subject to a non-refundable portion, as outlined in the initial agreement.
* Any outstanding dues or fees owed to the school will be deducted from the refund amount.
* Refunds will be processed within 5-7days of the approved request.
* The school reserves the right to withhold the deposit in case of violation of terms and conditions or non-compliance with school policies.""",
                  """ Attendance and Punctuality
* Regular attendance is essential for progress. Students are expected to attend all scheduled lessons punctually.
* If you arrive late for a lesson, the duration will not be extended into another student's scheduled lesson time.
* Any lesson cancellations require a minimum of 18-hours notice and can be conveniently managed through the app..
* Missed lessons without prior notice through the app will not be compensated for or rescheduled.
* Make-up lessons may be arranged for missed classes with advance notice, and this can be managed conveniently through the app.""",
                  """ Curriculum and Progress
* The school will provide a structured curriculum tailored to each student's skill level and learning objectives.
* Progress will be regularly assessed, and feedback will be provided to students and parents/guardians.""",
                  """Code of Conduct
* Students are expected to conduct themselves respectfully towards teachers, staff, and fellow students.
* Any disruptive behavior may result in disciplinary action, including suspension or expulsion from classes.""",
                  """ Materials and Equipment
* Students are responsible for purchasing required textbooks, sheet music, and other learning materials as advised by the instructor.
* The school will provide suitable instruments for lessons conducted on-site.""",
                  """" Safety and Liability
* The school will take reasonable measures to ensure the safety of students and staff during classes.
* Parents/guardians are responsible for their children's safety when dropping off and picking up students from the school premises.""",
                  """ Communication
* The school will communicate important information, such as schedule changes or policy updates, via email, phone, or other appropriate means.
* Parents/guardians are encouraged to maintain open communication with instructors regarding their child's progress and any concerns.""",
                  """ Privacy Policy
* The school respects the privacy of students and parents/guardians and will handle personal information in accordance with applicable privacy laws.""",
                  """ Termination of Enrollment
* The school reserves the right to terminate a student's enrollment due to persistent misconduct, non-payment of fees, or other serious breaches of these terms and conditions.""",
                  """ Amendments
* The school reserves the right to amend these terms and conditions at any time. Updated terms will be communicated to all enrolled students and parents/guardians.
     By enrolling in classes at Phiilips Piano Academy, students and parents/guardians agree to abide by these terms and conditions."""
                ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.transparent),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: AppColors.blackColor),
                        )),
                    SizedBox(width: kSize.width * .06),
                    FooterButton(
                      label: "I Agree",
                      onPressed: onTap,
                      boxShadow: const [],
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          )),
    );
  }
}
