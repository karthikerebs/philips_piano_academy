import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/domain/core/pref_key/preference_key.dart';
import 'package:music_app/src/infrastructure/core/preference_helper.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../application/profile/profile_bloc.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:pub_semver/pub_semver.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state.status is StatusLoading) {
                // CustomLoading.show(context);
              } else if (state.status is StatusSuccess) {
                if (state.profileData.profileDetails != null) {
                  context.read<HomeBloc>().add(const GetHomeEvent());
                  context.read<HomeBloc>().add(const GetBlogsDataEvent());
                  context.read<HomeBloc>().add(const GetVideosDataEvent());
                  context.read<ProfileBloc>().add(const GetNotiFyCount());
                } else {
                  context.read<ProfileBloc>().add(GetBasicDetailsEvent());
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouterConstants.slotSelectionRoute, (route) => false);
                }
              } else if (state.status is StatusFailure) {
                final status = state.status as StatusFailure;
                CustomMessage(
                        context: context,
                        message: status.errorMessage,
                        style: MessageStyle.error)
                    .show();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.loginRoute, (route) => false);
              } else if (state.status is StatusAuthFailure) {
                CustomMessage(
                        context: context,
                        message: 'Access Denied. Kindly reauthenticate.',
                        style: MessageStyle.error)
                    .show();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.loginRoute, (route) => false);
              }
            },
            listenWhen: (previous, current) =>
                previous.status != current.status,
          ),
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status is StatusLoading) {
              } else if (state.status is StatusSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.bottomNavRoute, (route) => false,
                    arguments: 0);
              } else if (state.status is StatusFailure) {
                final status = state.status as StatusFailure;
                CustomMessage(
                        context: context,
                        message: status.errorMessage,
                        style: MessageStyle.error)
                    .show();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.loginRoute, (route) => false);
              } else if (state.status is StatusAuthFailure) {
                CustomMessage(
                        context: context,
                        message: 'Access Denied. Kindly reauthenticate.',
                        style: MessageStyle.error)
                    .show();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.loginRoute, (route) => false);
              }
            },
          ),
        ],
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Center(
            child: Image.asset(AppImages.logo, height: kSize.height * 0.294),
          ),
        ),
      ),
    );
  }

  void navigate() async {
    await checkAppVersionAndRedirect(context);
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (await PreferenceHelper().getBool(key: AppPrefeKeys.logged)) {
        if (await PreferenceHelper().getString(key: AppPrefeKeys.token) == '') {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouterConstants.loginRoute, (route) => false);
          }
        } else {
          if (mounted) {
            context.read<ProfileBloc>().add(const GetProfileDataEvent());
            context.read<ProfileBloc>().add(GetBasicDetailsEvent());
          }
        }
      } else {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouterConstants.loginRoute, (route) => false);
        }
      }
    });
  }
}

Future<void> checkAppVersionAndRedirect(BuildContext context) async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  final String currentVersion = info.version;
  final String minimumRequiredVersion = "3.0.7";
  print(minimumRequiredVersion);
  print(currentVersion);

  if (Version.parse(currentVersion) < Version.parse(minimumRequiredVersion)) {
    // Show a dialog or prompt the user before redirection (optional)
    final shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Update Available'),
        content: Text(
            'A new version of the app is available. Please update to continue.'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shadowColor: const Color(0x44000000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
            ),
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shadowColor: const Color(0x44000000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text('Update Now'),
          ),
        ],
      ),
    );

    if (shouldUpdate ?? false) {
      await StoreRedirect.redirect(
          androidAppId: "com.philipspianoacademy.music",
          iOSAppId: "6476094882");
    }
  }
}
