import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/core/widgets/validators.dart';

class CancelDialogBox {
  final BuildContext parentContext;
  final TextEditingController reasonController;
  final String date;
  final bool isEmergencyCancel;
  const CancelDialogBox(
      {required this.parentContext,
      required this.reasonController,
      required this.date,
      required this.isEmergencyCancel});
  show() {
    final kSize = MediaQuery.of(parentContext).size;
    final formKey = GlobalKey<FormState>();
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
          contentPadding: EdgeInsets.only(
              left: kSize.width * .06,
              bottom: kSize.height * .04,
              right: kSize.width * .06),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: kSize.height * .015),
                CustomTextField(
                  hintText: 'Type your reason here',
                  controller: reasonController,
                  maxLines: 7,
                  fillColor: AppColors.lightgreyColor1,
                  errorMessage: "Please enter reason",
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.redColor),
                      borderRadius: BorderRadius.circular(kSize.height * .013)),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.transparent),
                      borderRadius: BorderRadius.circular(kSize.height * .013)),
                  validator: (value) {
                    return FormValidators.emptyValidate(value);
                  },
                ),
                SizedBox(height: kSize.height * .03),
                BlocListener<NormalClassBloc, NormalClassState>(
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  listener: (context, state) {
                    if (state.status is StatusLoading) {
                      CustomLoading.show(context);
                    } else if (state.status is StatusSuccess) {
                      Navigator.pop(context);
                      CustomLoading.dissmis(context);
                      if (isEmergencyCancel) {
                        context.read<ProfileBloc>().add(GetProfileDataEvent());
                        CustomMessage(
                                context: context,
                                message:
                                    "Class cancelled successfully. You now have ${state.emergencyCancelData.emergencyCancelPrnding} remaining emergency class cancellations",
                                style: MessageStyle.success)
                            .show();
                      } else {
                        CustomMessage(
                                context: context,
                                message:
                                    "Class cancelled successfully. You now have 1 credit class remaining for booking.",
                                style: MessageStyle.success)
                            .show();
                      }

                      refresh(context);
                    } else if (state.status is StatusFailure) {
                      final status = state.status as StatusFailure;
                      CustomLoading.dissmis(context);
                      CustomMessage(
                              context: context,
                              message: status.errorMessage,
                              style: MessageStyle.error)
                          .show();
                      Navigator.pop(context);
                    } else if (state.status is StatusAuthFailure) {
                      CustomMessage(
                              context: context,
                              message: 'Access Denied. Kindly reauthenticate.',
                              style: MessageStyle.error)
                          .show();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouterConstants.splashRoute,
                        (route) => false,
                      );
                    }
                  },
                  child: Center(
                      child: CommonButton(
                    label: "Submit",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (isEmergencyCancel) {
                          context.read<NormalClassBloc>().add(
                              EmergencyCancelEvent(
                                  date: date, reason: reasonController.text));
                        } else {
                          context.read<NormalClassBloc>().add(CancelClassEvent(
                              date: date, reason: reasonController.text));
                        }
                      }
                    },
                  )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void refresh(BuildContext context) {
    context.read<NormalClassBloc>().add(const UpcomingClassEvent());
    context.read<NormalClassBloc>().add(const CompletedClassEvent());
    context.read<NormalClassBloc>().add(const GetCanceledClassEvent());
  }
}
