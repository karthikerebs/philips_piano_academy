import 'package:flutter/material.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class TutorialVideoDetails extends StatelessWidget {
  const TutorialVideoDetails({super.key, required this.state});
  final HomeState state;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: state.videoList.length,
      primary: false,
      padding: EdgeInsets.only(top: 0, bottom: kSize.height * .13),
      shrinkWrap: true,
      itemBuilder: (context, index) {
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
                width: kSize.height * 0.15640,
                height: kSize.height * 0.15640,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSize.height * 0.0236)),
                child: Image.network(
                  "https://img.youtube.com/vi/${getIdFromUrl(state.videoList[index].link ?? "")}/0.jpg",
                  height: kSize.height * 0.15640,
                  fit: BoxFit.cover,
                ) /*  Image.asset(
                  AppImages.blogBg,
                  height: kSize.height * 0.15640,
                  fit: BoxFit.cover,
                ) */
                ),
            SizedBox(width: kSize.width * 0.052),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: kSize.width * .3,
                  child: Text(
                    /* 'Getting Started with Rythm' */ state
                            .videoList[index].title ??
                        '',
                    maxLines: 2,
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.0165),
                  ),
                ),
                SizedBox(height: kSize.height * .01),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouterConstants.tutorialVideoDetailRoute,
                        arguments: state.videoList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: kSize.height * .01,
                        horizontal: kSize.width * .045),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius:
                            BorderRadius.circular(kSize.height * 0.118)),
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
      },
    );
  }

  String getVideoID(String url) {
    url = url.replaceAll("https://www.youtube.com/watch?v=", "");
    url = url.replaceAll("https://m.youtube.com/watch?v=", "");
    return url;
  }

  String getIdFromUrl(String url) {
    String? videoId;
    if (url.contains('youtu.be/')) {
      videoId = url.split('youtu.be/')[1].split('?')[0];
    } else if (url.contains('watch?v=')) {
      videoId = url.split('watch?v=')[1].split('&')[0];
    }

    return videoId!;
  }
}
