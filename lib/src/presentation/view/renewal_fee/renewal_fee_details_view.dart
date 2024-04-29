import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/application/renewal/renewal_bloc.dart';
import 'package:music_app/src/domain/models/pm_models/pm_send_renew_request_model/pm_send_renew_request_model.dart';
// import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
// import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/primary_button.dart';
import 'package:music_app/src/presentation/view/renewal_fee/widgets/month_dropdown.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RenewalFeeDetailsView extends StatefulWidget {
  const RenewalFeeDetailsView({
    super.key,
    required this.extraClassFee,
    /* required this.sendRequestModel */
  });
  final String extraClassFee;
  @override
  State<RenewalFeeDetailsView> createState() => _RenewalFeeDetailsViewState();
}

class _RenewalFeeDetailsViewState extends State<RenewalFeeDetailsView> {
  DateTime selectDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  var dateFormat = DateFormat('dd/MM/yyyy');
  TextEditingController monthController = TextEditingController();
  Razorpay? _razorpay;
  @override
  void initState() {
    context.read<RenewalBloc>().add(const CleanDataEvent());
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
        resizeToAvoidBottomInset: false,
        body: BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.paymentStatus != current.paymentStatus,
          listener: (context, state) {
            if (state.paymentStatus is StatusAuthFailure) {
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
          child: SizedBox(
            height: kSize.height,
            width: kSize.width,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kSize.height * .08),
                    Row(
                      children: [
                        CustomBackButton(onTap: () {
                          Navigator.pop(context);
                        }),
                        Spacer(),
                        Text("Renewal Fee Details",
                            style: AppTypography.dmSansBold.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.03)),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: kSize.height * 0.025),
                    Center(
                      child: Text(
                          "How many months would you like to renew for?",
                          textAlign: TextAlign.center,
                          style: AppTypography.dmSansRegular.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.022)),
                    ),
                    SizedBox(height: kSize.height * 0.0326),
                    Center(
                        child: SizedBox(
                            width: kSize.width * .3,
                            child: MonthDropdown(
                              onSelected: (value) {
                                monthController.text = value;
                                context.read<RenewalBloc>().add(
                                    GetRenewalFeeDetailsEvent(
                                        months: monthController.text));
                              },
                            ))),
                    /*    SizedBox(height: kSize.height * 0.0326),
                    Center(
                        child: FooterButton(
                            label: "Get Fee Details",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              context.read<RenewalBloc>().add(
                                  GetRenewalFeeDetailsEvent(
                                      months: monthController.text));
                            })),*/
                    SizedBox(height: kSize.height * 0.04),
                    BlocConsumer<RenewalBloc, RenewalState>(
                      listenWhen: (previous, current) =>
                          previous.requestStatus != current.requestStatus,
                      listener: (context, state) {
                        if (state.requestStatus is StatusLoading) {
                          CustomLoading.show(context);
                        } else if (state.requestStatus is StatusSuccess) {
                          CustomLoading.dissmis(context);
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouterConstants.bottomNavRoute, (route) => false,
                              arguments: 2);
                          CustomMessage(
                                  context: context,
                                  message: "Request sent successfully",
                                  style: MessageStyle.success)
                              .show();
                        } else if (state.requestStatus is StatusFailure) {
                          final status = state.requestStatus as StatusFailure;
                          CustomLoading.dissmis(context);
                          CustomMessage(
                                  context: context,
                                  message: status.errorMessage,
                                  style: MessageStyle.error)
                              .show();
                        } else if (state.requestStatus is StatusAuthFailure) {
                          CustomLoading.dissmis(context);
                          CustomMessage(
                                  context: context,
                                  message:
                                      'Access Denied. Kindly reauthenticate.',
                                  style: MessageStyle.error)
                              .show();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouterConstants.splashRoute,
                            (route) => false,
                          );
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
                              dataTile(
                                kSize,
                                "Fee :",
                                monthController.text == "1"
                                    ? "${state.feeDetails.fee!.round()}"
                                    : "₹${calculateDiscountedFee(state.feeDetails.fee!.round(), monthController.text == "3" ? 0.035 : 0.06).round()}",
                              ),
                              dataTile(kSize, "Extra Fee :",
                                  "₹${state.feeDetails.extraFee!.round()}"),
                              dataTile(kSize, "Extra Class Fee :",
                                  "₹${widget.extraClassFee}"),
                              Divider(color: Colors.black),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total : ',
                                      style: AppTypography.dmSansRegular
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: kSize.height * 0.028),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "₹${sumTotalFee(
                                            state.feeDetails.extraFee!.round(),
                                            num.parse(widget.extraClassFee),
                                            monthController.text == "1"
                                                ? state.feeDetails.fee!.round()
                                                : calculateDiscountedFee(
                                                    state.feeDetails.fee!
                                                        .round(),
                                                    monthController.text == "3"
                                                        ? 0.035
                                                        : 0.06),
                                          ).round()}",
                                          style: AppTypography.dmSansMedium
                                              .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontSize:
                                                      kSize.height * 0.023),
                                          children: [
                                            TextSpan(
                                                text: " (18% gst included)",
                                                style: AppTypography
                                                    .dmSansRegular
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontSize: kSize.height *
                                                            0.018))
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                              dataTile(
                                  kSize,
                                  "Joining Date :",
                                  DateFormat("dd MMM, yyyy").format(
                                      DateTime.parse(
                                          "${state.feeDetails.joiningDate}"))),
                              dataTile(
                                  kSize,
                                  "Valid From :",
                                  DateFormat("dd MMM, yyyy").format(
                                      DateTime.parse(
                                          "${state.feeDetails.validFrom}"))),
                              dataTile(
                                  kSize,
                                  "Valid To :",
                                  DateFormat("dd MMM, yyyy").format(
                                      DateTime.parse(
                                          "${state.feeDetails.validTo}"))),
                              SizedBox(height: kSize.height * .05),
                              PrimaryButton(
                                onPressed: () {
                                  final state = context.read<HomeBloc>().state;
                                  if (state.paymentStatusData.onlinepayStatus ==
                                      'Disabled') {
                                    final state =
                                        context.read<RenewalBloc>().state;
                                    final params = PmSendRenewRequestModel(
                                        extraFee:
                                            "${state.feeDetails.extraFee}",
                                        extraClassFee:
                                            "${widget.extraClassFee}",
                                        fee: "${state.feeDetails.fee}",
                                        payType: "Full",
                                        paymentMethod: "Offline",
                                        months: monthController.text,
                                        referenceId: "refrence",
                                        joiningDate:
                                            "${state.feeDetails.validFrom}",
                                        validFrom:
                                            "${state.feeDetails.validFrom}",
                                        validTo: "${state.feeDetails.validTo}");
                                    context.read<RenewalBloc>().add(
                                        SendRenewalRequestEvent(
                                            params: params));
                                  } else {
                                    final state =
                                        context.read<RenewalBloc>().state;
                                    _startPayment(state);
                                    // webhook api for get transaction id
                                    /*  final profileState =
                                        context.read<ProfileBloc>().state;
                                    log("profileState.basicData.id!.toString()");
                                    context.read<RenewalBloc>().add(RenewalWebhookEvent(
                                        params: PmRenewalWebhook(
                                            extraFee: num.parse(
                                                "${state.feeDetails.extraFee}"),
                                            extraClassFee: num.tryParse(
                                                "${widget.extraClassFee}"),
                                            fee: num.parse(
                                                "${state.feeDetails.fee}"),
                                            payType: "Full",
                                            paymentMethod: "Online",
                                            months: int.parse(
                                                monthController.text),
                                            joiningDate:
                                                "${state.feeDetails.validFrom}",
                                            validFrom:
                                                "${state.feeDetails.validFrom}",
                                            validTo:
                                                "${state.feeDetails.validTo}",
                                            transactionId:
                                                "#TRXPAID${profileState.basicData.id!}"))); */
                                  }
                                },
                                label: 'Proceed',
                                backgroundColor: AppColors.primaryColor,
                                labelColor: AppColors.secondaryColor,
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
                  ],
                )),
          ),
        ));
  }

  Widget dataTile(Size kSize, String label, String data) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: kSize.height * 0.012, horizontal: 20),
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

// Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("Payment success: ${response.paymentId}");
    log("orderid${response.orderId}");

    final state = context.read<RenewalBloc>().state;
    final params = PmSendRenewRequestModel(
        extraFee: "${state.feeDetails.extraFee}",
        extraClassFee: "${widget.extraClassFee}",
        fee: "${state.feeDetails.fee}",
        payType: "Full",
        paymentMethod: "Online",
        months: monthController.text,
        referenceId: "${response.paymentId}",
        joiningDate: "${state.feeDetails.validFrom}",
        validFrom: "${state.feeDetails.validFrom}",
        validTo: "${state.feeDetails.validTo}");
    context.read<RenewalBloc>().add(SendRenewalRequestEvent(params: params));
  }

// Handle payment failure
  void _handlePaymentError(PaymentFailureResponse response) {
    log("Payment error: ${response.code.toString()} - ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${response.message}"),
      backgroundColor: AppColors.redColor,
    ));
  }

// Handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External wallet: ${response.walletName}");
  }

// start payment
  void _startPayment(RenewalState renewalState) {
    final state = context.read<ProfileBloc>().state;
    int amountInPaisa = (sumTotalFee(
                    renewalState.feeDetails.extraFee!.round(),
                    num.parse(widget.extraClassFee),
                    monthController.text == "1"
                        ? renewalState.feeDetails.fee!.round()
                        : calculateDiscountedFee(
                            renewalState.feeDetails.fee!.round(),
                            monthController.text == "3" ? 0.035 : 0.06))
                .round() *
            100)
        .round();
    Map<String, dynamic> options = {
      'key': 'rzp_live_BUSmhSPjTh6whJ',
      'amount': amountInPaisa,
      'name': "Philip's Piano Academy",
      'description': 'Payment for participation in your music class.',
      'prefill': {
        'contact': '${state.basicData.mobile}',
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

// get sum total amount
  num sumTotalFee(num renewalFee, num extraClassFee, num fee) {
    var totalSumFee = renewalFee + extraClassFee + fee;
    return totalSumFee;
  }

  num calculateDiscountedFee(num totalFee, num discountPercentage) {
    return totalFee - (totalFee * discountPercentage);
  }
}

class SendRequestModel {
  String? day;
  int? planId;
  String? payType;
  SendRequestModel({this.day, this.planId, this.payType});
}
