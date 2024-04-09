import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key});
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      leading: const SizedBox(),
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: kSize.width * .035),
          child: Row(
            children: <Widget>[
              CustomBackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: AppColors.secondaryColor),
              const SizedBox(
                width: 12,
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.prognos.com/sites/default/files/styles/profile_image/public/2020-06/profile-pic-placeholder.png?itok=x2Ckkfjo'),
                maxRadius: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Admin",
                      style: AppTypography.dmSansMedium.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: kSize.height * 0.02),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Online",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: kSize.height * 0.0149),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
