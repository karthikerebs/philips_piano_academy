import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/models/pm_models/pm_edit_profile_model/pm_edit_profile_model.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/custom_loading.dart';
import 'package:music_app/src/presentation/core/widgets/date_picker.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/view/edit_profile/widgets/upload_image.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController guardianController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var dateFormat = DateFormat('dd-MM-yyyy');
  ValueNotifier imageFile = ValueNotifier(XFile);
  @override
  void initState() {
    final state = context.read<ProfileBloc>().state;
    initData(state);
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
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              context.read<ProfileBloc>().add(GetProfileDataEvent());
            },
            child: SingleChildScrollView(
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listenWhen: (previous, current) =>
                    previous.editProfilestatus != current.editProfilestatus,
                listener: (context, state) {
                  if (state.editProfilestatus is StatusLoading) {
                    CustomLoading.show(context);
                  } else if (state.editProfilestatus is StatusSuccess) {
                    CustomLoading.dissmis(context);
                    context
                        .read<ProfileBloc>()
                        .add(const GetProfileDataEvent());
                    CustomMessage(
                            context: context,
                            message: 'Profile updated successfully',
                            style: MessageStyle.success)
                        .show();
                  } else if (state.editProfilestatus is StatusFailure) {
                    CustomLoading.dissmis(context);
                    final status = state.editProfilestatus as StatusFailure;
                    CustomMessage(
                            context: context,
                            message: status.errorMessage,
                            style: MessageStyle.error)
                        .show();
                  } else if (state.editProfilestatus is StatusAuthFailure) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: kSize.height * .01),
                      BlocListener<ProfileBloc, ProfileState>(
                        listenWhen: (previous, current) =>
                            previous.uploadStatus != current.uploadStatus,
                        listener: (context, state) {
                          if (state.uploadStatus is StatusSuccess) {
                            context
                                .read<ProfileBloc>()
                                .add(const GetProfileDataEvent());
                            CustomMessage(
                                    context: context,
                                    message: 'Photo changed successfully',
                                    style: MessageStyle.success)
                                .show();
                          }
                        },
                        child: Center(
                          child: state.uploadStatus is StatusLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.blackColor,
                                  ),
                                )
                              : state.profileData.profileDetails!.photo == null
                                  ? Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: kSize.height * 0.177,
                                      width: kSize.height * 0.177,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Image.network(
                                        'https://www.prognos.com/sites/default/files/styles/profile_image/public/2020-06/profile-pic-placeholder.png?itok=x2Ckkfjo',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: kSize.height * 0.177,
                                      width: kSize.height * 0.177,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: /* imageFile == null
                                                            ? */
                                          Image.network(
                                              "${AppUrls.imageBaseUrl}/${state.profileData.profileDetails!.photo}",
                                              fit: BoxFit.cover)
                                      /*  : Image.network(
                                                                "${AppUrls.imageBaseUrl}/${imageFile!.path}",
                                                                fit: BoxFit.cover) */
                                      ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      UploadImage(onTap: (value) {
                                        pickImage(value);
                                      }),
                                    ],
                                  );
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: kSize.height * .006)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Edit',
                                    style: AppTypography.dmSansRegular.copyWith(
                                        color: AppColors.primaryColor,
                                        decoration: TextDecoration.underline,
                                        fontSize: kSize.height * 0.0165)),
                                Icon(
                                  Icons.edit_outlined,
                                  size: kSize.height * 0.0213,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: kSize.height * .1),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kSize.width * 0.05),
                        child: Text('Basic Details',
                            style: AppTypography.dmSansRegular.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.0284)),
                      ),
                      SizedBox(height: kSize.height * .015),
                      Container(
                        height: 1,
                        color: AppColors.greyColor,
                        width: kSize.width,
                      ),
                      dataField(
                          kSize: kSize,
                          isEdit:
                              state.profileData.profileDetails!.profileEdit!,
                          label: 'Name',
                          editController: nameController,
                          description:
                              '${state.profileData.profileDetails!.name}'),
                      dataField(
                        kSize: kSize,
                        editController: emailController,
                        isEdit: 'Disabled',
                        label: 'Email',
                        description:
                            '${state.profileData.profileDetails!.email}',
                      ),
                      dataField(
                        kSize: kSize,
                        editController: phoneController,
                        isEdit: 'Disabled',
                        label: 'Phone',
                        description:
                            '${state.profileData.profileDetails!.mobile}',
                      ),
                      dataField(
                          kSize: kSize,
                          editController: guardianController,
                          label: 'Guardian’s Name',
                          isEdit:
                              state.profileData.profileDetails!.profileEdit!,
                          description: state
                                      .profileData.profileDetails!.guardian ==
                                  null
                              ? ""
                              : '${state.profileData.profileDetails!.guardian}'),
                      dataField(
                          kSize: kSize,
                          isEdit:
                              state.profileData.profileDetails!.profileEdit!,
                          label: 'Alternative Mobile',
                          editController: alternativeMobileController,
                          description: state.profileData.profileDetails!
                                      .alternativeMobile ==
                                  null
                              ? ""
                              : '${state.profileData.profileDetails!.alternativeMobile}'),
                      dataField(
                          isEdit:
                              state.profileData.profileDetails!.profileEdit!,
                          kSize: kSize,
                          label: 'Date of Birth',
                          editController: dobController,
                          description:
                              '${state.profileData.profileDetails!.dob}'),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }

  Widget dataField(
      {required Size kSize,
      required String label,
      required String description,
      required TextEditingController editController,
      required String isEdit}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kSize.height * 0.030),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: AppTypography.dmSansRegular.copyWith(
                          color: AppColors.greyColor,
                          fontSize: kSize.height * 0.0189)),
                  SizedBox(height: kSize.height * 0.008),
                  label == "Date of Birth"
                      ? Text(dateFormat.format(DateTime.parse(description)),
                          style: AppTypography.dmSansRegular.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.0236))
                      : Text(description,
                          style: AppTypography.dmSansRegular.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.0236)),
                ],
              ),
              isEdit == 'Enabled'
                  ? InkWell(
                      onTap: () {
                        editController.text = description;
                        if (editController == dobController) {
                          showDateOfBirth(kSize, editController);
                        } else {
                          show(kSize, editController);
                        }
                      },
                      child: Icon(
                        Icons.edit_outlined,
                        size: kSize.height * 0.0213,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        SizedBox(height: kSize.height * 0.030),
        Container(
          height: 1,
          color: AppColors.greyColor,
          width: kSize.width,
        )
      ],
    );
  }

  show(Size kSize, TextEditingController controller) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(
                left: kSize.width * .06,
                bottom: kSize.height * .04,
                right: kSize.width * .06),
            title: Center(
                child: Text(
              "Edit",
              style: AppTypography.dmSansMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.0284),
            )),
            actions: [
              CustomTextField(
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.transparent),
                      borderRadius: BorderRadius.circular(kSize.height * .013)),
                  hintText: '',
                  controller: controller,
                  maxLines: 1,
                  fillColor: AppColors.lightgreyColor1),
              SizedBox(height: kSize.height * .03),
              Center(
                  child: CommonButton(
                label: 'Submit',
                onTap: () {
                  Navigator.pop(context);
                  context.read<ProfileBloc>().add(EditProfileEvent(
                      params: PmEditProfileModel(
                          dob: formattedDate(dobController.text),
                          address: addressController.text,
                          alternativeMobile: alternativeMobileController.text,
                          guardian: guardianController.text,
                          name: nameController.text)));
                },
              ))
            ],
          );
        });
  }

  showDateOfBirth(Size kSize, TextEditingController controller) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(
                left: kSize.width * .06,
                bottom: kSize.height * .04,
                right: kSize.width * .06),
            title: Center(
                child: Text(
              "Edit",
              style: AppTypography.dmSansMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kSize.height * 0.0284),
            )),
            actions: [
              CustomDatePicker(
                borderRadius: BorderRadius.circular(kSize.height * 0.142),
                dateController: controller,
                fillColor: AppColors.textFieldFillColor,
                borderColor: AppColors.transparent,
                initialDatePickerMode: DatePickerMode.year,
                suffixIcon: const SizedBox(),
                errorMessage: '',
                hintText: '',
                onChanged: (value) {
                  controller.text = dateFormat.format(value);
                },
              ),
              SizedBox(height: kSize.height * .03),
              Center(
                  child: CommonButton(
                label: "Submit",
                onTap: () {
                  Navigator.pop(context);
                  context.read<ProfileBloc>().add(EditProfileEvent(
                      params: PmEditProfileModel(
                          address: addressController.text,
                          alternativeMobile: alternativeMobileController.text,
                          dob: formattedDate(dobController.text),
                          guardian: guardianController.text,
                          name: nameController.text)));
                },
              ))
            ],
          );
        });
  }

  initData(ProfileState state) {
    nameController.text = state.profileData.profileDetails!.name ?? "";
    addressController.text = state.profileData.profileDetails!.address ?? "";
    dobController.text = dateFormat
        .format(DateTime.parse(state.profileData.profileDetails!.dob ?? ""));
    emailController.text = state.profileData.profileDetails!.email ?? "";
    if (state.profileData.profileDetails!.alternativeMobile == null) {
      alternativeMobileController.text = "";
    } else {
      alternativeMobileController.text =
          state.profileData.profileDetails!.alternativeMobile ?? '';
    }
    phoneController.text = state.profileData.profileDetails!.mobile ?? "";
    guardianController.text = state.profileData.profileDetails!.guardian ?? "";
  }

  String formattedDate(String date) {
    DateTime parseDate = DateFormat("dd-MM-yyyy").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  /// Get image
  pickImage(ImageSource source) async {
    Navigator.pop(context);
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      if (mounted) {
        imageFile.value = pickedFile;
        context
            .read<ProfileBloc>()
            .add(UploadProfileImageEvent(filePath: imageFile.value!.path));
      }
    }
  }
}
