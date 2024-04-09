import 'package:flutter/material.dart';
import 'package:music_app/src/domain/models/response_models/tutorial_video_model/video.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialVideosDetailView extends StatefulWidget {
  const TutorialVideosDetailView({super.key, required this.tutorialVideoData});
  final Video tutorialVideoData;
  @override
  State<TutorialVideosDetailView> createState() =>
      _TutorialVideosDetailViewState();
}

class _TutorialVideosDetailViewState extends State<TutorialVideosDetailView>
    with AutomaticKeepAliveClientMixin {
  final videoId = ValueNotifier("");
  late YoutubePlayerController _controller;
  @override
  void initState() {
    getVideoId(widget.tutorialVideoData.link!);
    _controller = YoutubePlayerController(
      initialVideoId: videoId.value,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kSize.height * .05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize.width * .05),
                child: CustomBackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: kSize.height * 0.028,
              ),
              SizedBox(
                height: kSize.height * .28,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                ),
              ),
              SizedBox(height: kSize.height * .02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize.width * .05),
                child: Text('${widget.tutorialVideoData.title}',
                    style: AppTypography.quickSandsBold.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.024)),
              ),
              SizedBox(height: kSize.height * .01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize.width * .05),
                child: Text(
                    widget.tutorialVideoData.details != null
                        ? '${widget.tutorialVideoData.details.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), "")}'
                        : "",
                    style: AppTypography.quickSandRegular.copyWith(
                        color: AppColors.greyColor,
                        fontSize: kSize.height * 0.018)),
              ),
            ],
          )),
    );
  }

  getVideoId(String link) {
    videoId.value = YoutubePlayer.convertUrlToId(link)!;
    print(videoId.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
