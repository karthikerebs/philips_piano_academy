import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/widgets/custom_icon_button.dart';

import '../../../core/theme/colors.dart';

class ExpandedText extends StatefulWidget {
  const ExpandedText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '''${widget.text}''',
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: kSize.height * 0.019, height: kSize.height * .00),
          maxLines: _active ? 1000 : 1,
        ),
        SizedBox(height: kSize.height * 0.01),
        widget.text.length > 10
            ? PrimaryIconButton(
                onPressed: () {
                  setState(() {
                    _active = !_active;
                  });
                },
                label: _active ? "Less" : "Read more",
                icon: Icon(
                  _active ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                  size: kSize.height * 0.015,
                  color: AppColors.blackColor,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
