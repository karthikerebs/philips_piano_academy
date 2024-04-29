import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/credit_class/credit_class_bloc.dart';
import 'package:music_app/src/application/paid_class/paid_class_bloc.dart';
// import 'package:music_app/src/domain/models/response_models/slot_model/slote.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/footer_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/credit_class_change_date/widgets/select_date_widget.dart';
import 'package:music_app/src/presentation/view/credit_class_change_date/widgets/select_slote_list.dart';
import 'package:music_app/src/presentation/view/credit_class_change_date/widgets/upcoming_slote_list.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';

class ChangeCreditClassView extends StatefulWidget {
  const ChangeCreditClassView({super.key, required this.classId});
  final int classId;
  @override
  State<ChangeCreditClassView> createState() => _ChangeCreditClassViewState();
}

class _ChangeCreditClassViewState extends State<ChangeCreditClassView> {
  TextEditingController dateController = TextEditingController();
  var dateFormat = DateFormat('dd/MM/yyyy');
  ValueNotifier<int> isSelectSlot = ValueNotifier(-1);
  ValueNotifier<int> selectedSlote = ValueNotifier(-1);
  ValueNotifier<List<List<int>>> selectedItemIndices =
      ValueNotifier<List<List<int>>>([]);
  @override
  void initState() {
    context.read<CreditClassBloc>().add(const UpcomingCreditSloteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: "Credit Class"),
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * .08),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SelectDateWidget(
                dateController: dateController, dateFormat: dateFormat),
            // const Spacer(),
            SizedBox(height: kSize.height * .02),

            MultiBlocListener(
              listeners: [
                BlocListener<CreditClassBloc, CreditClassState>(
                  listenWhen: (previous, current) =>
                      previous.bookStatus != current.bookStatus,
                  listener: (context, state) {
                    if (state.bookStatus is StatusLoading) {
                      CustomLoading.show(context);
                    } else if (state.bookStatus is StatusSuccess) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      CustomMessage(
                              context: context,
                              message: "Slot booked successfully.",
                              style: MessageStyle.success)
                          .show();
                      context
                          .read<CreditClassBloc>()
                          .add(const GetCreditClassEvent());
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
                ),
                BlocListener<PaidClassBloc, PaidClassState>(
                  listenWhen: (previous, current) =>
                      previous.checkPaidStatus != current.checkPaidStatus,
                  listener: (context, state) {
                    if (state.checkPaidStatus is StatusSuccess) {
                      if (state.checPaidClassData.message ==
                          "Slot is available.") {
                        context.read<CreditClassBloc>().add(
                            BookCreditClassEvent(
                                date: formattedDate(dateController.text),
                                classId: widget.classId.toString(),
                                slotId: selectedSlote.value.toString()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              '${state.checPaidClassData.message}',
                              style: TextStyle(color: Colors.black),
                            )));
                      }
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
                  },
                ),
              ],
              child: Center(
                child: FooterButton(
                  label: 'Apply',
                  onPressed: () {
                    bookClass();
                  },
                  padding: EdgeInsets.symmetric(
                      horizontal: kSize.width * .17,
                      vertical: kSize.height * .023),
                ),
              ),
            ),
            SizedBox(height: kSize.height * .02),
            BlocBuilder<CreditClassBloc, CreditClassState>(
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
                    return SelectSloteList(
                      state: state,
                      isSelectSlot: isSelectSlot,
                      selectedSlote: selectedSlote,
                    );
                  } else {
                    return UpcomingSloteList(
                        dateController: dateController,
                        state: state,
                        isSelectSlot: isSelectSlot,
                        selectedSlote: selectedSlote);
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
            // const Spacer(),
          ]),
        ),
      ),
    );
  }

  void bookClass() {
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
      context.read<PaidClassBloc>().add(CheckPaidClassEvent(
          classDate: formattedDate(dateController.text),
          slotId: selectedSlote.value.toString()));
/*       context.read<CreditClassBloc>().add(BookCreditClassEvent(
          date: formattedDate(dateController.text),
          classId: widget.classId.toString(),
          slotId: selectedSlote.value.toString())); */
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
