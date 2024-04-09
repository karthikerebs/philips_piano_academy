import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key, required this.enabled});
  final Function(int) enabled;
  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  ValueNotifier<int> isToggled = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
      valueListenable: isToggled,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            if (isToggled.value == 0) {
              isToggled.value = 1;
            } else {
              isToggled.value = 0;
            }
            widget.enabled(isToggled.value);
          },
          child: Stack(
            alignment: isToggled.value == 1
                ? Alignment.centerRight
                : Alignment.centerLeft,
            children: [
              AnimatedContainer(
                width: kSize.width * 0.12,
                height: kSize.height * 0.03,
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: AppColors.switchGreyColor,
                    borderRadius:
                        BorderRadius.circular(kSize.height * 0.03631)),
              ),
              Container(
                height: kSize.height * 0.038,
                width: kSize.height * 0.038,
                decoration: const BoxDecoration(
                    color: AppColors.blackColor, shape: BoxShape.circle),
              ),
            ],
          ),
        );
      },
    );
  }
}
