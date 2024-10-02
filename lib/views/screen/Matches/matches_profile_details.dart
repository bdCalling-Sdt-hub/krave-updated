import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';


class MatchesProfileDetailsScreen extends StatelessWidget {
  const MatchesProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      AppImages.face,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.profileDetails,
          style: TextStyle(fontSize: 18.h),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              //===============================> Carousel Slider <===============================
              CarouselSlider(
                options: CarouselOptions(
                  height: 400.h,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {},
                ),
                items: imgList.map((item) => Stack(
                  children: [
                    Center(
                      child: Image.asset(item,
                          fit: BoxFit.cover,
                          width: 280.w),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                AppIcons.cross,
                                height: 20.h,
                                width: 20.w,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              width: 60.w,
                              height: 60.h,
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                AppIcons.heart,
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )).toList(),
              ),
              SizedBox(height: 8.h,),
              //===============================> Text Info <===============================
              Container(
                padding: EdgeInsets.all(8.r),
                color: AppColors.fillColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Janet Doe,',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '29',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.location,
                          height: 16.h,
                          width: 16.w,
                          color: AppColors.textColor,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'USA',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h,),
              //===============================> details Info <===============================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.bioDetails),
                  SizedBox(height: 8.h,),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    color: AppColors.fillColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppString.bioDetailsText,
                          fontWeight: FontWeight.w400,
                          maxline: 6,
                          fontsize: 14.sp,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          bottom: 12.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h,),
              //===============================> Eating Practice <===============================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.eatingDetailsPractice),
                  SizedBox(height: 8.h,),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    color: AppColors.fillColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppString.eatingDetailsPracticeText,
                          fontWeight: FontWeight.w400,
                          maxline: 6,
                          fontsize: 14.sp,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          bottom: 12.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h,),
              //===============================> Favourite Cousine <===============================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.favouriteCousine),
                  SizedBox(height: 8.h,),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    color: AppColors.fillColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppString.favouriteCousineText,
                          fontWeight: FontWeight.w400,
                          maxline: 6,
                          fontsize: 14.sp,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          bottom: 12.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),

    );
  }
}
