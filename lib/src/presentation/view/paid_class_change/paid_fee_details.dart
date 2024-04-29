import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/paid_class/paid_class_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_paid_slote_model/upcoming_paid_slote_model.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaidClassFeeDetails extends StatefulWidget {
  const PaidClassFeeDetails(
      {super.key,
      required this.paidClassFee,
      required this.date,
      required this.slotId});
  final String paidClassFee;
  final String date;
  final String slotId;
  @override
  State<PaidClassFeeDetails> createState() => _PaidClassFeeDetailsState();
}

class _PaidClassFeeDetailsState extends State<PaidClassFeeDetails> {
  Razorpay? _razorpay;
  @override
  void initState() {
    context.read<HomeBloc>().add(const GetPaymentStatusEvent());
    context.read<PaidClassBloc>().add(CheckPaidClassEvent(
        classDate: formattedDate(widget.date), slotId: widget.slotId));
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<PaidClassBloc, PaidClassState>(
            listenWhen: (previous, current) =>
                previous.bookStatus != current.bookStatus,
            listener: (context, state) {
              if (state.bookStatus is StatusLoading) {
                CustomLoading.show(context);
              } else if (state.bookStatus is StatusSuccess) {
                CustomLoading.dissmis(context);
                Navigator.pop(context);
                Navigator.pop(context);
                context
                    .read<PaidClassBloc>()
                    .add(const GetPaidClassListEvent());
                CustomMessage(
                        context: context,
                        message: "Class booked successfully.",
                        style: MessageStyle.success)
                    .show();
              } else if (state.bookStatus is StatusFailure) {
                CustomLoading.dissmis(context);
                final status = state.bookStatus as StatusFailure;
                CustomMessage(
                        context: context,
                        message: status.errorMessage,
                        style: MessageStyle.error)
                    .show();
              } else if (state.bookStatus is StatusAuthFailure) {
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
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: kSize.height * .08),
                  Row(
                    children: [
                      CustomBackButton(onTap: () {
                        Navigator.pop(context);
                      }),
                      Spacer(),
                      Text(
                        'Fee For Paid Class',
                        style: AppTypography.dmSansBold.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Music class fee covers expert instruction and valuable resources, ensuring a rewarding learning experience for all students",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Fee   :   ',
                        style: AppTypography.dmSansBold.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: kSize.height * 0.025),
                      ),
                      Text('₹${widget.paidClassFee} ( 18% gst included )'),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FooterButton(
                      label: 'Proceed',
                      onPressed: () {
                        final homestate = context.read<HomeBloc>().state;
                        if (homestate.paymentStatusData.onlinepayStatus ==
                            'Disabled') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Payment not possible. Please reach out to the admin for assistance.')));
                        } else {
                          if (state.checkPaidStatus is StatusSuccess) {
                            _startPayment(state.paidSloteDetails);
                            // webhook api for get transaction id
                            /*   final profileState =
                                context.read<ProfileBloc>().state;
                            log("profileState.basicData.id!.toString()");
                            context.read<PaidClassBloc>().add(PaidWebhookEvent(
                                params: PmPaidWebhook(
                                    classDate: formattedDate(widget.date),
                                    paidAmount: num.parse(
                                        state.paidSloteDetails.fee ?? ""),
                                    sloteId: int.parse(widget.slotId),
                                    referenceId: "ReferenceId",
                                    transactionId:
                                        "#TRXPAID${profileState.basicData.id!}"))); */
                          } else if (state.checkPaidStatus is StatusFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: AppColors.redColor,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Slot already booked.',
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                )));
                          }
                        }
                      })
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("${response.data}");
    log("Payment success: ${response.paymentId}");
    final state = context.read<PaidClassBloc>().state;
    context.read<PaidClassBloc>().add(BookPaidClassEvent(
        date: formattedDate(widget.date),
        paidAmount: state.paidSloteDetails.fee ?? "",
        refernceId: "${response.paymentId}",
        sloteId: "${widget.slotId}"));
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

  void _startPayment(UpcomingPaidSloteModel paidSloteDetails) {
    final state = context.read<ProfileBloc>().state;
    num amountInPaisa = (num.parse(paidSloteDetails.fee!) * 100).round();
    Map<String, dynamic> options = {
      'key': "rzp_live_BUSmhSPjTh6whJ",
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

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("dd/MM/yyyy").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
