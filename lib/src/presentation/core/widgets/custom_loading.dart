import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';

class CustomLoading {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          onPopInvoked: (didPop) => false,
          child: Align(
            child: SizedBox(
              height: 54,
              width: 54,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void dissmis(BuildContext context) {
    Navigator.pop(context);
  }
}
