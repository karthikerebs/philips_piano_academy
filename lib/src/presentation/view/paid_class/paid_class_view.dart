import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/paid_class/paid_class_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';
import 'package:music_app/src/presentation/core/widgets/message_view.dart';
import 'package:music_app/src/presentation/view/paid_class/widgets/paid_class_tile.dart';

class PaidClassView extends StatefulWidget {
  const PaidClassView({super.key});

  @override
  State<PaidClassView> createState() => _PaidClassViewState();
}

class _PaidClassViewState extends State<PaidClassView> {
  @override
  void initState() {
    context.read<PaidClassBloc>().add(const GetPaidClassListEvent());
    super.initState();
  }

  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: kSize.width * 0.04),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Paid Classes",
          style: AppTypography.dmSansBold.copyWith(
              color: AppColors.primaryColor, fontSize: kSize.height * 0.028),
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.blackColor,
        onRefresh: () async {
          context.read<PaidClassBloc>().add(const GetPaidClassListEvent());
        },
        child: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Column(
            children: [
              SizedBox(
                height: kSize.height * .03,
              ),
              Center(
                child: CommonButton(
                  label: 'Book Paid Class',
                  fontSize: kSize.height * .02,
                  padding: EdgeInsets.symmetric(
                      horizontal: kSize.width * .07,
                      vertical: kSize.height * .02),
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouterConstants.paidClasschangeRoute);
                  },
                ),
              ),
              SizedBox(height: kSize.height * .025),
              BlocConsumer<PaidClassBloc, PaidClassState>(
                listener: (context, state) {
                  if ((state.status is StatusAuthFailure)) {
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
                    return const Column(
                      children: [
                        SizedBox(height: 150),
                        CircularProgressIndicator(color: AppColors.blackColor),
                      ],
                    );
                  } else if (state.status is StatusSuccess) {
                    if (state.paidClassList.isNotEmpty) {
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1,
                              color: AppColors.greyColor,
                              thickness: 1,
                            );
                          },
                          itemCount: state.paidClassList.length,
                          primary: true,
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PaidClassTile(
                              index: index,
                              paidClassList: state.paidClassList,
                              reasonController: reasonController,
                            );
                          },
                        ),
                      );
                    } else {
                      return const Column(
                        children: [
                          SizedBox(height: 150),
                          Text('No paid classes found!'),
                        ],
                      );
                    }
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
            ],
          ),
        ),
      ),
    );
  }
}
