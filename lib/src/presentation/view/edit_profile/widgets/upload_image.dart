import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key, required this.onTap});
  final Function(ImageSource) onTap;
  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      width: kSize.width,
      color: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Choose Profile Photo",
              style: AppTypography.dmSansRegular.copyWith(
                fontSize: kSize.height * 0.026,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: kSize.height * 0.019,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    widget.onTap(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primaryColor,
                    size: kSize.height * 0.033,
                  ),
                  label: Text(
                    'Camera',
                    style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.021,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    widget.onTap(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    color: AppColors.primaryColor,
                    size: kSize.height * 0.033,
                  ),
                  label: Text(
                    'Gallery',
                    style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.021,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
