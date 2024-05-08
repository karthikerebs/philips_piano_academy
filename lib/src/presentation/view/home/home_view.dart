import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_silver_delegate.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/credit_class/widgets/select_branch.dart';
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
    isCheckRequestRenewal();
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
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status is StatusAuthFailure) {
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
                        /*  SliverPersistentHeader(
                            delegate: SliverAppBarDelegate(
                                minHeight: 50,
                                maxHeight: 50,
                                child: classSection(kSize))), */
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
                        SliverToBoxAdapter(
                            child: emergencyAndCreditClassDetails(kSize)),
                        SliverToBoxAdapter(
                          child: SizedBox(height: kSize.height * .03),
                        ),
                        isCheckRequestRenewal()
                            ? SliverToBoxAdapter(child: renewalRemainder(kSize))
                            : SliverToBoxAdapter(child: SizedBox()),
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kSize.width * .1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: kSize.height * 0.06,
                                  width: kSize.width,
                                  child: CommonButton(
                                      label: "Available Slots",
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectBranch(
                                                      classId: 1000,
                                                      showApplyButton: false,
                                                    )));
                                      }),
                                ),
                                SizedBox(height: kSize.height * .015),
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
                    // SizedBox(height: kSize.height * 0.0497),
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
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 3,
                    offset: const Offset(0, 4)),
              ],
              borderRadius: BorderRadius.circular(kSize.height * .01),
              // color: AppColors.redColor.withOpacity(.05),
              color: Colors.white,
              border: Border.all(
                  color: AppColors.redColor.withOpacity(.4), width: 2)),
          child: Row(
            children: [
              Flexible(
                child: Text(
                    'Your account subscription has expired. Please renew by clicking here to regain access to our services.',
                    textAlign: TextAlign.center,
                    style: AppTypography.dmSansRegular.copyWith(
                        color: const Color.fromARGB(255, 255, 0, 0),
                        fontSize: kSize.height * 0.02)),
              ),
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

  // bool isCheckRequestRenewal() {
  //   final state = context.read<ProfileBloc>().state;
  //   final validTo = state.profileData.profileDetails?.validTo;
  //   if (validTo != null) {
  //     return DateFormat("yyyy-MM-dd").parse(validTo).isBefore(DateTime.now());
  //   } else {
  //     // Handle the case where profile data is not available
  //     return false;
  //   }
  // }

  bool isCheckRequestRenewal() {
    final state = context.read<ProfileBloc>().state;
    final DateTime validTo = DateFormat("yyyy-MM-dd")
        .parse(state.profileData.profileDetails!.validTo!);
    // .parse("2025-12-31");
    DateTime currentDate = DateTime.now();
    return validTo.isBefore(currentDate);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FooterButton(
          // padding: EdgeInsets.symmetric(horizontal: 0),
          label: 'Book a Slot',
          fontSize: 10,
          onPressed: () {
            Navigator.pushNamed(context, RouterConstants.creditClassRoute);
          },
        ),
        FooterButton(
          // padding: EdgeInsets.symmetric(horizontal: 0),
          label: 'Cancel Class',
          fontSize: 10,
          onPressed: () {
            Navigator.pushNamed(context, RouterConstants.normalClassRoute);
          },
        ),
      ],
    );
  }

  Widget emergencyAndCreditClassDetails(Size kSize) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            width: kSize.width,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Credit Class Count :',
                  style: AppTypography.dmSansMedium.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.02)),
              SizedBox(height: 5),
              Text(
                  '• Pending Credits : ${state.homeData.creditClassCnt != null ? state.homeData.creditClassCnt : "0"}',
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.015)),
              SizedBox(height: 10),
              FooterButton(
                padding: EdgeInsets.symmetric(horizontal: 22),
                label: 'Book a Slot',
                fontSize: 10,
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouterConstants.creditClassRoute);
                },
              ),
              SizedBox(height: 10),
              Text('Emergency Cancel Count :',
                  style: AppTypography.dmSansMedium.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.02)),
              SizedBox(height: 5),
              Text(
                  '• Emergency Cancellations : ${state.homeData.emergencyCancel != null ? state.homeData.emergencyCancel : "0"}',
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.015)),
              SizedBox(height: 10),
              FooterButton(
                padding: EdgeInsets.symmetric(horizontal: 15),
                label: 'Cancel Class',
                fontSize: 10,
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouterConstants.normalClassRoute);
                },
              ),
            ]),
          ),
        );
      },
    );
  }
}
