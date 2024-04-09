import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/application/slot_booking/slot_booking_bloc.dart';
import 'package:music_app/src/domain/models/pm_models/pm_get_fee_details_model/pm_get_fee_details_model.dart';
import 'package:music_app/src/domain/models/pm_models/pm_slot_booking_model/pm_slot_booking_model.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/primary_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'widgets/terms_and_conditions_dialog.dart';

class FeeDetailsView extends StatefulWidget {
  const FeeDetailsView({super.key, required this.slotBookingModel});
  final SlotBookingModel slotBookingModel;
  @override
  State<FeeDetailsView> createState() => _FeeDetailsViewState();
}

class _FeeDetailsViewState extends State<FeeDetailsView> {
  DateTime selectDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  var dateFormat = DateFormat('dd/MM/yyyy');
  Razorpay? _razorpay;
  @override
  void initState() {
    context.read<SlotBookingBloc>().add(const CleanFeeDetailsEvent());
    context.read<HomeBloc>().add(const GetPaymentStatusEvent());
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.05),
              child: MultiBlocListener(
                listeners: [
                  BlocListener<HomeBloc, HomeState>(
                    listenWhen: (previous, current) =>
                        previous.status != current.status,
                    listener: (context, state) {
                      if (state.status is StatusSuccess) {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouterConstants.bottomNavRoute, (route) => false,
                            arguments: 0);
                      } else if (state.status is StatusFailure) {
                        final status = state.status as StatusFailure;
                        CustomMessage(
                                context: context,
                                message: status.errorMessage,
                                style: MessageStyle.error)
                            .show();
                      }
                    },
                  ),
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state.status is StatusSuccess) {
                        if (state.profileData.profileDetails != null) {
                          CustomMessage(
                                  context: context,
                                  message: "Slot booked successfully",
                                  style: MessageStyle.success)
                              .show();
                          context.read<HomeBloc>().add(const GetHomeEvent());
                          context
                              .read<HomeBloc>()
                              .add(const GetBlogsDataEvent());
                          context
                              .read<HomeBloc>()
                              .add(const GetVideosDataEvent());
                        }
                      } else if (state.status is StatusFailure) {
                        final status = state.status as StatusFailure;
                        CustomMessage(
                                context: context,
                                message: status.errorMessage,
                                style: MessageStyle.error)
                            .show();
                      }
                    },
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kSize.height * .08),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(onTap: () {
                          Navigator.pop(context);
                        }),
                        Spacer(),
                        Text(AppStrings.chooseDate,
                            style: AppTypography.dmSansMedium.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.028)),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: kSize.height * 0.0094),
                    Center(
                      child: Text(AppStrings.chooseDateDescription,
                          style: AppTypography.dmSansRegular.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.0189)),
                    ),
                    SizedBox(height: kSize.height * 0.0426),
                    CustomDatePicker(
                      dateController: dateController,
                      errorMessage: '',
                      hintText: "Choose Date",
                      hintColor: AppColors.primaryColor,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 0)),
                      onChanged: (value) {
                        dateController.text = dateFormat.format(value);
                        final param = PmGetFeeDetailsModel(
                            day: widget.slotBookingModel.day,
                            planId: widget.slotBookingModel.planId.toString(),
                            joiningDate: value.toString(),
                            payType: widget.slotBookingModel.payType);
                        context
                            .read<SlotBookingBloc>()
                            .add(GetFeeDetailsEvent(params: param));
                      },
                    ),
                    SizedBox(height: kSize.height * 0.04),
                    BlocConsumer<SlotBookingBloc, SlotBookingState>(
                      listenWhen: (previous, current) =>
                          previous.slotBookingStatus !=
                          current.slotBookingStatus,
                      listener: (context, state) {
                        if (state.slotBookingStatus is StatusLoading) {
                          CustomLoading.show(context);
                        } else if (state.slotBookingStatus is StatusSuccess) {
                          Navigator.pop(context);
                          CustomLoading.dissmis(context);
                          context
                              .read<ProfileBloc>()
                              .add(const GetProfileDataEvent());
                        }
                      },
                      builder: (context, state) {
                        if (state.feeDetailStatus is StatusLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.blackColor),
                          );
                        } else if (state.feeDetailStatus is StatusSuccess) {
                          return Column(
                            children: [
                              dataTile(kSize, "Fee : ",
                                  "${(state.feeDetails.fee)!.round()}"),
                              dataTile(kSize, "Extra Fee : ",
                                  "${(state.feeDetails.extraFee)!.round()}"),
                              dataTile(kSize, "Deposit : ",
                                  "${num.parse(state.feeDetails.deposit!).round()}"),
                              Divider(
                                color: Colors.black,
                                /*               indent: 50,
                                endIndent: 50, */
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total : ',
                                    style: AppTypography.dmSansRegular.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: kSize.height * 0.028),
                                  ),
                                  Text(
                                    '₹${sumTotalFee(state.feeDetails.fee ?? 0, state.feeDetails.extraFee ?? 0, state.feeDetails.deposit != null ? num.parse(state.feeDetails.deposit!) : 0)} (18% gst included)',
                                    style: AppTypography.dmSansMedium.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: kSize.height * 0.0213),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              dataTile(
                                  kSize,
                                  "Joining Date : ",
                                  DateFormat("dd MMM, yyyy").format(
                                      DateTime.parse(
                                          "${state.feeDetails.joiningDate}"))),
                              dataTile(
                                  kSize,
                                  "Valid From : ",
                                  DateFormat("dd MMM, yyyy").format(
                                      DateTime.parse(
                                          "${state.feeDetails.validFrom}"))),
                              dataTile(
                                  kSize,
                                  "Valid To : ",
                                  DateFormat("dd MMM, yyyy").format(
                                      DateTime.parse(
                                          "${state.feeDetails.validTo}"))),
                              SizedBox(height: kSize.height * .04),
                              BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  return PrimaryButton(
                                    onPressed: () {
                                      if (isDateEqual(DateTime.now(),
                                          parseDate(dateController.text))) {
                                        if (isTimeAfterNow(
                                            widget.slotBookingModel.slote!)) {
                                          showTermsAndConditionsDialog(
                                              onTap: () {
                                            if (state.paymentStatusData
                                                    .onlinepayStatus ==
                                                "Disabled") {
                                              final state = context
                                                  .read<SlotBookingBloc>()
                                                  .state;
                                              final params = PmSlotBookingModel(
                                                  deposit:
                                                      "${state.feeDetails.deposit}",
                                                  extraFee:
                                                      "${state.feeDetails.extraFee!.round()}",
                                                  fee:
                                                      "${state.feeDetails.fee!.round()}",
                                                  joiningDate:
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(DateTime.parse(
                                                              state.feeDetails
                                                                  .joiningDate!)),
                                                  paidAmount:
                                                      "${sumTotalFee(state.feeDetails.fee ?? 0, state.feeDetails.extraFee ?? 0, num.parse(state.feeDetails.deposit!)).round()}",
                                                  payType: widget
                                                      .slotBookingModel.payType,
                                                  paymentMethod: "Offline",
                                                  planId: widget
                                                      .slotBookingModel.planId
                                                      .toString(),
                                                  referenceId: "reference",
                                                  sloteId:
                                                      widget.slotBookingModel
                                                          .slotId
                                                          .toString(),
                                                  validFrom:
                                                      "${state.feeDetails.validFrom}",
                                                  validTo:
                                                      "${state.feeDetails.validTo}");
                                              log("${params.toJson()}");
                                              context
                                                  .read<SlotBookingBloc>()
                                                  .add(BookingSlotEvent(
                                                      params: params));
                                            } else {
                                              _startPayment();
                                            }
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      AppColors.redColor,
                                                  content: Text(
                                                    "This Slot unavailable today. Try another date.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        }
                                      } else {
                                        showTermsAndConditionsDialog(onTap: () {
                                          if (state.paymentStatusData
                                                  .onlinepayStatus ==
                                              "Disabled") {
                                            final state = context
                                                .read<SlotBookingBloc>()
                                                .state;
                                            final params = PmSlotBookingModel(
                                                deposit:
                                                    "${state.feeDetails.deposit}",
                                                extraFee:
                                                    "${state.feeDetails.extraFee}",
                                                fee: "${state.feeDetails.fee}",
                                                joiningDate:
                                                    DateFormat("yyyy-MM-dd").format(
                                                        DateTime.parse(state
                                                            .feeDetails
                                                            .joiningDate!)),
                                                paidAmount:
                                                    "${sumTotalFee(state.feeDetails.fee ?? 0, state.feeDetails.extraFee ?? 0, num.parse(state.feeDetails.deposit!))}",
                                                payType: widget
                                                    .slotBookingModel.payType,
                                                paymentMethod: "Offline",
                                                planId: widget
                                                    .slotBookingModel.planId
                                                    .toString(),
                                                referenceId: "reference",
                                                sloteId:
                                                    widget
                                                        .slotBookingModel.slotId
                                                        .toString(),
                                                validFrom:
                                                    "${state.feeDetails.validFrom}",
                                                validTo:
                                                    "${state.feeDetails.validTo}");
                                            log("${params.toJson()}");
                                            context.read<SlotBookingBloc>().add(
                                                BookingSlotEvent(
                                                    params: params));
                                          } else {
                                            _startPayment();
                                          }
                                        });
                                      }
                                    },
                                    label: 'Proceed',
                                    backgroundColor: AppColors.primaryColor,
                                    labelColor: AppColors.secondaryColor,
                                  );
                                },
                              ),
                            ],
                          );
                        } else if (state.feeDetailStatus is StatusFailure) {
                          final status = state.feeDetailStatus as StatusFailure;
                          return Center(
                            child: Text(status.errorMessage),
                          );
                        } else if (state.feeDetailStatus is StatusAuthFailure) {
                          final status =
                              state.feeDetailStatus as StatusAuthFailure;
                          return Center(
                            child: Text(status.errorMessage),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    SizedBox(height: kSize.height * 0.02),
                  ],
                ),
              )),
        ));
  }

  Widget dataTile(Size kSize, String label, String data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSize.height * 0.0189),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.dmSansRegular.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.0213),
          ),
          Text(
            data,
            style: AppTypography.dmSansMedium.copyWith(
                color: AppColors.primaryColor, fontSize: kSize.height * 0.0213),
          ),
        ],
      ),
    );
  }

  void showTermsAndConditionsDialog({required Function() onTap}) {
    showDialog(
        context: context,
        builder: (context) {
          return TermsAndConditionsDialog(onTap: onTap);
        });
  }

// Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("Payment success: ${response.data}");
    final state = context.read<SlotBookingBloc>().state;
    final params = PmSlotBookingModel(
        deposit: "${state.feeDetails.deposit}",
        extraFee: "${state.feeDetails.extraFee}",
        fee: "${state.feeDetails.fee}",
        joiningDate: DateFormat("yyyy-MM-dd")
            .format(DateTime.parse(state.feeDetails.joiningDate!)),
        paidAmount:
            "${sumTotalFee(state.feeDetails.fee ?? 0, state.feeDetails.extraFee ?? 0, num.parse(state.feeDetails.deposit!))}",
        payType: widget.slotBookingModel.payType,
        paymentMethod: "Online",
        planId: widget.slotBookingModel.planId.toString(),
        referenceId: "${response.paymentId}",
        sloteId: widget.slotBookingModel.slotId.toString(),
        validFrom: "${state.feeDetails.validFrom}",
        validTo: "${state.feeDetails.validTo}");
    context.read<SlotBookingBloc>().add(BookingSlotEvent(params: params));
  }

// Handle payment failure
  void _handlePaymentError(PaymentFailureResponse response) {
    log("Payment error: ${response.code.toString()} - ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${response.message}"),
      backgroundColor: AppColors.redColor,
    ));
    Navigator.pop(context);
  }

  bool isDateEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  DateTime parseDate(String date) {
    return DateFormat("dd/MM/yyyy").parse(date);
  }

// Handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External wallet: ${response.walletName}");
  }

  bool isTimeAfterNow(String targetTimeString) {
    DateTime now = DateTime.now();
    List<String> timeParts = targetTimeString.split(":");
    DateTime targetTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
        int.parse(timeParts[2]));

    return targetTime.isAfter(now);
  }

// start payment
  void _startPayment() {
    final state = context.read<ProfileBloc>().state;
    final slotBookingstate = context.read<SlotBookingBloc>().state;
    log("${state.basicData.toJson()}");
    Map<String, dynamic> options = {
      'key': "rzp_live_BUSmhSPjTh6whJ",
      'amount': sumTotalFee(
              slotBookingstate.feeDetails.fee ?? 0,
              slotBookingstate.feeDetails.extraFee ?? 0,
              num.parse(slotBookingstate.feeDetails.deposit!)) *
          100.round(),
      'name': "Philip's Piano Academy",
      'description': 'Payment for participation in your music class.',
      'prefill': {
        'contact': " ${state.basicData.mobile}",
        'email': '${state.basicData.email}'
      },
      'external': {'wallets': []},
    };
    options['amount'] = options['amount'].toString();
    try {
      _razorpay!.open(options);
    } catch (e) {
      log('Error in starting Razorpay payment: $e');
    }
  }

  num sumTotalFee(num fee, num extraFee, num deposit) {
    var totalSumFee = fee + extraFee + deposit;
    return totalSumFee.round();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }
}

class SlotBookingModel {
  String? day;
  int? planId;
  String? slote;
  String? payType;
  int? slotId;
  SlotBookingModel(
      {this.day, this.planId, this.slote, this.payType, this.slotId});
}
