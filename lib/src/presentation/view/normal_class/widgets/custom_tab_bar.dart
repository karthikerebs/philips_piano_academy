import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/cancelled_class.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/completed_class.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/upcoming_class.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key, required this.reasonController});
  final TextEditingController reasonController;
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      RefreshIndicator(
          color: AppColors.blackColor,
          onRefresh: () async {
            context.read<NormalClassBloc>().add(const UpcomingClassEvent());
            context.read<NormalClassBloc>().add(const CompletedClassEvent());
            context.read<NormalClassBloc>().add(const GetCanceledClassEvent());
          },
          child:
              UpComingClassDetails(reasonController: widget.reasonController)),
      const CancelledClassDetails(),
      const CompletedClassDetails()
    ]);
  }
}
