import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/application/refund/refund_bloc.dart';
import 'package:music_app/src/domain/models/response_models/refund_request_model/refund_request.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';

import 'widgets/refund_dialog.dart';

class RefundView extends StatefulWidget {
  const RefundView({super.key});

  @override
  State<RefundView> createState() => _RefundViewState();
}

class _RefundViewState extends State<RefundView> {
  var dateFormat = DateFormat("dd/MM/yyyy");
  @override
  void initState() {
    context.read<RefundBloc>().add(const GetRefundRequestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: CustomAppBar(title: "Deposite Refund"),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<RefundBloc>().add(const GetRefundRequestsEvent());
            },
            child: Column(
              children: [
                if (!requestRefund())
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Your Refund has been activated 30 days prior to the end of your current plan.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: AppColors.redColor),
                    ),
                  ),
                SizedBox(height: 20),
                BlocListener<RefundBloc, RefundState>(
                  listenWhen: (previous, current) =>
                      previous.sendRequestStatus != current.sendRequestStatus,
                  listener: (context, state) {
                    if (state.sendRequestStatus is StatusLoading) {
                      CustomLoading.show(context);
                    } else if (state.sendRequestStatus is StatusSuccess) {
                      CustomLoading.dissmis(context);
                      context
                          .read<RefundBloc>()
                          .add(const GetRefundRequestsEvent());
                      CustomMessage(
                              context: context,
                              message: "Request send successfully",
                              style: MessageStyle.success)
                          .show();
                    } else if (state.sendRequestStatus is StatusFailure) {
                      final status = state.sendRequestStatus as StatusFailure;
                      CustomLoading.dissmis(context);
                      CustomMessage(
                              context: context,
                              message: status.errorMessage,
                              style: MessageStyle.error)
                          .show();
                    } else if (state.sendRequestStatus is StatusAuthFailure) {
                      CustomMessage(
                              context: context,
                              message: 'Access Denied. Kindly reauthenticate.',
                              style: MessageStyle.error)
                          .show();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouterConstants.splashRoute,
                        (route) => false,
                      );
                    }
                  },
                  child: Center(
                    child: CommonButton(
                      label: 'Request Refund',
                      backgroundColor: requestRefund()
                          ? AppColors.blackColor
                          : AppColors.blackColor.withOpacity(.3),
                      padding: EdgeInsets.symmetric(
                          vertical: kSize.height * 0.022,
                          horizontal: kSize.width * .1),
                      onTap: () {
                        if (requestRefund()) {
                          showRefundDialog();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: kSize.height * .025),
                BlocBuilder<RefundBloc, RefundState>(
                  builder: (context, state) {
                    if (state.status is StatusLoading) {
                      return const Column(
                        children: [
                          SizedBox(height: 150),
                          CircularProgressIndicator(
                              color: AppColors.blackColor),
                        ],
                      );
                    } else if (state.status is StatusSuccess) {
                      if (state.refundRequestList.isNotEmpty) {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                              color: AppColors.greyColor,
                              thickness: 1,
                            );
                          },
                          itemCount: state.refundRequestList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return refundDataTile(
                                kSize, index, state.refundRequestList);
                          },
                        );
                      } else {
                        return const Column(
                          children: [
                            SizedBox(height: 150),
                            Text("No refund requests found!"),
                          ],
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
                )
              ],
            ),
          )),
    );
  }

  Widget refundDataTile(
      Size kSize, int index, List<RefundRequest> refundRequestList) {
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
                  Text('Refund 0${index + 1}',
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.028)),
                  SizedBox(height: kSize.height * .01),
                  Text(dateFormat.format(refundRequestList[index].createdAt!),
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: kSize.height * 0.014,
                    horizontal: kSize.width * .06),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: getColor(refundRequestList[index].status ?? "")),
                    borderRadius: BorderRadius.circular(kSize.height * 0.118)),
                child: Text(
                  /* "In Complete" */ refundRequestList[index].status ?? "",
                  style: AppTypography.dmSansRegular.copyWith(
                      color: getColor(refundRequestList[index].status ?? ""),
                      fontSize: kSize.height * 0.0189),
                ),
              ),
            ],
          ),
        ),
        index == refundRequestList.length - 1
            ? const Divider(
                height: 1,
                color: AppColors.greyColor,
                thickness: 1,
              )
            : const SizedBox()
      ],
    );
  }

  Color getColor(String? status) {
    final Color color;
    switch (status) {
      case 'Pending':
        color = AppColors.yellowColor;
        break;
      case 'Paid':
        color = AppColors.greenColor;
        break;
      case 'Rejected':
        color = AppColors.redColor;
        break;
      default:
        color = AppColors.yellowColor;
    }
    return color;
  }

  showRefundDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return const RefundDialog();
        });
  }

/*   bool isButtonEnabled() {
    final state = context.read<ProfileBloc>().state;
    DateTime currentDate = DateTime.now();
    final DateTime validFrom = DateFormat("yyyy-MM-dd")
        .parse(state.profileData.profileDetails!.validFrom!);
    final DateTime validTo = DateFormat("yyyy-MM-dd")
        .parse(state.profileData.profileDetails!.validTo!);
    DateTime startDateRange = validFrom.subtract(Duration(days: 30));
    DateTime endDateRange = validTo.subtract(Duration(days: 20));

    return currentDate.isAfter(startDateRange) &&
        currentDate.isBefore(endDateRange);
  } */

  bool requestRefund() {
    final state = context.read<ProfileBloc>().state;
    final DateTime validTo = DateFormat("yyyy-MM-dd")
        .parse(state.profileData.profileDetails!.validTo!);
    DateTime currentDate = DateTime.now();
    int daysDifference = validTo.difference(currentDate).inDays;
    if (daysDifference <= 30) {
      return true;
    } else {
      return false;
    }
  }
}
