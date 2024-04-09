import 'package:flutter/material.dart';
import 'package:music_app/src/domain/models/response_models/branch_model/branch.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class BranchDropDownButton extends StatefulWidget {
  const BranchDropDownButton({
    super.key,
    required this.hintText,
    required this.dropList,
    this.errorMessage,
    required this.onSelected,
    this.hintColor,
    this.borderColor,
    this.fillColor,
    this.isValidate,
  });
  final String hintText;
  final List<Branch> dropList;
  final String? errorMessage;
  final void Function(String selectedIndex) onSelected;
  final Color? hintColor;
  final Color? borderColor;
  final Color? fillColor;
  final ValueNotifier<bool>? isValidate;
  @override
  State<BranchDropDownButton> createState() => _BranchDropDownButtonState();
}

class _BranchDropDownButtonState extends State<BranchDropDownButton> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kSize.width * 0.0605, vertical: kSize.height * 0.00),
          decoration: BoxDecoration(
            color: widget.fillColor ?? AppColors.secondaryColor,
            border: Border.all(
                color: !widget.isValidate!.value
                    ? selectedCategory.isEmpty
                        ? AppColors.deepRedColor
                        : widget.borderColor!
                    : widget.borderColor!),
            borderRadius: BorderRadius.circular(kSize.height * 0.1184),
          ),
          child: DropdownButton<Branch>(
            icon: Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryColor, size: kSize.height * 0.035),
            items:
                widget.dropList.map<DropdownMenuItem<Branch>>((Branch branch) {
              return DropdownMenuItem<Branch>(
                value: branch,
                child: Text(branch.branch!),
              );
            }).toList(),
            hint: Text(
                selectedCategory.isEmpty ? widget.hintText : selectedCategory,
                style: AppTypography.dmSansRegular.copyWith(
                    color: selectedCategory.isEmpty
                        ? widget.hintColor
                        : AppColors.primaryColor,
                    fontSize: kSize.height * .021)),
            borderRadius: BorderRadius.circular(10),
            underline: const SizedBox(),
            isExpanded: true,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedCategory = value.branch.toString();
                  final index = widget.dropList
                      .indexWhere((element) => element.id == value.id);
                  widget.onSelected(widget.dropList[index].id!.toString());
                });
              }
            },
          ),
        ),
        SizedBox(height: kSize.height * .01),
        !widget.isValidate!.value
            ? selectedCategory.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: kSize.width * .03),
                    child: Text(widget.errorMessage!,
                        style: AppTypography.dmSansRegular.copyWith(
                            color: AppColors.deepRedColor,
                            fontSize: kSize.height * .021)),
                  )
                : const SizedBox()
            : const SizedBox()
      ],
    );
  }
}
