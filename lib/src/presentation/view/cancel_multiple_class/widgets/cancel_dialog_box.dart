import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';

class CancelMultipleDialogBox {
  final BuildContext parentContext;
  final TextEditingController reasonController;
  final String fromDate;
  final String toDate;
  const CancelMultipleDialogBox(
      {required this.parentContext,
      required this.reasonController,
      required this.fromDate,
      required this.toDate});
  show() {
    final kSize = MediaQuery.of(parentContext).size;
    return showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: kSize.width * 0.040),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kSize.height * 0.030)),
          title: Center(
            child: Text('Reason for cancellation',
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.0284)),
          ),
          actionsPadding: EdgeInsets.only(
              left: kSize.width * .06,
              bottom: kSize.height * .04,
              right: kSize.width * .06),
          actions: [
            CustomTextField(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(kSize.height * .013)),
              hintText: 'Type your reason here',
              controller: reasonController,
              maxLines: 7,
              fillColor: AppColors.lightgreyColor1,
            ),
            SizedBox(height: kSize.height * .03),
            Center(
              child: InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () {
                  context.read<NormalClassBloc>().add(CancelMulitpleClassEvent(
                      fromDate: fromDate,
                      toDate: toDate,
                      reason: reasonController.text));
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: kSize.height * 0.014,
                      horizontal: kSize.width * .08),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.circular(kSize.height * 0.118)),
                  child: Text(
                    "Submit",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: kSize.height * 0.0189),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
