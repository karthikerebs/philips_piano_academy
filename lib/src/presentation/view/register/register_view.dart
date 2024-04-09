import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/auth/bloc/auth_bloc.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/models/pm_models/pm_register_model/pm_register_model.dart';
import 'package:music_app/src/presentation/core/constants/strings.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/drop_down.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/primary_button.dart';
import 'package:music_app/src/presentation/core/widgets/scroll_behaviour.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/core/widgets/validators.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/view/register/widgets/branch_dropdown.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController gardiensNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alternativePhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> classList = <String>[
    'Online',
    'Offline',
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
                                                CustomTextField(
                                                    hintText:
                                                        'Students First Name*',
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    controller:
                                                        firstNameController,
                                                    errorMessage:
                                                        "Please enter valid name",
                                                    validator: (value) {
                                                      return FormValidators
                                                          .nameValidate(value);
                                                    },
                                                    keyboardType:
                                                        TextInputType.name),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomTextField(
                                                    hintText: 'Last Name*',
                                                    controller:
                                                        lastNameController,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    errorMessage:
                                                        "Please enter valid name",
                                                    validator: (value) {
                                                      return FormValidators
                                                          .nameValidate(value);
                                                    },
                                                    keyboardType:
                                                        TextInputType.name),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomDatePicker(
                                                    validator: (value) {
                                                      return FormValidators
                                                          .emptyValidate(value);
                                                    },
                                                    dateController:
                                                        dateOfBirthController,
                                                    borderColor:
                                                        AppColors.transparent,
                                                    fillColor: AppColors
                                                        .textFieldFillColor,
                                                    errorMessage:
                                                        "Please enter valid date of birth",
                                                    suffixIcon:
                                                        const SizedBox(),
                                                    hintText:
                                                        'Date of Birth (DD/MM/YYYY)*',
                                                    initialDatePickerMode:
                                                        DatePickerMode.year,
                                                    onChanged: (value) {
                                                      dateOfBirthController
                                                              .text =
                                                          dateFormat
                                                              .format(value);
                                                      isShowGuardiansField(
                                                          value);
                                                    }),
                                                showGuardiansField.value
                                                    ? SizedBox(
                                                        height:
                                                            kSize.height * .015)
                                                    : const SizedBox(),
                                                Visibility(
                                                  visible:
                                                      showGuardiansField.value,
                                                  child: CustomTextField(
                                                      hintText:
                                                          'Guardian’s Name*',
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      errorMessage:
                                                          "Guardian’s name should not be empty",
                                                      validator: (value) {
                                                        return FormValidators
                                                            .nameValidate(
                                                                value);
                                                      },
                                                      controller:
                                                          gardiensNameController),
                                                ),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomTextField(
                                                  hintText: 'Whatsapp Number*',
                                                  prefixIcon: CountryCodePicker(
                                                    onChanged: print,
                                                    showFlag: true,
                                                    initialSelection: '+91',
                                                    flagWidth: 20,
                                                    favorite: ['+91'],
                                                    showCountryOnly: false,
                                                    showOnlyCountryWhenClosed:
                                                        false,
                                                    alignLeft: false,
                                                  ),
                                                  controller: phoneController,
                                                  errorMessage:
                                                      "Please enter valid whatsapp number",
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    return FormValidators
                                                        .phoneValidate(value);
                                                  },
                                                  maxLength: 10,
                                                ),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomTextField(
                                                    prefixIcon:
                                                        CountryCodePicker(
                                                      onChanged: print,
                                                      showFlag: true,
                                                      initialSelection: '+91',
                                                      flagWidth: 20,
                                                      favorite: ['+91'],
                                                      showCountryOnly: false,
                                                      showOnlyCountryWhenClosed:
                                                          false,
                                                      alignLeft: false,
                                                    ),
                                                    hintText:
                                                        'Alternative Phone (Optional)',
                                                    onChanged: (value) {
                                                      if (value ==
                                                          phoneController
                                                              .text) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .blackColor,
                                                                    content:
                                                                        Text(
                                                                      "whatsapp number and alternative mobile number cannot be the same.",
                                                                      style: AppTypography.dmSansRegular.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              AppColors.secondaryColor),
                                                                    )));
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    maxLength: 10,
                                                    controller:
                                                        alternativePhoneController),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomTextField(
                                                    hintText: 'Email*',
                                                    controller: emailController,
                                                    errorMessage:
                                                        "Please enter valid email",
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    validator: (value) {
                                                      return FormValidators
                                                          .emailValidate(value);
                                                    }),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomTextField(
                                                    hintText:
                                                        'Address (Optional)',
                                                    controller:
                                                        addressController,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    errorMessage:
                                                        "Please enter valid address",
                                                    keyboardType:
                                                        TextInputType.name),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomTextField(
                                                    hintText: 'User Name*',
                                                    controller:
                                                        userNameController,
                                                    helperText:
                                                        "Letters and numbers only, no symbols or spaces.",
                                                    errorMessage:
                                                        errorMessage.value,
                                                    onChanged: (value) {
                                                      validateName(value);
                                                    },
                                                    validator: (value) {
                                                      return FormValidators
                                                          .userNameValidate(
                                                              value);
                                                    },
                                                    keyboardType:
                                                        TextInputType.name),
                                                SizedBox(
                                                    height:
                                                        kSize.height * .015),
                                                CustomTextField(
                                                    hintText: 'Password*',
                                                    helperText:
                                                        "Letters and numbers only, no symbols or spaces.",
                                                    controller:
                                                        passwordController,
                                                    errorMessage:
                                                        "Please enter valid password",
                                                    validator: (value) {
                                                      return FormValidators
                                                          .userNameValidate(
                                                              value);
                                                    },
                                                    keyboardType: TextInputType
                                                        .visiblePassword),
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
                                                        "Offline") {
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
                                                dropdownValue.value == "Offline"
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
                                                                  'Choose Preferred Branch*',
                                                            );
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
                                                      isValidate.value = false;
                                                    } else if (classController
                                                            .text ==
                                                        "Online") {
                                                      isValidate.value = true;
                                                    } else if (branchController
                                                        .text.isNotEmpty) {
                                                      isValidate.value = true;
                                                    } else {
                                                      isValidate.value = false;
                                                    }
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      if (phoneController
                                                              .text ==
                                                          alternativePhoneController
                                                              .text) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .blackColor,
                                                                    content:
                                                                        Text(
                                                                      "whatsapp number and alternative mobile number cannot be the same.",
                                                                      style: AppTypography.dmSansRegular.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              AppColors.secondaryColor),
                                                                    )));
                                                      } else if (classController
                                                                  .text ==
                                                              "Offline" &&
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
                                                                    content:
                                                                        Text(
                                                                      "Please select any branch.",
                                                                      style: AppTypography.dmSansRegular.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              AppColors.secondaryColor),
                                                                    )));
                                                      } else {
                                                        final param = PmRegisterModel(
                                                            username: userNameController
                                                                .text,
                                                            name: firstNameController
                                                                    .text +
                                                                " ${lastNameController.text}",
                                                            address:
                                                                addressController
                                                                    .text,
                                                            dob: formattedDate(
                                                                dateOfBirthController
                                                                    .text),
                                                            email: emailController
                                                                .text,
                                                            mobile:
                                                                phoneController
                                                                    .text,
                                                            guardian:
                                                                gardiensNameController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            alternativeMobile:
                                                                alternativePhoneController
                                                                    .text,
                                                            branch:
                                                                branchDropdownValue,
                                                            classMode:
                                                                classController
                                                                    .text);
                                                        context
                                                            .read<AuthBloc>()
                                                            .add(RegisterEvent(
                                                                pmRegisterModel:
                                                                    param));
                                                      }
                                                    }
                                                  },
                                                  labelColor:
                                                      AppColors.secondaryColor,
                                                  label: AppStrings.signUp,
                                                ),
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

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("dd/MM/yyyy").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  void isShowGuardiansField(DateTime? date) {
    if (date != null) {
      final age = DateTime.now().difference(date).inDays ~/ 365;
      showGuardiansField.value = age <= 18;
    }
  }

  void validateName(String value) {
    if (value.isEmpty) {
      errorMessage.value = 'User name should not be empty';
    } else {
      RegExp regExp = RegExp(r'^[a-zA-Z0-9]+$');
      if (!regExp.hasMatch(value)) {
        errorMessage.value =
            'User name should only contain letters and numbers.';
      } else {
        errorMessage.value = '';
      }
    }
  }
}
