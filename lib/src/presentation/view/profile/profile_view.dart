import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/profile/widgets/custom_list_tile.dart';
import 'package:music_app/src/presentation/view/profile/widgets/delete_account_dialog.dart';
import 'package:music_app/src/presentation/view/profile/widgets/logout_dialog.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      height: kSize.height,
      width: kSize.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(children: [
          // SizedBox(height: kSize.height * .07),
          BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state.status is StatusAuthFailure) {
                CustomMessage(
                        context: context,
                        message: 'Access Denied. Kindly reauthenticate.',
                        style: MessageStyle.error)
                    .show();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.splashRoute, (route) => false);
              }
            },
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // alignment: Alignment.center,
                    clipBehavior: Clip.hardEdge,
                    height: kSize.height * 0.2,
                    // width: kSize.height * 0.1218,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle),
                    child: state.profileData.profileDetails!.photo == null
                        ? /* Image.asset(AppImages.placeHolder,
                            height: 65,
                            color: Colors
                                .white)  */
                        Image.network(
                            'https://www.prognos.com/sites/default/files/styles/profile_image/public/2020-06/profile-pic-placeholder.png?itok=x2Ckkfjo',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            fit: BoxFit.cover,
                            "${AppUrls.imageBaseUrl}${state.profileData.profileDetails!.photo}"),
                  ),
                  SizedBox(width: kSize.width * 0.054),
                  // Spacer(),
                  SizedBox(
                    width: kSize.width * .4,
                    height: kSize.height * .13,
                    child: FittedBox(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text:
                                      '${state.profileData.profileDetails!.name}',
                                  style: AppTypography.dmSansMedium.copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: kSize.height * 0.0236),
                                  children: [
                                TextSpan(
                                    text:
                                        ' ( ${state.profileData.profileDetails!.username ?? ''} )',
                                    style: AppTypography.dmSansMedium.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: kSize.height * 0.0236))
                              ])),
                          Text(
                            "Emergency Cancel : ${state.profileData.profileDetails!.emergencyCancel ?? ''}",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Slot : ${state.profileData.profileDetails!.sloteDay!} , ${formatedTime(state.profileData.profileDetails!.sloteTime!)}",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          state.profileData.profileDetails!.classMode ==
                                  "Offline"
                              ? Text(
                                  "Branch : ${state.profileData.profileDetails!.branch!}",
                                  style: TextStyle(fontSize: 12),
                                )
                              : SizedBox(),
                          state.profileData.profileDetails!.classMode ==
                                  "Offline"
                              ? SizedBox(
                                  height: 3,
                                )
                              : SizedBox(),
                          Text(
                            "Valid To : ${formattedDate(state.profileData.profileDetails!.validTo ?? '')}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // SizedBox(
          //   height: kSize.height * 0.01,
          // ),
          CustomListTile(
              label: 'Basic Details',
              image: AppImages.basic,
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.editProfileRoute);
              }),
          CustomListTile(
              label: 'Regular Class',
              image: AppImages.resedulw,
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.normalClassRoute);
              }),
          CustomListTile(
              label: 'Credit Class',
              image: AppImages.creditClassIcon,
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.creditClassRoute);
              }),
          CustomListTile(
              label: 'Paid Class',
              image: AppImages.paidClassIcon,
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.paidClassRoute);
              }),
          /*    CustomListTile(
              image: AppImages.transcation,
              label: 'installments',
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.installemntsView);
              }), */
          CustomListTile(
              image: AppImages.calendar,
              label: 'Repayment',
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.refundRoute);
              }),
          CustomListTile(
              image: AppImages.renewalIcon,
              label: 'Renewal',
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.renewalRoute);
              }),
          CustomListTile(
              label: 'Activities',
              image: AppImages.activityIcon,
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.activitiesRoute);
              }),
          CustomListTile(
              label: 'Change Password',
              image: AppImages.passwordIcon,
              onTap: () {
                Navigator.pushNamed(
                    context, RouterConstants.changePasswordRoute);
              }),
          CustomListTile(
              image: AppImages.suppoert,
              label: 'Support',
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.supportRoute);
              }),
          CustomListTile(
              image: AppImages.settings,
              label: 'Settings',
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.settingsRoute);
              }),
          CustomListTile(
              image: AppImages.transcation,
              label: 'Payment History',
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.transactionsRoute);
              }),
          CustomListTile(
              image: AppImages.logoutIcon,
              label: 'Logout',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return LogoutDialog();
                    });
              }),
          CustomListTile(
              image: AppImages.deleteIcon,
              label: 'Delete Account',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteAccountDialog();
                    });
              }),
        ]),
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

  String formatedTime(String timeString) {
    DateTime time = DateFormat.Hms().parse(timeString);
    // Format the time to AM/PM format
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }
}
