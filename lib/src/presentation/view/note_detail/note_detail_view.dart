import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
// import 'package:music_app/src/presentation/core/widgets/textfield.dart';

class NoteDetailView extends StatefulWidget {
  const NoteDetailView({super.key, required this.title, required this.id});
  final String title;
  final String id;
  @override
  State<NoteDetailView> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    context
        .read<NormalClassBloc>()
        .add(GetCompletedClassNoteEvent(classId: widget.id));
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
        title: Text(widget.title,
            style: AppTypography.dmSansRegular.copyWith(
                color: AppColors.primaryColor,
                fontSize: kSize.height * 0.0284)),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.05),
              child: BlocConsumer<NormalClassBloc, NormalClassState>(
                listener: (context, state) {
                  if (state.status is StatusAuthFailure) {
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
                  if (state.status is StatusLoading) {
                    return const Center(
                      child: Text('loading...'),
                    );
                  } else if (state.status is StatusSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kSize.height * 0.018),
                        Text('Teacher Remarks',
                            style: AppTypography.dmSansMedium.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.0284)),
                        SizedBox(height: kSize.height * 0.018),
                        Text(
                            state.completedClassNote.note!
                                .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
                            style: AppTypography.dmSansRegular.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.0189)),
                        SizedBox(height: kSize.height * 0.0355),
                        /* Text('Assignment',
                            style: AppTypography.dmSansMedium.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.0284)),
                        SizedBox(height: kSize.height * 0.018),
                        Container(
                          width: kSize.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            color: AppColors.lightgreyColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Assignment 01',
                              style: AppTypography.dmSansMedium.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: kSize.height * 0.0189)),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: kSize.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            color: AppColors.lightgreyColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Assignment 02',
                              style: AppTypography.dmSansMedium.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: kSize.height * 0.0189)),
                        ),
                        SizedBox(height: kSize.height * 0.0355),
                        Text('Your Remark/Feedback',
                            style: AppTypography.dmSansMedium.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kSize.height * 0.0284)),
                        SizedBox(height: kSize.height * 0.018),
                        CustomTextField(
                            maxLines: 6,
                            fillColor: AppColors.lightgreyColor1,
                            hintstyle: AppTypography.dmSansRegular.copyWith(
                                fontSize: 12, color: AppColors.greyColor),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.transparent),
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Type your Remarks/Feedback here......',
                            controller: controller) */
                      ],
                    );
                  } else if (state.status is StatusFailure) {
                    final status = state.status as StatusFailure;
                    return Center(
                      child: Text(status.errorMessage),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          )),
    );
  }
}
