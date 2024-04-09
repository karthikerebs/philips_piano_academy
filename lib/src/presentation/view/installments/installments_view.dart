import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/application/installment/installment_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';
import 'package:music_app/src/presentation/view/installments/widgets/installment_tab_bar.dart';

class InstallmentsView extends StatefulWidget {
  const InstallmentsView({super.key});

  @override
  State<InstallmentsView> createState() => _InstallmentsViewState();
}

class _InstallmentsViewState extends State<InstallmentsView> {
  TextEditingController reasonController = TextEditingController();
  @override
  void initState() {
    context.read<InstallmentBloc>().add(const GetInstallmentListEvent());
    context.read<InstallmentBloc>().add(const GetPendingInstallmentListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
              bottom: TabBar(
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        context
                            .read<InstallmentBloc>()
                            .add(const GetInstallmentListEvent());
                        break;
                      case 1:
                        context
                            .read<InstallmentBloc>()
                            .add(const GetPendingInstallmentListEvent());
                        break;
                      default:
                        context
                            .read<InstallmentBloc>()
                            .add(const GetInstallmentListEvent());
                    }
                  },
                  padding: EdgeInsets.symmetric(horizontal: kSize.width * .06),
                  overlayColor: const MaterialStatePropertyAll<Color>(
                      AppColors.transparent),
                  unselectedLabelColor: AppColors.greyColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Installments"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Pending"),
                        ),
                      ),
                    )
                  ]),
            ),
            body: const InstallMentTabbar()));
  }
}
