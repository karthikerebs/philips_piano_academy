import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/domain/models/response_models/cancelled_class_model/cancelled_class.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';

class CancelledClassDetails extends StatelessWidget {
  const CancelledClassDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return BlocConsumer<NormalClassBloc, NormalClassState>(
      listener: (context, state) {
        if (state.cancelClassStatus is StatusAuthFailure) {
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
      builder: (context, state) {
        if (state.cancelClassStatus is StatusLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state.cancelClassStatus is StatusSuccess) {
          if (state.cancelledClassList.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.cancelledClassList.length,
              padding: EdgeInsets.only(top: kSize.height * .04),
              itemBuilder: (context, index) {
                return cancelledClassTile(
                    kSize, index, state.cancelledClassList);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  color: AppColors.greyColor,
                  thickness: 1,
                );
              },
            );
          } else {
            return const Center(
              child: Text('No cancelled class found!'),
            );
          }
        } else if (state.cancelClassStatus is StatusFailure) {
          final status = state.cancelClassStatus as StatusFailure;
          return Center(
            child: Text(status.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget cancelledClassTile(
      Size kSize, int index, List<CancelledClass> cancelClasses) {
    return Column(
      children: [
        index == 0
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: kSize.height * 0.0343, horizontal: kSize.width * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(index < 9 ? 'Class 0${index + 1}' : "Class ${index + 1}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.028)),
                  SizedBox(height: kSize.height * .01),
                  Text(
                      /* '30/08/2023' */ formattedDate(
                          cancelClasses[index].classDate ?? ""),
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                ],
              ),
              Text(
                "Cancelled",
                style: AppTypography.dmSansRegular.copyWith(
                    color: AppColors.greyColor,
                    fontSize: kSize.height * 0.0189),
              )
            ],
          ),
        ),
        index == cancelClasses.length - 1
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox()
      ],
    );
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMM, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
