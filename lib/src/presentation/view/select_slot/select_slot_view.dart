import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/auth/bloc/auth_bloc.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/slot_booking/slot_booking_bloc.dart';
import 'package:music_app/src/domain/core/pref_key/preference_key.dart';
import 'package:music_app/src/domain/models/response_models/slot_model/slote.dart';
import 'package:music_app/src/infrastructure/core/preference_helper.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/drop_down.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/primary_button.dart';
import 'package:music_app/src/presentation/view/select_slot/widgets/slote_list.dart';

class SelectSlotView extends StatefulWidget {
  const SelectSlotView({super.key});

  @override
  State<SelectSlotView> createState() => _SelectSlotViewState();
}

class _SelectSlotViewState extends State<SelectSlotView> {
  List<String> daysList = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String dropdownValue = "";
  TextEditingController dayController = TextEditingController();
  ValueNotifier<Slote> selectedSlote = ValueNotifier<Slote>(const Slote());
  final isValidate = ValueNotifier(true);
  final formKey = GlobalKey<FormState>();
  ValueNotifier<int> isSelectSlot = ValueNotifier(-1);
  final name = ValueNotifier("");
  @override
  void initState() {
    getName();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return appBar(kSize, state);
                  },
                ),
                Center(
                  child: Text(AppStrings.selectYourClassSlot,
                      style: AppTypography.dmSansMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.028)),
                ),
                SizedBox(height: kSize.height * 0.0094),
                Center(
                  child: Text(AppStrings.slotDescription,
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: kSize.height * 0.0189)),
                ),
                SizedBox(height: kSize.height * 0.0213),
                DropDownButton(
                  hintText: 'Choose Day',
                  fillColor: AppColors.secondaryColor,
                  hintColor: AppColors.primaryColor,
                  isValidate: isValidate,
                  errorMessage: "select day",
                  dropList: daysList,
                  borderColor: AppColors.primaryColor,
                  onSelected: (selected) {
                    dayController.text = selected;
                    context
                        .read<SlotBookingBloc>()
                        .add(GetSlotsEvent(param: selected));
                  },
                ),
                SizedBox(height: kSize.height * 0.0414),
                BlocConsumer<SlotBookingBloc, SlotBookingState>(
                  listener: (context, state) {
                    if (state.status is StatusAuthFailure) {
                      CustomMessage(
                              context: context,
                              message: 'Access Denied. Kindly reauthenticate.',
                              style: MessageStyle.error)
                          .show();
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouterConstants.splashRoute, (route) => false);
                    }
                  },
                  builder: (context, state) {
                    if (state.status is StatusLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.blackColor,
                      ));
                    } else if (state.status is StatusSuccess) {
                      return SloteList(
                        day: dayController.text,
                        state: state,
                        isSelectSlot: isSelectSlot,
                        selectedSlote: selectedSlote,
                      );
                    } else if (state.status is StatusFailure) {
                      final status = state.status as StatusFailure;
                      return Center(child: Text(status.errorMessage));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const Spacer(),
                ValueListenableBuilder(
                  valueListenable: isSelectSlot,
                  builder: (context, value, child) {
                    return ValueListenableBuilder(
                      valueListenable: isValidate,
                      builder: (context, value, child) {
                        return PrimaryButton(
                            backgroundColor: isSelectSlot.value != -1
                                ? AppColors.primaryColor
                                : AppColors.greyColor,
                            labelColor: AppColors.secondaryColor,
                            onPressed: () {
                              if (dayController.text.isEmpty) {
                                isValidate.value = false;
                              } else {
                                isValidate.value = true;
                              }
                              if (isSelectSlot.value != -1) {
                                Navigator.pushNamed(
                                    context, RouterConstants.choosePaymentRoute,
                                    arguments: {
                                      "day": dayController.text,
                                      "slote": selectedSlote.value.slote,
                                      "slotId": selectedSlote.value.id
                                    });
                              }
                            },
                            label: 'Proceed');
                      },
                    );
                  },
                ),
                SizedBox(height: kSize.height * 0.028),
              ],
            ),
          )),
    );
  }

  Widget appBar(Size kSize, AuthState state) {
    return ValueListenableBuilder(
      valueListenable: name,
      builder: (context, dynamic, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kSize.height * .05),
            Text('Welcome ${name.value} 🥳',
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.022)),
            SizedBox(height: kSize.height * 0.021),
            Text(AppStrings.selectSlotDescription,
                style: AppTypography.dmSansRegular.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.0189)),
            SizedBox(height: kSize.height * 0.042),
          ],
        );
      },
    );
  }

  getName() async {
    name.value = await PreferenceHelper().getString(key: AppPrefeKeys.name);
  }
}
