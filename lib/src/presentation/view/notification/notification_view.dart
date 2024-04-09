import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(const GetNotiFyCount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.notificationStatus is StatusAuthFailure) {
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
            if (state.notificationStatus is StatusLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.blackColor),
              );
            } else if (state.notificationStatus is StatusSuccess) {
              if (state.notificationList.isNotEmpty) {
                return ListView.builder(
                    padding: EdgeInsets.only(top: kSize.height * .1),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: AppColors.blackColor)
                              : const SizedBox(),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.blackColor)),
                                color: AppColors.secondaryColor,
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(.2))
                                ]),
                            padding: EdgeInsets.symmetric(
                                vertical: kSize.height * 0.02,
                                horizontal: kSize.width * 0.047),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        state.notificationList[index].title ??
                                            "",
                                        style: AppTypography.dmSansBold
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontSize:
                                                    kSize.height * 0.025)),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      height: 40,
                                      width: kSize.width * .6,
                                      child: Text(
                                          state.notificationList[index].msg!
                                              .replaceAll(
                                                  RegExp(r'<[^>]*>|&[^;]+;'),
                                                  ""),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: AppTypography.dmSansRegular
                                              .copyWith(
                                                  color: AppColors.greyColor,
                                                  fontSize:
                                                      kSize.height * 0.023)),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                    formatDate(state
                                        .notificationList[index].createdAt!),
                                    style: AppTypography.dmSansRegular.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: kSize.height * 0.018)),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: state.notificationList.length);
              } else {
                return const Center(child: Text('No notifications found!'));
              }
            } else if (state.notificationStatus is StatusFailure) {
              final status = state.notificationStatus as StatusFailure;
              return Center(
                child: Text(status.errorMessage),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }

  String formatDate(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM dd, yyyy').format(date);
    }
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isYesterday(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }
}
