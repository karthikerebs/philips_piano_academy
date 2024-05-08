import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';

class ActivitiesView extends StatefulWidget {
  const ActivitiesView({super.key});

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetActivitiesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: "Activities"),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.activityStatus is StatusAuthFailure) {
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
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state.activityStatus is StatusLoading) {
                      return Column(
                        children: [
                          SizedBox(
                            height: kSize.height * .1,
                          ),
                          Center(
                              child: CircularProgressIndicator(
                            color: AppColors.blackColor,
                          )),
                        ],
                      );
                    } else if (state.activityStatus is StatusSuccess) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: state.activityList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(.01),
                                            blurRadius: 40,
                                            offset: Offset(1, 1),
                                            spreadRadius: 30),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formattedDate(
                                            "${state.activityList[index].date}"),
                                        style: AppTypography.dmSansBold
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontSize: kSize.height * 0.02),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          "${state.activityList[index].activity}",
                                          style: AppTypography.dmSansRegular
                                              .copyWith(
                                                  color: AppColors.blackColor,
                                                  fontSize:
                                                      kSize.height * 0.02))
                                    ],
                                  ),
                                );
                              }));
                    } else if (state.activityStatus is StatusFailure) {
                      final status = state.activityStatus as StatusFailure;
                      return Column(
                        children: [
                          const SizedBox(height: 150),
                          Center(
                            child: Text(status.errorMessage),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
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
