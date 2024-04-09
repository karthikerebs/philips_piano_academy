import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/chat/chat_bloc.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/models/response_models/chat_model/chat.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/chat/widgets/app_bar.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Chat> messages = [];
  // final isDelete = ValueNotifier(false);
  final msgId = ValueNotifier(-1);
  final messagesList = ValueNotifier(<Chat>[]);
  final msgIds = ValueNotifier([]);
  @override
  void initState() {
    context.read<ChatBloc>().add(const GetAllChatsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size(kSize.width, kSize.height * .08),
        child: ValueListenableBuilder(
          valueListenable: msgId,
          builder: (context, value, child) {
            return ChatAppBar();
          },
        ),
      ),
      body: PopScope(
        onPopInvoked: (didPop) => true,
        child: SizedBox(
            height: kSize.height,
            width: kSize.width,
            child: Stack(
              children: <Widget>[
                BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state.status is StatusAuthFailure) {
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
                    /*       if (state.status is StatusLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.blackColor),
                      );
                    } else  */
                    if (state.status is StatusSuccess) {
                      messages = state.chatList;
                      _scrollToBottom();
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: kSize.width * 0.044,
                            top: kSize.height * .015,
                            right: kSize.width * 0.044,
                            bottom: kSize.height * .085),
                        itemBuilder: (context, index) {
                          return chatTile(kSize, index);
                        },
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
                ),
                Align(
                    alignment: Alignment.bottomLeft, child: enterField(kSize)),
              ],
            )),
      ),
    );
  }

  Widget chatTile(Size kSize, int index) {
    msgIds.value.add(messages[index].id);
    return ValueListenableBuilder(
      valueListenable: msgId,
      builder: (context, value, child) {
        return Stack(
          children: [
            msgId.value == messages[index].id
                ? Container(
                    width: kSize.width,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    color: AppColors.blueColor.withOpacity(.3),
                    child: Text(messages[index].msg ?? "",
                        style: AppTypography.dmSansRegular.copyWith(
                            color: AppColors.transparent,
                            fontSize: kSize.height * 0.0189)))
                : const SizedBox(),
            Align(
              alignment: messages[index].receiver == "Admin"
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: Column(
                crossAxisAlignment: messages[index].receiver == "Admin"
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: kSize.height * .005),
                    decoration: BoxDecoration(
                        color: AppColors.lightgreyColor1,
                        borderRadius: BorderRadius.horizontal(
                            right: messages[index].receiver == "Admin"
                                ? Radius.zero
                                : Radius.circular(kSize.height * 0.118),
                            left: messages[index].receiver == "Admin"
                                ? Radius.circular(kSize.height * 0.118)
                                : Radius.zero)),
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        if (messages[index].id != null) {
                          if (messages[index].receiver == "Admin") {
                            showDeletePopup(kSize, index);
                          }
                        }
                      },
                      /*      onLongPress: () {
                  /*       if (messages[index].id != null) {
                          msgId.value = messages[index].id!;
                        } */
                      }, */
                      child: Text(messages[index].msg ?? "",
                          style: AppTypography.dmSansRegular.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.0189)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 3, horizontal: kSize.width * 0.044),
                    child: Text(
                        DateFormat("hh:mm a").format(
                            messages[index].createdAt ?? DateTime.now()),
                        style: AppTypography.dmSansRegular.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: kSize.height * 0.0189)),
                  ),
                  SizedBox(
                    height: kSize.height * .02,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget enterField(Size kSize) {
    return Container(
      color: AppColors.secondaryColor,
      padding: EdgeInsets.symmetric(
          vertical: kSize.height * .015, horizontal: kSize.width * .06),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              autofocus: true,
              onTap: () {
                _scrollToBottom();
              },
              controller: chatController,
              decoration: InputDecoration(
                  fillColor: AppColors.lightgreyColor1,
                  hintText: "Type your Message here....",
                  filled: true,
                  hintStyle: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.greyColor,
                      fontSize: kSize.height * 0.0189),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: kSize.width * .03,
          ),
          InkWell(
            onTap: () {
              Timer(const Duration(milliseconds: 100), () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 100),
                );
              });
              setState(() {
                if (chatController.text.isNotEmpty) {
                  messages
                      .add(Chat(msg: chatController.text, receiver: "Admin"));
                  context
                      .read<ChatBloc>()
                      .add(SendMessageEvent(msg: chatController.text));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Can't send empty message",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    backgroundColor: AppColors.secondaryColor,
                  ));
                }
              });
              chatController.clear();
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryColor,
              child:
                  Image.asset(AppImages.sendIcon, height: kSize.height * .03),
            ),
          ),
        ],
      ),
    );
  }

  showDeletePopup(Size kSize, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          alignment: Alignment.center,
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: AppTypography.dmSansMedium.copyWith(
                          color: AppColors.blackColor,
                          fontSize: kSize.height * 0.018),
                    )),
                TextButton(
                    onPressed: () {
                      context.read<ChatBloc>().add(DeleteMessageEvent(
                          msgId: msgIds.value[index].toString()));
                      // msgId.value = -1;
                      Navigator.pop(context);
                      print(
                          "deleeeeeeeeeeeeeeeteeeeeeee${msgIds.value[index]}");
                    },
                    child: Text(
                      'Delete',
                      style: AppTypography.dmSansMedium.copyWith(
                          color: AppColors.blackColor,
                          fontSize: kSize.height * 0.018),
                    )),
              ],
            )
          ],
          content: Text(
            'Delete message?',
            style: AppTypography.dmSansMedium.copyWith(
                color: AppColors.greyColor, fontSize: kSize.height * 0.018),
          )),
    );
  }

  void _scrollToBottom() {
    Timer(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 100),
      );
    });
  }
}
