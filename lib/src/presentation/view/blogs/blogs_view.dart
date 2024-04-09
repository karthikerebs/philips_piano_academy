import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/domain/models/response_models/blog_model/blog.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/back_button.dart';

class BlogsView extends StatefulWidget {
  const BlogsView({super.key});

  @override
  State<BlogsView> createState() => _BlogsViewState();
}

class _BlogsViewState extends State<BlogsView> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SizedBox(
          height: kSize.height,
          width: kSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kSize.height * .05,
                ),
                CustomBackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: kSize.height * 0.028,
                ),
                Center(
                  child: Text(
                    'Latest Blogs',
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.0284),
                  ),
                ),
                SizedBox(
                  height: kSize.height * 0.0189,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.status is StatusLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.blackColor),
                      );
                    } else if (state.status is StatusSuccess) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.blogList.length,
                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                          itemBuilder: (context, index) {
                            return blogTile(kSize, state.blogList[index]);
                          },
                        ),
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
              ],
            ),
          )),
    );
  }

  Widget blogTile(Size kSize, Blog blogData) {
    return Container(
      margin: EdgeInsets.only(bottom: kSize.height * 0.0094),
      width: kSize.width,
      padding: EdgeInsets.symmetric(
          vertical: kSize.height * 0.0236, horizontal: kSize.width * 0.044),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSize.height * 0.0236),
          border: Border.all(color: AppColors.primaryColor)),
      child: Row(children: [
        Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kSize.height * 0.0236)),
            child: Container(
                width: kSize.height * 0.15640,
                height: kSize.height * 0.15640,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSize.height * 0.0236)),
                child: Image.network(
                  "https://philipspianoacademy.erebs.in${blogData.image}",
                  height: kSize.height * 0.15640,
                  fit: BoxFit.cover,
                ))),
        SizedBox(
          width: kSize.width * 0.022,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              /*  '11/11/2023' */ DateFormat("dd/MM/yyyy")
                  .format(DateTime.parse("${blogData.createdAt}")),
              style: AppTypography.dmSansRegular.copyWith(
                  color: AppColors.textGreyColor,
                  fontSize: kSize.height * 0.0118),
            ),
            SizedBox(
              width: kSize.width * .4,
              child: Text(
                /*      'Music is new type of relief' */ blogData.title ?? "",
                maxLines: 2,
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.0195),
              ),
            ),
            SizedBox(
              width: kSize.width * .4,
              child: Text(
                blogData.details!.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ""),
                maxLines: 4,
                style: AppTypography.dmSansMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: kSize.height * 0.0118),
              ),
            ),
            InkWell(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.blogDetailsRoute,
                    arguments: blogData);
              },
              child: Align(
                widthFactor: 1.8,
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: kSize.height * .01,
                      horizontal: kSize.width * .06),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.circular(kSize.height * 0.118)),
                  child: Text(
                    "View Blog",
                    style: AppTypography.dmSansMedium.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: kSize.height * 0.0118),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
