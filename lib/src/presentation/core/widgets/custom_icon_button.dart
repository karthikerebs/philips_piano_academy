import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.icon})
      : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: onPressed,
      child: Row(
        children: [
          Text("$label",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: kSize.height * 0.015,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400)),
          SizedBox(width: kSize.width * 0.022),
          icon,
        ],
      ),
    );
  }
}
