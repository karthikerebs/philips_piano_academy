// import 'package:flutter/material.dart';
// import 'package:music_app/src/domain/models/response_models/tutorial_video_model/video.dart';
// import 'package:music_app/src/presentation/core/theme/colors.dart';
// import 'package:music_app/src/presentation/core/widgets/back_button.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class TutorialVideosDetailView extends StatefulWidget {
//   const TutorialVideosDetailView({super.key, required this.tutorialVideoData});
//   final Video tutorialVideoData;
//   @override
//   State<TutorialVideosDetailView> createState() =>
//       _TutorialVideosDetailViewState();
// }

// class _TutorialVideosDetailViewState extends State<TutorialVideosDetailView> {
//   final videoId = ValueNotifier("");
//   @override
//   void initState() {
//     getVideoId(widget.tutorialVideoData.link!);
//     /*    _controller = YoutubePlayerController(
//       initialVideoId: videoId.value,
//       flags: YoutubePlayerFlags(
//           hideControls: false,
//           autoPlay: true,
//           mute: false,
//           showLiveFullscreenButton: false),
//     ); */
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // super.build(context);
//     final kSize = MediaQuery.of(context).size;
//     final youtubeVideoWebViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse('${widget.tutorialVideoData.link}'));
//     return Scaffold(
//       backgroundColor: AppColors.secondaryColor,
//       body: SizedBox(
//           height: kSize.height,
//           width: kSize.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: kSize.height * .05,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: kSize.width * .1),
//                 child: CustomBackButton(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: kSize.height * 0.028,
//               ),
//               SizedBox(
//                   height: 300,
//                   child: WebViewWidget(
//                     controller: youtubeVideoWebViewController,
//                     // javascriptMode: JavascriptMode.unrestricted,
//                   )),
//             ],
//           )),
//     );
//     /* Scaffold(
//       backgroundColor: AppColors.secondaryColor,
//       body: SizedBox(
//           height: kSize.height,
//           width: kSize.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: kSize.height * .05,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: kSize.width * .05),
//                 child: CustomBackButton(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: kSize.height * 0.028,
//               ),
//               SizedBox(
//                 height: kSize.height * .28,
//                 child: YoutubePlayer(
//                   controller: _controller,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: Colors.blueAccent,
//                 ),
//               ),
//               SizedBox(height: kSize.height * .02),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: kSize.width * .05),
//                 child: Text('${widget.tutorialVideoData.title}',
//                     style: AppTypography.quickSandsBold.copyWith(
//                         color: AppColors.primaryColor,
//                         fontSize: kSize.height * 0.024)),
//               ),
//               SizedBox(height: kSize.height * .01),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: kSize.width * .05),
//                 child: Text(
//                     widget.tutorialVideoData.details != null
//                         ? '${widget.tutorialVideoData.details.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), "")}'
//                         : "",
//                     style: AppTypography.quickSandRegular.copyWith(
//                         color: AppColors.greyColor,
//                         fontSize: kSize.height * 0.018)),
//               ),
//             ],
//           )),
//     ) ; */
//   }

//   getVideoId(String link) {
//     videoId.value = YoutubePlayer.convertUrlToId(link)!;
//     print(videoId.value);
//   }
// }
import 'package:flutter/material.dart';
import 'package:music_app/src/domain/models/response_models/tutorial_video_model/video.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialVideosDetailView extends StatefulWidget {
  const TutorialVideosDetailView({super.key, required this.tutorialVideoData});
  final Video tutorialVideoData;

  @override
  State<TutorialVideosDetailView> createState() =>
      _TutorialVideosDetailViewState();
}

class _TutorialVideosDetailViewState extends State<TutorialVideosDetailView> {
  late YoutubePlayerController _controller;
  final videoId = ValueNotifier("");

  @override
  void initState() {
    getVideoId(widget.tutorialVideoData.link!);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: ""),
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
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
          ),
        ),
      ),
    );
  }

  getVideoId(String link) {
    videoId.value = YoutubePlayer.convertUrlToId(link)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId.value,
      flags: YoutubePlayerFlags(
          hideControls: false,
          autoPlay: true,
          mute: false,
          showLiveFullscreenButton: false),
    );
  }
}
