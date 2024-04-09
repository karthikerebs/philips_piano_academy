import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/custom_silver_delegate.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/home/widgets/blog_details.dart';
import 'package:music_app/src/presentation/view/home/widgets/tutorial_videos_details.dart';
import 'package:music_app/src/presentation/view/home/widgets/weekly_attendace.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeBloc>().add(const GetNotificationEvent());
    checkRenewel();
    super.initState();
  }

  final List<String> titles = ["133", "qwert", "qwerty"];
  final isRenewPlan = ValueNotifier(false);
  int differenceInDays = 0;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const GetBlogsDataEvent());
            context.read<HomeBloc>().add(const GetVideosDataEvent());
            context.read<HomeBloc>().add(const GetHomeEvent());
          },
          color: AppColors.primaryColor,
          child: ValueListenableBuilder(
            valueListenable: isRenewPlan,
            builder: (context, dynamic, child) {
              return BlocConsumer<HomeBloc, HomeState>(
                listenWhen: (previous, current) =>
                    previous.notificationStatus != current.notificationStatus,
                listener: (context, state) {
                  if (state.notificationStatus is StatusAuthFailure) {
                    log("${state.homeData}");
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
                  if (state.status is StatusLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.blackColor),
                    );
                  } else if (state.status is StatusSuccess) {
                    return CustomScrollView(
                      slivers: [
                        SliverPersistentHeader(
                            pinned: true,
                            floating: false,
                            delegate: SliverAppBarDelegate(
                                minHeight: kSize.height * 0.187,
                                maxHeight: kSize.height * 0.187,
                                child: appBar(kSize))),
                        SliverPersistentHeader(
                            delegate: SliverAppBarDelegate(
                                minHeight: 150,
                                maxHeight: 150,
                                child: classDetails(kSize))),
                        SliverPersistentHeader(
                            delegate: SliverAppBarDelegate(
                                minHeight: 50,
                                maxHeight: 50,
                                child: classSection(kSize))),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 15,
                          ),
                        ),
                        SliverPersistentHeader(
                            delegate: SliverAppBarDelegate(
                                minHeight: state.homeData.creditClass != null
                                    ? state.homeData.creditClass!.isNotEmpty
                                        ? kSize.height * .4
                                        : kSize.height * .23
                                    : kSize.height * .23,
                                maxHeight: state.homeData.creditClass != null
                                    ? state.homeData.creditClass!.isNotEmpty
                                        ? kSize.height * .4
                                        : kSize.height * .23
                                    : kSize.height * .23,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kSize.width * .1),
                                  child: Container(
                                    width: kSize.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kSize.width * 0.065,
                                        vertical: kSize.height * 0.028),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                        borderRadius: BorderRadius.circular(
                                            kSize.height * 0.023)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              /*  'Your ${DateFormat("MMMM").format(DateTime.now())} Classes' */ "Upcoming Regular Classes",
                                              style: AppTypography.dmSansMedium
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: kSize.height *
                                                          0.0189)),
                                          SizedBox(
                                            height: kSize.height * 0.061,
                                          ),
                                          BlocBuilder<HomeBloc, HomeState>(
                                            builder: (context, state) {
                                              return WeeklyAttendence(
                                                creditClassdates: state
                                                        .homeData.creditClass ??
                                                    [],
                                                dates: state.homeData
                                                        .upcomingClass ??
                                                    [],
                                              );
                                            },
                                          ),
                                          SizedBox(
                                              height: kSize.height * 0.041),
                                        ]),
                                  ),
                                ))),
                        SliverToBoxAdapter(
                          child: SizedBox(height: kSize.height * .03),
                        ),
                        isRenewPlan.value
                            ? SliverToBoxAdapter(child: renewalRemainder(kSize))
                            : SliverToBoxAdapter(child: SizedBox()),
                        /*           SliverToBoxAdapter(child:
                            BlocBuilder<InstallmentBloc, InstallmentState>(
                          builder: (context, state) {
                            if (state.pendingInstallment.isNotEmpty) {
                              return paymentdue(kSize);
                            } else {
                              return const SizedBox();
                            }
                          },
                        )), */
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kSize.width * .1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'New Blogs',
                                      style: AppTypography.dmSansMedium
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: kSize.height * 0.0284),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              RouterConstants.latestBlogRoute);
                                        },
                                        child: Text('View all>',
                                            style: AppTypography.dmSansMedium
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize:
                                                        kSize.height * 0.0213)))
                                  ],
                                ),
                                SizedBox(
                                  height: kSize.height * .015,
                                ),
                                BlogDetails(state: state),
                                SizedBox(height: kSize.height * 0.041),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'New Videos',
                                      style: AppTypography.dmSansMedium
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: kSize.height * 0.0284),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              RouterConstants
                                                  .tutorialVideoRoute);
                                        },
                                        child: Text('View all>',
                                            style: AppTypography.dmSansMedium
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize:
                                                        kSize.height * 0.0213)))
                                  ],
                                ),
                                SizedBox(
                                  height: kSize.height * .015,
                                ),
                                TutorialVideoDetails(state: state),
                              ],
                            ),
                          )
                        ]))
                      ],
                    );
                  } else if (state.status is StatusFailure) {
                    final status = state.status as StatusFailure;
                    return Center(
                      child: Text(status.errorMessage),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
        ));
  }

  Widget appBar(Size kSize) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          color: AppColors.secondaryColor,
          padding: EdgeInsets.only(
              left: kSize.width * .1,
              right: kSize.width * .1,
              top: kSize.height * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text("Welcome",
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.022)),
              ),
              FittedBox(
                alignment: Alignment.topLeft,
                clipBehavior: Clip.none,
                child: Text("\n${state.profileData.profileDetails!.name} 🥳",
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        height: .8,
                        fontSize: kSize.height * 0.0402)),
              ),
              // SizedBox(height: kSize.height * .03),
            ],
          ),
        );
      },
    );
  }

  Widget classDetails(Size kSize) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.homeVector,
                  height: kSize.height * 0.140,
                ),
                SizedBox(width: kSize.width * 0.0444),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Next Class:',
                        style: AppTypography.dmSansMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: kSize.height * 0.0189)),
                    SizedBox(height: kSize.height * 0.0094),
                    state.homeData.nextClass != ""
                        ? state.homeData.nextClass != null
                            ? Text(
                                /* 'Wednesday\n2:30 PM' */ "${DateFormat("dd, MMMM").format(DateTime.parse(state.homeData.nextClass!))}\n${formatedTime(state.homeData.sloteTime!) /* DateFormat.jm().format(DateFormat("hh:mm:ss").parse(state.homeData.sloteTime!)) */}",
                                style: AppTypography.dmSansMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: kSize.height * 0.0355))
                            : Text("There are no classes scheduled!")
                        : Text("There are no classes scheduled!"),
                    SizedBox(height: kSize.height * 0.0497),
                  ],
                )
              ]),
        );
      },
    );
  }

  String formatedTime(String timeString) {
    DateTime time = DateFormat.Hms().parse(timeString);
    // Format the time to AM/PM format
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  Widget renewalRemainder(Size kSize) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouterConstants.renewalRoute);
      },
      child: Container(
          width: kSize.width,
          margin: EdgeInsets.symmetric(horizontal: kSize.width * .1),
          padding: EdgeInsets.symmetric(
              horizontal: kSize.width * .04, vertical: kSize.height * .02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSize.height * .01),
              color: AppColors.redColor.withOpacity(.05),
              border: Border.all(color: AppColors.redColor.withOpacity(.4))),
          child: Row(
            children: [
              Flexible(
                child: Text(
                    'Time to renew!\n Ensure uninterrupted access by renewing your subscription.',
                    textAlign: TextAlign.center,
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.02)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: kSize.height * .01),
                    padding: EdgeInsets.symmetric(
                        horizontal: kSize.width * .04,
                        vertical: kSize.height * .02),
                    decoration: BoxDecoration(
                        color: AppColors.redColor.withOpacity(.2),
                        borderRadius:
                            BorderRadius.circular(kSize.height * .01)),
                    alignment: Alignment.center,
                    child: Text(
                        differenceInDays < 9
                            ? '0${differenceInDays}'
                            : "${differenceInDays}",
                        style: AppTypography.dmSansBold.copyWith(
                            color: AppColors.blackColor,
                            fontSize: kSize.height * 0.026)),
                  ),
                  Text('DAYS',
                      style: AppTypography.dmSansBold.copyWith(
                          color: AppColors.blackColor,
                          fontSize: kSize.height * 0.016))
                ],
              )
            ],
          )),
    );
  }

  void checkRenewel() {
    final state = context.read<ProfileBloc>().state;
    DateTime today = DateTime.now();
    DateTime validTo =
        DateTime.parse(state.profileData.profileDetails!.validTo!);
    differenceInDays = validTo.difference(today).inDays;
    int daysInMonth = 4;
    if (differenceInDays < daysInMonth) {
      isRenewPlan.value = true;
    } else {
      isRenewPlan.value = false;
    }
  }

  Widget paymentdue(Size kSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSize.width * .1),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: kSize.width * .04, vertical: kSize.height * .024),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.redColor.withOpacity(.35)),
          color: AppColors.redColor.withOpacity(.05),
          borderRadius: BorderRadius.circular(kSize.height * .01),
        ),
        child: Column(
          children: [
            Text('Remainder',
                textAlign: TextAlign.center,
                style: AppTypography.dmSansBold.copyWith(
                    color: AppColors.blackColor,
                    fontSize: kSize.height * 0.023)),
            SizedBox(height: kSize.height * .01),
            Text(
                'Your payment is due soon. Complete now to avoid interruptions.',
                textAlign: TextAlign.center,
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.02)),
          ],
        ),
      ),
    );
  }

  Widget classSection(Size kSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSize.width * .1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FooterButton(
            padding: EdgeInsets.symmetric(horizontal: 34),
            label: 'Book a Slot',
            onPressed: () {
              Navigator.pushNamed(context, RouterConstants.creditClassRoute);
            },
          ),
          FooterButton(
            padding: EdgeInsets.symmetric(horizontal: 24),
            label: 'Cancel Class',
            onPressed: () {
              Navigator.pushNamed(context, RouterConstants.normalClassRoute);
            },
          ),
        ],
      ),
    );
  }

  Future<void> buildDialog() async {
    await Future.delayed(Duration.zero).then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return PopScope(
              onPopInvoked: (value) {
                // Navigator.pop(context);
                SystemNavigator.pop();
              },
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Dialog(
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Container(
                        height: 130,
                        color: Colors.white,
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          children: [
                            Text(
                              'Success',
                              style: AppTypography.dmSansBold.copyWith(
                                  fontSize: 16, color: AppColors.blackColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Your slot is booked!.\n You will be notified once the admin approves your booking.',
                              textAlign: TextAlign.center,
                              style: AppTypography.dmSansRegular.copyWith(
                                  fontSize: 14, color: AppColors.blackColor),
                            ),
                          ],
                        )),
                  )),
            );
          });
    });
  }

  void setDialog() {
    final state = context.read<HomeBloc>().state;
    if (state.homeData.approval == 'Pending') {
      buildDialog();
    }
  }
}
