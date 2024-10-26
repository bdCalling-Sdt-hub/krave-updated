import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/utils/app_colors.dart';
import 'package:krave/views/base/cachnetwork_image.dart';
import '../../../../../utils/app_strings.dart';
import '../../../controllers/congratulations_match_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_dimensions.dart';
import '../../base/custom_loading.dart';
import '../../base/custom_text.dart';

class FindRestaurantScreen extends StatelessWidget {
  FindRestaurantScreen({super.key});

  final CongratulationsMatchController congratulationsMatchController =
      Get.find<CongratulationsMatchController>();

  @override
  Widget build(BuildContext context) {
    congratulationsMatchController.getRestaurants();
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Icon(
              //       Icons.refresh,
              //       color: AppColors.primaryColor,
              //       size: 24.h,
              //     ),
              //     SizedBox(width: 8.w),
              //     CustomText(
              //       text: "Refresh",
              //       color: AppColors.primaryColor,
              //       fontsize: 16.h,
              //     ),
              //   ],
              // ),
              SizedBox(height: 16.h),
              // Card Section
              Obx(
                () => congratulationsMatchController.restaurantLoading.value
                    ?  Center(child: CustomLoading(top: 250.h))
                    : congratulationsMatchController.restaurantsData.isEmpty ? Center(child: CustomText(top: 250.h,text: "No restaurant found!")) : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: congratulationsMatchController.restaurantsData.length,
                        itemBuilder: (context, index) {
                          var data = congratulationsMatchController.restaurantsData[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.restaurantDetailsScreen, arguments: data);
                              },
                              child: RestaurantCard(
                                name: "${data.name}",
                                location:
                                    "${data.location?.displayAddress?.first} ${data.location?.displayAddress?[1]}",
                                imagePath: "${data.imageUrl}",
                              ),
                            ),
                          );
                        },
                      ),
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
              child: CustomNetworkImage(
                  imageUrl: "$imagePath", height: 150.h, width: Get.width)),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.w,
                  child: CustomText(
                    text: name,
                    fontsize: 16.h,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16.h,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CustomText(
                        maxline: 2,
                        textAlign: TextAlign.start,
                        text: location,
                        fontsize: 14.h,
                        color: Colors.grey,
                      ),
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
