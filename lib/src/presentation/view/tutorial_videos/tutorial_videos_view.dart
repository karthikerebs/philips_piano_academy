import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/domain/models/response_models/tutorial_video_model/video.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';

class TutorialVideosView extends StatefulWidget {
  const TutorialVideosView({super.key});

  @override
  State<TutorialVideosView> createState() => _TutorialVideosViewState();
}

class _TutorialVideosViewState extends State<TutorialVideosView> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kSize.height * .05,
                ),
                CustomBackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: kSize.height * 0.028,
                ),
                Center(
                  child: Text(
                    'Video Tutorials',
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.0284),
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.0189,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.status is StatusLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.blackColor),
                      );
                    } else if (state.status is StatusSuccess) {
                      return Expanded(
                          child: ListView.builder(
                        itemCount: state.videoList.length,
                        padding: const EdgeInsets.only(top: 0, bottom: 0),
                        itemBuilder: (context, index) {
                          return videoTile(kSize, state.videoList[index]);
                        },
                      ));
                    } else if (state.status is StatusFailure) {
                      final status = state.status as StatusFailure;
                      return Center(
                        child: Text(status.errorMessage),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget videoTile(Size kSize, Video tutorialVideoData) {
    return Container(
      margin: EdgeInsets.only(bottom: kSize.height * 0.0094),
      width: kSize.width,
      padding: EdgeInsets.symmetric(
          vertical: kSize.height * 0.0236, horizontal: kSize.width * 0.044),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSize.height * 0.0236),
          border: Border.all(color: AppColors.primaryColor)),
      child: Row(children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSize.height * 0.0118)),
          child: Image.network(
            "https://img.youtube.com/vi/${getVideoID(tutorialVideoData.link ?? '')}/0.jpg",
            height: kSize.height * 0.15640,
            fit: BoxFit.cover,
          ) /* Image.asset(AppImages.tutorialVideoBg,
              height: kSize.height * 0.0936) */
          ,
        ),
        SizedBox(width: kSize.width * 0.052),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: kSize.width * .3,
              child: Text(
                /* 'Getting Started with Rythm' */ tutorialVideoData.title ??
                    "",
                maxLines: 2,
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.0165),
              ),
            ),
            SizedBox(height: kSize.height * .01),
            InkWell(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onTap: () {
                Navigator.pushNamed(
                    context, RouterConstants.tutorialVideoDetailRoute,
                    arguments: tutorialVideoData);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: kSize.height * .01,
                    horizontal: kSize.width * .06),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(kSize.height * 0.118)),
                child: Text(
                  "Watch Video",
                  style: AppTypography.dmSansMedium.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: kSize.height * 0.0118),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  String getVideoID(String url) {
    url = url.replaceAll("https://www.youtube.com/watch?v=", "");
    url = url.replaceAll("https://m.youtube.com/watch?v=", "");
    return url;
  }
}
