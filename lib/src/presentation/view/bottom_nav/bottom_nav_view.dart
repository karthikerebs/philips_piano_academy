import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/view/home/home_view.dart';
import 'package:music_app/src/presentation/view/notification/notification_view.dart';
import 'package:music_app/src/presentation/view/profile/profile_view.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key, this.selectedIndex = 0});
  final int selectedIndex;
  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  final PageStorageBucket pageBucket = PageStorageBucket();
  int selectedIndex = 0;
  List<Widget> pages = [
    const HomeView(),
    const NotificationView(),
    const ProfileView(),
  ];
  List<String> icons = [
    AppImages.homeIcon,
    AppImages.notificationIcon,
    AppImages.profileIcon
  ];
  List<String> pageNames = [
    AppStrings.home,
    AppStrings.notifications,
    AppStrings.profile,
  ];
  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setDialog();
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton:
          selectedIndex == 0 ? floatingActionButton(kSize) : const SizedBox(),
      extendBody: true,
      backgroundColor: AppColors.secondaryColor,
      bottomNavigationBar: bottomNavBar(kSize),
      body: PageStorage(bucket: pageBucket, child: pages[selectedIndex]),
    );
  }

  Widget bottomNavBar(Size kSize) {
    setDialog();
    return Container(
      height: kSize.height * 0.1,
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
          horizontal: kSize.width * 0.1138, vertical: kSize.height * 0.014),
      alignment: Alignment.center,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              3,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      buildWhen: (previous, current) =>
                          previous.countStatus != current.countStatus,
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            icons[index] == AppImages.notificationIcon
                                ? state.notifyCount.newNotifications != 0 &&
                                        state.notifyCount.newNotifications !=
                                            null
                                    ? Badge(
                                        label: Text(
                                          "${state.notifyCount.newNotifications}",
                                          style: TextStyle(
                                              color: AppColors.secondaryColor),
                                        ),
                                        child: Image.asset(
                                          icons[index],
                                          height: kSize.height * 0.0365,
                                          color: selectedIndex == index
                                              ? AppColors.secondaryColor
                                              : AppColors.greyColor,
                                        ),
                                      )
                                    : Image.asset(
                                        icons[index],
                                        height: kSize.height * 0.0365,
                                        color: selectedIndex == index
                                            ? AppColors.secondaryColor
                                            : AppColors.greyColor,
                                      )
                                : Image.asset(
                                    icons[index],
                                    height: kSize.height * 0.0365,
                                    color: selectedIndex == index
                                        ? AppColors.secondaryColor
                                        : AppColors.greyColor,
                                  ),
                            SizedBox(
                              height: kSize.height * .006,
                            ),
                            Text(
                              pageNames[index],
                              style: AppTypography.dmSansRegular.copyWith(
                                  fontSize: kSize.height * 0.0185,
                                  color: selectedIndex == index
                                      ? AppColors.secondaryColor
                                      : AppColors.greyColor),
                            )
                          ],
                        );
                      },
                    ),
                  ))),
    );
  }

  Widget floatingActionButton(Size kSize) {
    return InkWell(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onTap: () {
        Navigator.pushNamed(context, RouterConstants.chatRoute);
      },
      child: Container(
        alignment: Alignment.center,
        height: kSize.height * 0.073,
        width: kSize.height * 0.073,
        decoration: const BoxDecoration(
            color: AppColors.primaryColor, shape: BoxShape.circle),
        child: Image.asset(AppImages.chatIcon, height: kSize.height * 0.0473),
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
