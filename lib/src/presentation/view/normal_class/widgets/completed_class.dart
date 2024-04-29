import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/domain/models/response_models/completed_class_model/completed_class.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';

class CompletedClassDetails extends StatefulWidget {
  const CompletedClassDetails({super.key});

  @override
  State<CompletedClassDetails> createState() => _CompletedClassDetailsState();
}

class _CompletedClassDetailsState extends State<CompletedClassDetails> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return BlocConsumer<NormalClassBloc, NormalClassState>(
      listener: (context, state) {
        if (state.completedClassStatus is StatusAuthFailure) {
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
        if (state.completedClassStatus is StatusLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state.completedClassStatus is StatusSuccess) {
          if (state.completedClassList.isNotEmpty) {
            return ListView.separated(
              itemCount: state.completedClassList.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: kSize.height * .04),
              itemBuilder: (context, index) {
                return completedClassTile(
                    kSize, index, state.completedClassList);
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
              child: Text('No completed class found!'),
            );
          }
        } else if (state.completedClassStatus is StatusFailure) {
          final status = state.completedClassStatus as StatusFailure;
          return Center(
            child: Text(status.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget completedClassTile(
      Size kSize, int index, List<CompletedClass> completedClassData) {
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
                  Text(index < 9 ? 'Class 0${index + 1}' : 'Class ${index + 1}',
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.028)),
                  SizedBox(height: kSize.height * .01),
                  Text(formattedDate(completedClassData[index].atDate ?? ""),
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                ],
              ),
              Column(
                children: [
                  completedClassData[index].extraStatus!
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xFF2A832D)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                          child: Text(
                            "Extra",
                            style: TextStyle(
                                color: AppColors.secondaryColor, fontSize: 12),
                          ),
                          alignment: Alignment.center)
                      : const SizedBox(),
                  CommonButton(
                    label: "View Notes",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouterConstants.noteDetailsRoute,
                          arguments: [
                            "Class 0${index + 1}",
                            completedClassData[index].id.toString()
                          ]);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        index == completedClassData.length - 1
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
