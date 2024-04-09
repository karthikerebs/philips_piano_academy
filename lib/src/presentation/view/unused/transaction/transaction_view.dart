import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetReceiptsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: kSize.width * 0.12,
        elevation: 0,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "Transaction History",
          style: TextStyle(color: Colors.black),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: kSize.width * 0.04),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state.receiptsStatus is StatusAuthFailure) {
                CustomMessage(
                        context: context,
                        message: 'Access Denied. Kindly reauthenticate.',
                        style: MessageStyle.error)
                    .show();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouterConstants.splashRoute, (route) => false);
              }
            },
            builder: (context, state) {
              if (state.receiptsStatus is StatusLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else if (state.receiptsStatus is StatusSuccess) {
                if (state.receiptsList.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: state.receiptsList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                          width: kSize.width,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            color: AppColors.lightgreyColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dataTile(
                                      'Payment Date',
                                      '${formattedDate(state.receiptsList[index].paymentDate!)}',
                                      kSize),
                                  dataTile(
                                      "Fee Type",
                                      '${state.receiptsList[index].type}',
                                      kSize),
                                  dataTile(
                                      'Fee',
                                      '₹ ${state.receiptsList[index].fee!.round()}',
                                      kSize),
                                  state.receiptsList[index].deposit != null
                                      ? state.receiptsList[index].deposit > 0
                                          ? dataTile(
                                              "Deposit",
                                              "₹ ${state.receiptsList[index].deposit}",
                                              kSize)
                                          : SizedBox()
                                      : SizedBox(),
                                  state.receiptsList[index].extraFee != null
                                      ? state.receiptsList[index].extraFee > 0
                                          ? dataTile(
                                              "Extra Fee",
                                              "₹ ${state.receiptsList[index].extraFee}",
                                              kSize)
                                          : SizedBox()
                                      : SizedBox(),
                                  state.receiptsList[index].extraClassFee !=
                                          null
                                      ? state.receiptsList[index]
                                                  .extraClassFee >
                                              0
                                          ? dataTile(
                                              "Extra Class Fee",
                                              "₹${state.receiptsList[index].extraClassFee}",
                                              kSize)
                                          : SizedBox()
                                      : SizedBox(),
                                ],
                              ),
                              FooterButton(
                                fontSize: kSize.height * 0.015,
                                label: 'Download',
                                backgroundColor: AppColors.blackColor,
                                labelColor: AppColors.secondaryColor,
                                onPressed: () {
                                  _downloadInvoice(
                                      requestId: state.receiptsList[index].id);
                                },
                              )
                            ],
                          ));
                    },
                  );
                } else {
                  return Center(
                    child: Text("No receipts found!"),
                  );
                }
              } else if (state.receiptsStatus is StatusFailure) {
                final status = state.receiptsStatus as StatusFailure;
                return Center(
                  child: Text(status.errorMessage),
                );
              } else {
                return SizedBox();
              }
            },
          )),
    );
  }

  Future<void> _downloadInvoice({required requestId}) async {
    final _url = Uri.parse(
        "https://philipspianoacademy.erebs.in/administrator/student-receipt/${requestId}");
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget dataTile(String label, String data, Size kSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text('${label} : ${data}',
          style: AppTypography.dmSansRegular.copyWith(
              color: AppColors.primaryColor, fontSize: kSize.height * 0.016)),
    );
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMM, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
