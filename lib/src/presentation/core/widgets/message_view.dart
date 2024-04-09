import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

enum MessageStyle {
  error,
  success,
  warning,
}

class CustomMessage {
  const CustomMessage({
    required this.context,
    this.message,
    this.style = MessageStyle.success,
  });

  final BuildContext context;
  final String? message;
  final MessageStyle style;

  void show() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _colorBuilder(style),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            _iconBuilder(style),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppTypography.dmSansRegular.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: MediaQuery.of(context).size.height * .018),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void remove() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  Icon _iconBuilder(MessageStyle style) {
    switch (style) {
      case MessageStyle.error:
        return const Icon(Icons.error, color: Colors.white);
      case MessageStyle.success:
        return const Icon(Icons.verified, color: Colors.white);
      case MessageStyle.warning:
        return const Icon(Icons.warning, color: Colors.white);
    }
  }

  Color _colorBuilder(MessageStyle style) {
    switch (style) {
      case MessageStyle.error:
        return AppColors.redColor;
      case MessageStyle.success:
        return AppColors.greenColor;
      case MessageStyle.warning:
        return Colors.black;
    }
  }
}
