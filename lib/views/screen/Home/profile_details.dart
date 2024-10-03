import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../../controllers/home_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final List<String> imgList = [
      AppImages.face,
      AppImages.face,
      AppImages.face,
    ];
    final List<SwipeItem> swipeItems =
    imgList.map((image) => SwipeItem(content: image)).toList();

    // Initialize MatchEngine with swipe items
    final MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);
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
              // Carousel Slider
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.matchScreen);
                },
                child: SizedBox(
                  height: 400.h,  // Added height constraint
                  child: SwipeCards(
                    matchEngine: matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          // Profile Image
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.asset(
                                  imgList[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          // Profile Information (Overlay)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name and Age
                                  Row(
                                    children: [
                                      Text(
                                        'Janet Doe,',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '29',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  // Location
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
                          ),

                          // Buttons (Like, Dislike, Super Like)
                          Positioned(
                            bottom: 100.h,
                            //left: 0,
                            right: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Dislike Button
                                GestureDetector(
                                  onTap: () {
                                    matchEngine.currentItem?.nope();
                                  },
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      AppIcons.cross,
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.h,),
                                // Like Button
                                GestureDetector(
                                  onTap: () {
                                    matchEngine.currentItem?.like();
                                  },
                                  child: Container(
                                    width: 60.w,
                                    height: 60.h,
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      AppIcons.heart,
                                      color: AppColors.primaryColor,
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                  ),
                                ),
                                // Super Like Button

                              ],
                            ),
                          ),
                          // Indicator slider
                          Positioned(
                            top: 10.h,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Obx(() {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(imgList.length, (index) {
                                    return AnimatedContainer(
                                      duration: const Duration(milliseconds: 50),
                                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                                      width: 75.w,
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                        color: homeController.currentIndex.value == index
                                            ? AppColors.primaryColor
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    );
                                  }),
                                );
                              }),
                            ),
                          ),
                        ],
                      );
                    },
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No more profiles')),
                      );
                    },
                    itemChanged: (SwipeItem item, int index) {
                      homeController.updateIndex(index);
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Profile details section

              SizedBox(height: 8.h),

              // Bio details section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.bioDetails),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    color: AppColors.fillColor,
                    child: CustomText(
                      text: AppString.bioDetailsText,
                      fontWeight: FontWeight.w400,
                      maxline: 6,
                      fontsize: 14.sp,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      bottom: 12.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Eating Practice section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.eatingDetailsPractice),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    color: AppColors.fillColor,
                    child: CustomText(
                      text: AppString.eatingDetailsPracticeText,
                      fontWeight: FontWeight.w400,
                      maxline: 6,
                      fontsize: 14.sp,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      bottom: 12.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Favourite Cuisine section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.favouriteCousine),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    color: AppColors.fillColor,
                    child: CustomText(
                      text: AppString.favouriteCousineText,
                      fontWeight: FontWeight.w400,
                      maxline: 6,
                      fontsize: 14.sp,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      bottom: 12.h,
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
