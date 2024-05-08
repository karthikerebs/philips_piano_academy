import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/custom_tab_bar.dart';

class NormalClassView extends StatefulWidget {
  const NormalClassView({super.key});

  @override
  State<NormalClassView> createState() => _NormalClassViewState();
}

class _NormalClassViewState extends State<NormalClassView> {
  TextEditingController reasonController = TextEditingController();
  @override
  void initState() {
    context.read<NormalClassBloc>().add(const UpcomingClassEvent());
    context.read<NormalClassBloc>().add(const CompletedClassEvent());
    context.read<NormalClassBloc>().add(const GetCanceledClassEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: AppColors.secondaryColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon:
                        Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Regular Class",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              bottom: TabBar(
                  onTap: (value) {
                    switch (value) {
                      case 0:
                        context
                            .read<NormalClassBloc>()
                            .add(const UpcomingClassEvent());
                        break;
                      case 1:
                        context
                            .read<NormalClassBloc>()
                            .add(const GetCanceledClassEvent());
                        break;
                      case 2:
                        context
                            .read<NormalClassBloc>()
                            .add(const CompletedClassEvent());
                        break;
                      default:
                        context
                            .read<NormalClassBloc>()
                            .add(const UpcomingClassEvent());
                    }
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: kSize.width * .04),
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
                          child: Text("Upcoming"),
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
                          child: Text("Cancelled"),
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
                          child: Text("Completed"),
                        ),
                      ),
                    ),
                  ]),
            ),
            body: CustomTabBar(
              reasonController: reasonController,
            )));
  }
}
