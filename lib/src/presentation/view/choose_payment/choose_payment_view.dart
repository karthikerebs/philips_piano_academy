import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/slot_booking/slot_booking_bloc.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/view/choose_payment/widgets/card.dart';
import 'package:music_app/src/presentation/view/fee_details/fee_details_view.dart';

class ChoosePaymentView extends StatefulWidget {
  const ChoosePaymentView(
      {super.key,
      required this.slote,
      required this.day,
      required this.slotId});
  final String slote;
  final String day;
  final int slotId;
  @override
  State<ChoosePaymentView> createState() => _ChoosePaymentViewState();
}

class _ChoosePaymentViewState extends State<ChoosePaymentView> {
  @override
  void initState() {
    context.read<SlotBookingBloc>().add(const GetPlansEvent());
    super.initState();
  }

  List<String> paymentTypes = ["Full", "Monthly"];
  final selectType = ValueNotifier(0);
  final selectedType = ValueNotifier("Full");
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        toolbarHeight: kSize.height * .1,
        leadingWidth: 5,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: const SizedBox(),
        title: CustomBackButton(onTap: () {
          Navigator.pop(context);
        }),
      ),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(kSize),
                  Center(
                    child: Text(AppStrings.chooseYourPlan,
                        style: AppTypography.dmSansMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: kSize.height * 0.028)),
                  ),
                  SizedBox(height: kSize.height * 0.0094),
                  Center(
                    child: Text(AppStrings.chooseYourPlanDescription,
                        style: AppTypography.dmSansRegular.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: kSize.height * 0.0189)),
                  ),
                  SizedBox(height: kSize.height * 0.018),
                  BlocBuilder<SlotBookingBloc, SlotBookingState>(
                    builder: (context, state) {
                      if (state.status is StatusLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.primaryColor),
                        );
                      } else if (state.status is StatusSuccess) {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: kSize.height * .015,
                            );
                          },
                          shrinkWrap: true,
                          itemCount: state.planList.length,
                          primary: false,
                          padding: EdgeInsets.only(
                            top: kSize.height * .02,
                          ),
                          itemBuilder: (context, index) {
                            return PlanCardDetails(
                              onChanged: (value) {
                                selectedType.value = value;
                              },
                              paymentTypes: paymentTypes,
                              selectType: selectType,
                              planDetails: state.planList[index],
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouterConstants.feeDetailsRoute,
                                    arguments: SlotBookingModel(
                                        slote: widget.slote,
                                        day: widget.day,
                                        slotId: widget.slotId,
                                        planId: state.planList[index].id,
                                        payType: "Full"));
                              },
                            );
                          },
                        );
                      } else if (state.status is StatusFailure) {
                        final status = state.status as StatusFailure;
                        return Center(
                          child: Text(status.errorMessage),
                        );
                      } else if (state.status is StatusAuthFailure) {
                        final status = state.status as StatusAuthFailure;
                        return Center(
                          child: Text(status.errorMessage),
                        );
                      } else {
                        return const Center(child: Text("no plans found!"));
                      }
                    },
                  ),
                  SizedBox(height: kSize.height * 0.0489),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            text: AppStrings.haveQuestion,
                            style: AppTypography.dmSansRegular.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.0189),
                            children: [
                          TextSpan(
                              text: ' Reach Us',
                              style: AppTypography.dmSansRegular.copyWith(
                                  color: AppColors.primaryColor,
                                  decorationColor: AppColors.primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: kSize.height * 0.0184))
                        ])),
                  ),
                  SizedBox(height: kSize.height * 0.0189),
                ],
              ),
            ),
          )),
    );
  }

  Widget title(Size kSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.whohoo,
            style: AppTypography.dmSansMedium.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.022)),
        SizedBox(height: kSize.height * 0.021),
        Text(AppStrings.choosePayment,
            style: AppTypography.dmSansRegular.copyWith(
                color: AppColors.primaryColor,
                fontSize: kSize.height * 0.0189)),
        SizedBox(height: kSize.height * 0.042),
      ],
    );
  }
}
