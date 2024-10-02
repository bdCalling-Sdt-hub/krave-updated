import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_dimensions.dart';
import '../../base/custom_text.dart';

class FindRestaurantScreen extends StatelessWidget {
  const FindRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> restaurants = [
      {'name': 'Turkish Balloon Café', 'location': '2 km Away', 'image': 'assets/images/restaurant.png'},
      {'name': 'Turkish Balloon Café', 'location': '2 km Away', 'image': 'assets/images/restaurant.png'},
      {'name': 'Turkish Balloon Café', 'location': '2 km Away', 'image': 'assets/images/restaurant.png'},
      {'name': 'Turkish Balloon Café', 'location': '2 km Away', 'image': 'assets/images/restaurant.png'},
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: AppString.findRestaurant,
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
            children: [
              // Refresh Section
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.refresh,
                    color: AppColors.primaryColor,
                    size: 24.h,
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: "Refresh",
                    color: AppColors.primaryColor,
                    fontsize: 16.h,
                  ),
                ],
              ),
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
                        Get.toNamed(AppRoutes.restaurantDetailsScreen);
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
            ],
          ),
        ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
