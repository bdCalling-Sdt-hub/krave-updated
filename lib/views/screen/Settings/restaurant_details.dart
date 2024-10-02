import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/app_icons.dart';
import '../../base/custom_text.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> restaurants = [
      {'name': 'Turkish Balloon Café', 'location': '2 km Away', 'image': 'assets/images/restaurant.png'},
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: AppString.restaurant,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              // Card Section
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.matchesProfileDetailsScreen);
                      },
                      child: RestaurantCard(
                        name: restaurants[index]['name']!,
                        location: restaurants[index]['location']!,
                        imagePath: restaurants[index]['image']!,
                      ),
                    ),
                  );
                },
              ),
              // Add the text below the card section
              SizedBox(height: 8.h),
              CustomText(
                text: 'Turkish Balloon Café',
                fontsize: 20.h,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
              _row(AppString.shopAddress, 'Paris, France'),
              _row(AppString.shopCategory, 'Cafe'),
              _row(AppString.openingHour, '10:00 am- 10:00 pm'),
              _row(AppString.weekend, 'Monday'),
              SizedBox(height: 20.h),
              CustomText(
                text: 'About',
                fontsize: 20.h,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: AppString.detailsText,
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
      ),
    );
  }

  Widget _row(String trailingText, String leadingText) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: trailingText,
            color: AppColors.textColor,
            fontsize: 16.h,
          ),
          SizedBox(
            width: 204.w,
            child: CustomText(
              maxline: 4,
              textAlign: TextAlign.end,
              text: leadingText,
              color: AppColors.shadowColor,
              fontWeight: FontWeight.w500,
              fontsize: 16.h,
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String name;
  final String location;
  final String imagePath;

  const RestaurantCard({
    required this.name,
    required this.location,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        border: Border.all(color: AppColors.fillColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 150.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontsize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16.h,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: location,
                          fontsize: 14.h,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      AppIcons.heart1,
                      color: AppColors.fillColor,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
