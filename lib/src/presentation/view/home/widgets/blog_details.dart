import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/common_button.dart';

class BlogDetails extends StatelessWidget {
  const BlogDetails({super.key, required this.state});
  final HomeState state;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: state.blogList.length,
      primary: false,
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          height: kSize.height * 0.26,
          margin: EdgeInsets.only(bottom: kSize.height * 0.0094),
          width: kSize.width,
          padding: EdgeInsets.symmetric(
              vertical: kSize.height * 0.0236, horizontal: kSize.width * 0.034),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSize.height * 0.0236),
              border: Border.all(color: AppColors.primaryColor)),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Container(
                      width: kSize.height * 0.15640,
                      height: kSize.height * 0.15640,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kSize.height * 0.0236)),
                      child: Image.network(
                        "https://philipspianoacademy.erebs.in${state.blogList[index].image}",
                        height: kSize.height * 0.15640,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    width: kSize.width * 0.022,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        /* '11/11/2023' */ DateFormat("dd/MM/yyyy").format(
                            DateTime.parse(
                                "${state.blogList[index].createdAt}")),
                        style: AppTypography.dmSansRegular.copyWith(
                            color: AppColors.textGreyColor,
                            fontSize: kSize.height * 0.0118),
                      ),
                      SizedBox(height: kSize.height * .01),
                      SizedBox(
                        width: kSize.width * .36,
                        child: Text(
                          state.blogList[index].title ?? "",
                          maxLines: 2,
                          style: AppTypography.dmSansMedium.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.0195),
                        ),
                      ),
                      SizedBox(height: kSize.height * .01),
                      SizedBox(
                        width: kSize.width * .36,
                        child: Text(
                          state.blogList[index].details!
                              .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ""),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.dmSansMedium.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kSize.height * 0.0118),
                        ),
                      ),
                      SizedBox(height: kSize.height * .005),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                bottom: -5,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CommonButton(
                      label: 'View',
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouterConstants.blogDetailsRoute,
                            arguments: state.blogList[index]);
                      },
                      padding: EdgeInsets.symmetric(
                          vertical: kSize.height * .01,
                          horizontal: kSize.width * .08),
                      fontSize: kSize.height * 0.0118),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
