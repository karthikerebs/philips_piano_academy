import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, required this.onTap, this.color});
  final Function() onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        AppImages.arrowBackIcon,
        color: color,
        height: kSize.height * .04,
      ),
    );
  }
}
