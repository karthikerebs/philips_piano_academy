import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/installment/installment_bloc.dart';
import 'package:music_app/src/domain/models/response_models/installment_model/installment.dart';
import 'package:music_app/src/domain/models/response_models/payment_installment_model/installment.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';

class InstallMentTabbar extends StatefulWidget {
  const InstallMentTabbar({super.key});

  @override
  State<InstallMentTabbar> createState() => _InstallMentTabbarState();
}

class _InstallMentTabbarState extends State<InstallMentTabbar> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return TabBarView(children: [
      BlocBuilder<InstallmentBloc, InstallmentState>(
        builder: (context, state) {
          if (state.status is StatusLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.blackColor),
            );
          } else if (state.status is StatusSuccess) {
            if (state.installmentList.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.installmentList.length,
                padding: EdgeInsets.only(top: kSize.height * .04),
                itemBuilder: (context, index) {
                  return installments(kSize, index, state.installmentList);
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: AppColors.greyColor,
                    thickness: 1,
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No installments found!'),
              );
            }
          } else if (state.status is StatusFailure) {
            final status = state.status as StatusFailure;
            return Center(
              child: Text(status.errorMessage),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      BlocBuilder<InstallmentBloc, InstallmentState>(
        builder: (context, state) {
          if (state.pendingstatus is StatusLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.blackColor),
            );
          } else if (state.pendingstatus is StatusSuccess) {
            if (state.pendingInstallment.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.pendingInstallment.length,
                padding: EdgeInsets.only(top: kSize.height * .04),
                itemBuilder: (context, index) {
                  return pendingInstallments(
                      kSize, index, state.pendingInstallment);
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: AppColors.greyColor,
                    thickness: 1,
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No pending installments found!'),
              );
            }
          } else if (state.pendingstatus is StatusFailure) {
            final status = state.pendingstatus as StatusFailure;
            return Center(
              child: Text(status.errorMessage),
            );
          } else {
            return const SizedBox();
          }
        },
      )
    ]);
  }

  Widget installments(Size kSize, int index, List<Installment> installment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        index == 0
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: kSize.height * 0.0243, horizontal: kSize.width * 0.097),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Installment 0${index + 1}',
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.028)),
              SizedBox(height: kSize.height * .01),
              Text(
                  "Approval Status : ${installment[index].approvalStatus ?? ""}",
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.greyColor,
                      fontSize: kSize.height * 0.0189)),
              SizedBox(height: kSize.height * .01),
              Text("Payment Status : ${installment[index].paymentStatus ?? ""}",
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.greyColor,
                      fontSize: kSize.height * 0.0189)),
              SizedBox(height: kSize.height * .01),
              Text("Paid Amount : ${installment[index].paidAmount ?? ""}",
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.greyColor,
                      fontSize: kSize.height * 0.0189)),
              SizedBox(height: kSize.height * .01),
              Text("Last Date : ${installment[index].lastDate ?? ""}",
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.greyColor,
                      fontSize: kSize.height * 0.0189)),
            ],
          ),
        ),
        index == installment.length - 1
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox()
      ],
    );
  }

  Widget pendingInstallments(
      Size kSize, int index, List<PaymentInstallment> installment) {
    return Column(
      children: [
        index == 0
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: kSize.height * 0.0343, horizontal: kSize.width * 0.097),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(index < 9 ? 'Class 0${index + 1}' : 'Class ${index + 1}',
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.028)),
                  SizedBox(height: kSize.height * .01),
                  Text(
                      "Approval Status : ${installment[index].approvalStatus ?? ""}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                  SizedBox(height: kSize.height * .01),
                  Text(
                      "Payment Status : ${installment[index].paymentStatus ?? ""}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                  SizedBox(height: kSize.height * .01),
                  Text("Paid Amount : ${installment[index].paidAmount ?? "0"}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                  SizedBox(height: kSize.height * .01),
                  Text("Last Date : ${installment[index].lastDate ?? ""}",
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                ],
              ),
              CommonButton(
                label: "Pay",
                onTap: () {},
              )
            ],
          ),
        ),
        index == installment.length - 1
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox()
      ],
    );
  }
}
