import 'package:flutter/material.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: floatingActionButton(kSize),
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: kSize.width * 0.12,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: kSize.width * 0.04),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text('Phone',
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.greyColor,
                        fontSize: kSize.height * 0.0189)),
                SizedBox(height: kSize.height * 0.00710),
                Text('+91 93807 43824',
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.026)),
                SizedBox(height: kSize.height * 0.023),
                Text('Email',
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.greyColor,
                        fontSize: kSize.height * 0.0189)),
                SizedBox(height: kSize.height * 0.00710),
                Text('PHILIPS.PIANOACADEMY@GMAIL.COM',
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.026)),
                SizedBox(height: kSize.height * 0.023),
                Text('Whatsapp',
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.greyColor,
                        fontSize: kSize.height * 0.0189)),
                SizedBox(height: kSize.height * 0.00710),
                Text('+91 8892573158',
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.026)),
                SizedBox(height: kSize.height * 0.018),
              ],
            ),
          )),
    );
  }

  Widget floatingActionButton(Size kSize) {
    return InkWell(
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
}
