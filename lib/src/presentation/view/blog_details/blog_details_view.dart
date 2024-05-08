import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/domain/models/response_models/blog_model/blog.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/view/normal_class/widgets/customappbar.dart';

class BlogDetailView extends StatefulWidget {
  const BlogDetailView({super.key, required this.blogData});
  final Blog blogData;
  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: CustomAppBar(title: ""),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * .1),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kSize.height * 0.028,
              ),
              Container(
                width: kSize.width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(kSize.height * 0.0236)),
                child: Image.network(
                  "https://philipspianoacademy.erebs.in${widget.blogData.image}",
                  height: kSize.height * 0.15640,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.028,
              ),
              Text(
                  /* 'Music is new type of relief' */ widget.blogData.title ??
                      '',
                  style: AppTypography.dmSansMedium.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: kSize.height * 0.0284)),
              Text(
                  /* '12/12/2021' */ DateFormat("dd MMM, yyyy")
                      .format(DateTime.parse("${widget.blogData.createdAt}")),
                  style: AppTypography.dmSansRegular.copyWith(
                      color: AppColors.textGreyColor,
                      fontSize: kSize.height * 0.0189)),
              SizedBox(
                height: kSize.height * 0.013,
              ),
              /* 
                Text('Nithin (Author)',
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.textGreyColor,
                        fontSize: kSize.height * 0.0189)),
                SizedBox(
                  height: kSize.height * 0.028,
                ), */
              Expanded(
                child: Text(
                    widget.blogData.details!
                        .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ""),
                    style: AppTypography.dmSansRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kSize.height * 0.0213)),
              ),
              SizedBox(
                height: kSize.height * 0.023,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
