import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/paid_class/paid_class_bloc.dart';
import 'package:music_app/src/domain/models/response_models/upcoming_paid_slote_model/upcoming_paid_slote_model.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/paid_class_change/widgets/select_slote_list.dart';
import 'package:music_app/src/presentation/view/paid_class_change/widgets/upcoming_slote_list.dart';

class ChangePaidClassView extends StatefulWidget {
  const ChangePaidClassView({super.key});

  @override
  State<ChangePaidClassView> createState() => _ChangePaidClassViewState();
}

class _ChangePaidClassViewState extends State<ChangePaidClassView> {
  TextEditingController dateController = TextEditingController();
  var dateFormat = DateFormat('dd/MM/yyyy');
  ValueNotifier<int> isSelectSlot = ValueNotifier(-1);
  ValueNotifier<int> selectedSlote = ValueNotifier(-1);
  ValueNotifier<List<List<int>>> selectedItemIndices =
      ValueNotifier<List<List<int>>>([]);
  ValueNotifier<String> date = ValueNotifier('');
  @override
  void initState() {
    context.read<PaidClassBloc>().add(const UpcomingSloteEvent());
    context.read<HomeBloc>().add(const GetPaymentStatusEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: kSize.width * 0.12,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: kSize.width * 0.04),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * .08),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Select Date',
                style: AppTypography.dmSansRegular.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.028)),
            SizedBox(height: kSize.height * .015),
            CustomDatePicker(
              dateController: dateController,
              errorMessage: '',
              firstDate: DateTime.now(),
              hintText: 'Select Date',
              hintColor: AppColors.primaryColor,
              onChanged: (value) {
                dateController.text = dateFormat.format(value);
                context.read<PaidClassBloc>().add(GetPaidClassSloteEvent(
                    date: formattedDate(dateController.text)));
              },
            ),
            SizedBox(height: kSize.height * .03),
            BlocBuilder<PaidClassBloc, PaidClassState>(
              builder: (context, state) {
                return Center(
                  child: FooterButton(
                    label: 'Apply',
                    onPressed: () {
                      bookClass(state.paidSloteDetails);
                    },
                    padding: EdgeInsets.symmetric(
                        horizontal: kSize.width * .17,
                        vertical: kSize.height * .023),
                  ),
                );
              },
            ),
            SizedBox(height: kSize.height * .03),
            BlocConsumer<PaidClassBloc, PaidClassState>(
              listener: (context, state) {
                if (state.upcomingSlotStatus is StatusAuthFailure) {
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
              // buildWhen: (previous, current) =>
              //     previous.upcomingSlotStatus != current.upcomingSlotStatus,
              builder: (context, state) {
                if (state.upcomingSlotStatus is StatusLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor),
                  );
                } else if (state.upcomingSlotStatus is StatusSuccess) {
                  if (state.slotStatus is StatusLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor),
                    );
                  } else if (state.slotStatus is StatusSuccess) {
                    return PaidSelectSloteList(
                      state: state,
                      isSelectSlot: isSelectSlot,
                      selectedSlote: selectedSlote,
                    );
                  } else {
                    if (state
                        .paidSloteDetails.datesAndAvailableSlotes!.isNotEmpty) {
                      return PaidUpcomingSloteList(
                          state: state,
                          dateController: dateController,
                          isSelectSlot: isSelectSlot,
                          selectedSlote: selectedSlote);
                    } else {
                      return const Center(
                        child: Text("No slotes available!"),
                      );
                    }
                  }
                } else if (state.upcomingSlotStatus is StatusFailure) {
                  final status = state.upcomingSlotStatus as StatusFailure;
                  return Center(
                    child: Text(status.errorMessage),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ]),
        ),
      ),
    );
  }

  void bookClass(UpcomingPaidSloteModel paidSloteDetails) {
    if (dateController.text == "") {
      CustomMessage(
              context: context,
              message: 'Please select date',
              style: MessageStyle.error)
          .show();
    } else if (selectedSlote.value == -1) {
      CustomMessage(
              context: context,
              message: 'Please select slote',
              style: MessageStyle.error)
          .show();
    } else {
      final state = context.read<HomeBloc>().state;
      if (state.paymentStatusData.onlinepayStatus == 'Disabled') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Payment not possible. Please reach out to the admin for assistance.')));
      } else {
        Navigator.pushNamed(context, RouterConstants.paidFeeDeatilsRoute,
            arguments: {
              "fee": paidSloteDetails.fee!,
              'date': dateController.text,
              'slote': selectedSlote.value.toString()
            });
        /*  _startPayment(paidSloteDetails); */
      }
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
