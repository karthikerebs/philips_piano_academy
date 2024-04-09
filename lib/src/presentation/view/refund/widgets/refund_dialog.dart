import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/application/refund/refund_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/core/widgets/validators.dart';

class RefundDialog extends StatefulWidget {
  const RefundDialog({super.key});

  @override
  State<RefundDialog> createState() => _RefundDialogState();
}

class _RefundDialogState extends State<RefundDialog> {
  TextEditingController controller = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  var dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSize.height * .01)),
      backgroundColor: Colors.black.withOpacity(0.5),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * .04),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kSize.height * .01)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 25),
                Text(
                  'Refund Request',
                  style: AppTypography.dmSansBold.copyWith(
                      fontSize: kSize.height * .03,
                      color: AppColors.blackColor),
                ),
                const SizedBox(height: 20),
                CustomDatePicker(
                  fillColor: AppColors.textFieldFillColor,
                  borderColor: AppColors.transparent,
                  dateController: controller,
                  errorMessage: '',
                  hintText: "Choose Date",
                  hintColor: AppColors.primaryColor,
                  firstDate: DateTime.now().subtract(const Duration(days: 0)),
                  onChanged: (value) {
                    controller.text = dateFormat.format(value);
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: reasonController,
                  errorMessage: 'Please enter reason',
                  hintText: "reason...",
                  hintColor: AppColors.primaryColor,
                  validator: (value) {
                    return FormValidators.emptyValidate(value);
                  },
                ),
                const SizedBox(height: 20),
                FooterButton(
                  label: "Proceed",
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<RefundBloc>().add(SendRefundRequestsEvent(
                          leavingDate: formattedDate(controller.text),
                          reason: reasonController.text));
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      CustomMessage(
                              context: context,
                              message: "Please select leaving date",
                              style: MessageStyle.error)
                          .show();
                    }
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          )),
    );
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("dd/MM/yyyy").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
