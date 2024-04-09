import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';

class CancelMultipleClassView extends StatefulWidget {
  const CancelMultipleClassView({super.key});

  @override
  State<CancelMultipleClassView> createState() =>
      _CancelMultipleClassViewState();
}

class _CancelMultipleClassViewState extends State<CancelMultipleClassView> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  var dateFormat = DateFormat('dd/MM/yyyy');
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: kSize.width * 0.12,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: kSize.width * 0.04),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * .08),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('From',
                style: AppTypography.dmSansRegular.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.028)),
            SizedBox(height: kSize.height * .01),
            CustomDatePicker(
              dateController: fromDateController,
              errorMessage: '',
              hintText: 'Select Date',
              firstDate: DateTime.now(),
              hintColor: AppColors.primaryColor,
              onChanged: (value) {
                fromDateController.text = dateFormat.format(value);
              },
            ),
            Text('To',
                style: AppTypography.dmSansRegular.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.028)),
            SizedBox(height: kSize.height * .01),
            CustomDatePicker(
              dateController: toDateController,
              errorMessage: '',
              hintColor: AppColors.primaryColor,
              hintText: 'Select Date',
              onChanged: (value) {
                toDateController.text = dateFormat.format(value);
              },
            ),
            SizedBox(height: kSize.height * .03),
            BlocListener<NormalClassBloc, NormalClassState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status is StatusSuccess) {
                  CustomMessage(
                          context: context,
                          message: "Cancelled successfully",
                          style: MessageStyle.success)
                      .show();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouterConstants.bottomNavRoute, (route) => false,
                      arguments: 2);
                } else if (state.status is StatusLoading) {
                  CustomLoading.show(context);
                } else if (state.status is StatusFailure) {
                  final status = state.status as StatusFailure;
                  CustomMessage(
                          context: context,
                          message: status.errorMessage,
                          style: MessageStyle.error)
                      .show();
                  CustomLoading.dissmis(context);
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
                child: FooterButton(
                  label: 'Apply',
                  onPressed: () {
                    context.read<NormalClassBloc>().add(
                        CancelMulitpleClassEvent(
                            fromDate: formattedDate(fromDateController.text),
                            reason: reasonController.text,
                            toDate: formattedDate(toDateController.text)));
                  },
                  padding: EdgeInsets.symmetric(
                      horizontal: kSize.width * .17,
                      vertical: kSize.height * .023),
                ),
              ),
            )
          ]),
        ),
      ),
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
