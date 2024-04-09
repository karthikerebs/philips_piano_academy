import 'package:flutter/material.dart';
import 'package:music_app/src/domain/models/response_models/plans_model/plan.dart';
import 'package:music_app/src/presentation/core/constants/images.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
// import 'dart:math' as math;

import 'package:music_app/src/presentation/core/widgets/footer_button.dart';

class PlanCardDetails extends StatefulWidget {
  const PlanCardDetails({
    super.key,
    required this.planDetails,
    required this.onTap,
    required this.selectType,
    required this.paymentTypes,
    required this.onChanged,
  });
  final Plan planDetails;
  final Function() onTap;
  final ValueNotifier<int> selectType;
  final List<String> paymentTypes;
  final Function(String) onChanged;
  @override
  State<PlanCardDetails> createState() => _PlanCardDetailsState();
}

class _PlanCardDetailsState extends State<PlanCardDetails> {
  ValueNotifier<int> selectedType = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kSize.width * 0.0139, vertical: kSize.height * 0.0189),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(kSize.height * 0.023)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(widget.planDetails.name ?? '',
            style: AppTypography.dmSansRegular.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.02)),
        SizedBox(height: kSize.height * 0.0094),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(/* '₹16,000' */ "₹${widget.planDetails.actualFee!.round()} ",
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.037)),
            Text(
              ' (18% gst included)',
              style: AppTypography.dmSansRegular.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.015),
            )
          ],
        ),
        Text(
            widget.planDetails.month == 1
                ? "${widget.planDetails.month} Month"
                : "${widget.planDetails.month} Months",
            style: AppTypography.dmSansMedium.copyWith(
                color: AppColors.greyColor, fontSize: kSize.height * 0.018)),
/*         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(/* '₹20,000' */ "₹${widget.planDetails.actualFee}",
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.0182)),
                Transform.rotate(
                    angle: -math.pi / 1.036,
                    child: Container(
                        height: 1,
                        width: kSize.width * 0.10,
                        color: AppColors.redColor)),
              ],
            ),
            SizedBox(width: kSize.width * .033),
            Text(
                /* '24% OFF' */ "${getPercentage(widget.planDetails.actualFee!, widget.planDetails.offerFee!).round().toString()}% OFF ",
                style: AppTypography.dmSansRegular.copyWith(
                    color: AppColors.lightgreyColor,
                    fontSize: kSize.height * 0.0142)),
          ],
        ),
        SizedBox(height: kSize.height * 0.0201),
        selectPayType(kSize),
        SizedBox(height: kSize.height * 0.0201), */
        FooterButton(label: 'Choose plan', onPressed: widget.onTap)
      ]),
    );
  }

  double getPercentage(int actualPrice, int offerPrice) {
    double discount = 0.0;
    discount = ((actualPrice - offerPrice) / actualPrice) * 100;
    return discount;
  }

  Widget selectPayType(Size kSize) {
    return ValueListenableBuilder(
      valueListenable: selectedType,
      builder: (context, dynamic, child) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                2,
                (index) => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            selectedType.value = index;
                            widget.onChanged(
                                widget.paymentTypes[selectedType.value]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: kSize.width * .02),
                            height: kSize.height * .03,
                            width: kSize.width * .05,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedType.value == index
                                        ? AppColors.blackColor
                                        : AppColors.greyColor),
                                color: selectedType.value == index
                                    ? AppColors.blackColor
                                    : AppColors.secondaryColor,
                                borderRadius:
                                    BorderRadius.circular(kSize.height * .01)),
                            child: Image.asset(AppImages.tickIcon,
                                height: kSize.height * .01,
                                color: AppColors.secondaryColor),
                          ),
                        ),
                        Text(
                          widget.paymentTypes[index],
                          style: AppTypography.dmSansRegular.copyWith(
                              color: AppColors.blackColor,
                              fontSize: kSize.height * 0.0162),
                        ),
                        SizedBox(
                          width: kSize.width * .02,
                        ),
                      ],
                    )));
      },
    );
  }
}
