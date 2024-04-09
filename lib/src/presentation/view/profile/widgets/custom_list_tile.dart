import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.label,
      required this.onTap,
      required this.image});
  final String label;
  final Function() onTap;
  final String image;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kSize.height * 0.01),
        child: Row(
          children: [
            Image.asset(
              image,
              height: kSize.height * 0.03,
            ),
            SizedBox(width: kSize.width * 0.044),
            Text(label,
                style: AppTypography.dmSansMedium
                    .copyWith(color: AppColors.primaryColor, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
