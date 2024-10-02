import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';

import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      AppImages.face,
      AppImages.face,
      AppImages.face,
      AppImages.face,
      // Add more images to this list as needed
    ];

    // Create a list of SwipeItems with your images
    final List<SwipeItem> swipeItems = imgList
        .map((image) => SwipeItem(content: image))
        .toList();

    // Initialize MatchEngine with swipe items
    final MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: Column(
            children: [
              // Header with logo and notifications icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(AppImages.appLogo,
                          width: 74.w, height: 48.h),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/notifications');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF4F9EC),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: SvgPicture.asset(
                          AppIcons.notificationBell,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              // Label for the home screen
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppString.home,
                    fontWeight: FontWeight.w500,
                    fontsize: 24.sp,
                    color: AppColors.primaryColor,
                    textAlign: TextAlign.center,
                    bottom: 12.h,
                  ),
                ],
              ),
              // Tinder-like swipe cards
              Expanded(
                child: SwipeCards(
                  matchEngine: matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        // Profile Image
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.asset(
                              imgList[index],
                              fit: BoxFit.cover,
                              width: double.infinity, // Make image stretch to card width
                              height: double.infinity, // Fill card height
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
                              color: AppColors.cardColor, // Background with opacity
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
                          bottom: 90.h,
                          left: 0,
                          right: 0,
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
                                    color: AppColors.backgroundColor.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    AppIcons.cross,
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              ),
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
                                    color: AppColors.backgroundColor.withOpacity(0.5),
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
                              GestureDetector(
                                onTap: () {
                                  matchEngine.currentItem?.superLike();
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
                                    AppIcons.superLike,
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  onStackFinished: () {
                    // Handle the scenario when all cards are swiped
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No more profiles')),
                    );
                  },
                  itemChanged: (SwipeItem item, int index) {
                    // Handle card swipe events if needed
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(0), // Your Bottom Navigation
    );
  }
}
