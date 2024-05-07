import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/auth/bloc/auth_bloc.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/drop_down.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/primary_button.dart';
import 'package:music_app/src/presentation/core/widgets/scroll_behaviour.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';
import 'package:music_app/src/presentation/view/register/widgets/branch_dropdown.dart';

class SelectBranch extends StatefulWidget {
  const SelectBranch({super.key});

  @override
  State<SelectBranch> createState() => _SelectBranchState();
}

class _SelectBranchState extends State<SelectBranch> {
  TextEditingController classController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> classList = <String>[
    'Online',
    'Offline ( 	Koramangala , Haralur )',
  ];
  String classDropdownValue = "";
  String branchDropdownValue = "";
  final isValidate = ValueNotifier(true);
  ValueNotifier dropdownValue = ValueNotifier("");
  var dateFormat = DateFormat('dd/MM/yyyy');
  DateTime? selectedDate;
  final showGuardiansField = ValueNotifier(false);
  final errorMessage = ValueNotifier("User name should not be empty");
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          backgroundColor: AppColors.secondaryColor,
          appBar: CustomAppBar(title: "Get Slot"),
          body: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.registerStatus != current.registerStatus,
            listener: (context, state) {
              if (state.registerStatus is StatusLoading) {
                CustomLoading.show(context);
              } else if (state.registerStatus is StatusSuccess) {
                Navigator.pushReplacementNamed(
                    context, RouterConstants.loginRoute);
                CustomMessage(
                        context: context,
                        message: 'User registered successfully',
                        style: MessageStyle.success)
                    .show();
              } else if (state.registerStatus is StatusFailure) {
                final status = state.registerStatus as StatusFailure;
                CustomLoading.dissmis(context);
                CustomMessage(
                        context: context,
                        message: status.errorMessage,
                        style: MessageStyle.error)
                    .show();
              }
            },
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehaviour(),
              child: Form(
                key: formKey,
                child: SizedBox(
                  height: kSize.height,
                  width: kSize.width,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kSize.width * 0.05),
                          child: ValueListenableBuilder(
                            valueListenable: showGuardiansField,
                            builder: (context, dynamic, child) {
                              return ValueListenableBuilder(
                                valueListenable: errorMessage,
                                builder: (context, dynamic, child) {
                                  return ValueListenableBuilder(
                                    valueListenable: dropdownValue,
                                    builder: (context, value, child) {
                                      return ValueListenableBuilder(
                                        valueListenable: isValidate,
                                        builder: (context, value, child) {
                                          return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                DropDownButton(
                                                  hintColor:
                                                      AppColors.greyColor,
                                                  isValidate: isValidate,
                                                  fillColor: AppColors
                                                      .textFieldFillColor,
                                                  borderColor:
                                                      AppColors.transparent,
                                                  onSelected: (selectedIndex) {
                                                    dropdownValue.value =
                                                        selectedIndex;
                                                    if (dropdownValue.value ==
                                                        "Offline ( 	Koramangala , Haralur )") {
                                                      context.read<AuthBloc>().add(
                                                          const GetBrachesEvent());
                                                    }
                                                    classController.text =
                                                        selectedIndex;
                                                  },
                                                  errorMessage:
                                                      'Please select class',
                                                  dropList: classList,
                                                  hintText:
                                                      'Choose Preferred Class Mode*',
                                                ),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                dropdownValue.value ==
                                                        "Offline ( 	Koramangala , Haralur )"
                                                    ? BlocConsumer<AuthBloc,
                                                        AuthState>(
                                                        listener:
                                                            (context, state) {},
                                                        buildWhen: (previous,
                                                                current) =>
                                                            previous.status !=
                                                            current.status,
                                                        builder:
                                                            (context, state) {
                                                          if (state.status
                                                              is StatusLoading) {
                                                            return Center(
                                                              child: CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      1,
                                                                  color: Colors
                                                                      .black),
                                                            );
                                                          } else if (state
                                                                  .status
                                                              is StatusSuccess) {
                                                            return BranchDropDownButton(
                                                                fillColor: AppColors
                                                                    .textFieldFillColor,
                                                                isValidate:
                                                                    isValidate,
                                                                hintColor:
                                                                    AppColors
                                                                        .greyColor,
                                                                borderColor:
                                                                    AppColors
                                                                        .transparent,
                                                                onSelected:
                                                                    (selectedIndex) {
                                                                  branchDropdownValue =
                                                                      selectedIndex;
                                                                  branchController
                                                                          .text =
                                                                      selectedIndex;
                                                                },
                                                                errorMessage:
                                                                    'Please select branch',
                                                                dropList: state
                                                                    .branchList,
                                                                hintText:
                                                                    'Choose Preferred Branch*');
                                                          } else if (state
                                                                  .status
                                                              is StatusFailure) {
                                                            final status = state
                                                                    .status
                                                                as StatusFailure;
                                                            return Text(status
                                                                .errorMessage);
                                                          } else {
                                                            return const SizedBox();
                                                          }
                                                        },
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                    height: kSize.height * .03),
                                                PrimaryButton(
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    onPressed: () {
                                                      if (classController
                                                          .text.isEmpty) {
                                                        isValidate.value =
                                                            false;
                                                      } else if (classController
                                                              .text ==
                                                          "Online") {
                                                        isValidate.value = true;
                                                      } else if (branchController
                                                          .text.isNotEmpty) {
                                                        isValidate.value = true;
                                                      } else {
                                                        isValidate.value =
                                                            false;
                                                      }
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        if (classController
                                                                    .text ==
                                                                "Offline ( 	Koramangala , Haralur )" &&
                                                            branchController
                                                                .text.isEmpty) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              backgroundColor:
                                                                  AppColors
                                                                      .redColor,
                                                              content: Text(
                                                                "Please select any branch.",
                                                                style: AppTypography
                                                                    .dmSansRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        color: AppColors
                                                                            .secondaryColor),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          if (classController
                                                                  .text ==
                                                              "Online") {
                                                            branchController
                                                                    .text =
                                                                0.toString();
                                                          }
                                                          print(branchController
                                                              .text);
                                                          // final param = PmRegisterModel(
                                                          //     username: userNameController
                                                          //         .text,
                                                          //     name: firstNameController
                                                          //             .text +
                                                          //         " ${lastNameController.text}",
                                                          //     address:
                                                          //         addressController
                                                          //             .text,
                                                          //     dob: formattedDate(
                                                          //         dateOfBirthController
                                                          //             .text),
                                                          //     email: emailController
                                                          //         .text,
                                                          //     mobile:
                                                          //         phoneController
                                                          //             .text,
                                                          //     guardian:
                                                          //         gardiensNameController
                                                          //             .text,
                                                          //     password:
                                                          //         passwordController
                                                          //             .text,
                                                          //     alternativeMobile:
                                                          //         alternativePhoneController
                                                          //             .text,
                                                          //     branch:
                                                          //         branchDropdownValue,
                                                          //     classMode: classController
                                                          //                 .text ==
                                                          //             "Offline ( 	Koramangala , Haralur )"
                                                          //         ? "Offline"
                                                          //         : classController
                                                          //             .text);
                                                          // context
                                                          //     .read<AuthBloc>()
                                                          //     .add(RegisterEvent(
                                                          //         pmRegisterModel:
                                                          //             param));
                                                        }
                                                      }
                                                    },
                                                    labelColor: AppColors
                                                        .secondaryColor,
                                                    label: "Get Slot"),
                                                SizedBox(
                                                    height: kSize.height * .03),
                                              ]);
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
