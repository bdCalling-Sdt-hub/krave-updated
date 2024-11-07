import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/route.dart';
import 'package:krave/services/api_constants.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../controllers/home_controller.dart';
import '../../../controllers/home_feed_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeFeedController homeFeedController = Get.put(HomeFeedController());
  RxInt currentImageIndex = 0.obs;
  RxInt userGalleryLength = 0.obs;

  @override
  Widget build(BuildContext context) {
    homeFeedController.getActivities();
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(AppImages.appLogo, width: 74.w, height: 48.h),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.notificationsScreen);
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
          ),
          // SizedBox(height: 30.h),
          Obx(() {
            if (homeFeedController.feedLoading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }

            if (homeFeedController.feeds.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 250.h),
                child: const Center(child: Text('No profiles available')),
              );
            }

            List<SwipeItem> swipeItems = [];
            List<String> imgList = [];
            String? currentName;
            String? id;
            String? currentLocation;
            int? currentAge;

            for (var user in homeFeedController.feeds) {
              imgList = user.gallery!
                  .map((gallery) => "${ApiConstants.imageBaseUrl}/${gallery.imageUrl!}")
                  .toList();

              for (var image in imgList) {
                swipeItems.add(SwipeItem(
                  content: {
                    'image': image,
                    'name': user.name,
                    'currentLocation': user.address,
                    'age': user.age,
                    'id': user.id,
                    'galleryLength': imgList.length,
                  },
                  likeAction: () {
                    debugPrint("=======================Right Swipe (Like)===================");
                  },
                  nopeAction: () {
                    homeFeedController.like(id: user.id, name: user.name ?? '');
                    debugPrint("=======================Left Swipe (Nope)===================");
                  },
                ));
              }
            }

            final MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);

            return Expanded(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Column(
                    children: [
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.profileDetailsScreen, arguments: {
                              "id": id,
                            });
                          },
                          child: SwipeCards(
                            matchEngine: matchEngine,
                            itemBuilder: (BuildContext context, int index) {
                              var userData = swipeItems[index].content as Map<String, dynamic>;
                              currentName = userData['name'];
                              currentLocation = userData['currentLocation'];
                              currentAge = userData['age'];
                              id = userData['id'];
                              String imageUrl = userData['image'];
                              userGalleryLength.value = userData['galleryLength'];

                              return Stack(
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
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
                                          Row(
                                            children: [
                                              Text(
                                                '$currentName,',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 24.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '$currentAge',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
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
                                                '$currentLocation',
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
                                  Positioned(
                                    bottom: 110.h,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            debugPrint("=======================Nope===================");
                                            matchEngine.currentItem?.nope();
                                          },
                                          child: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.backgroundColor.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(child: Icon(Icons.close, color: Colors.red)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            debugPrint("=======================Love===================");
                                            homeFeedController.like(id: id,name: currentName);
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
                                        GestureDetector(
                                          onTap: () {
                                            debugPrint("=======================Super Like===================");
                                            matchEngine.currentItem?.superLike();
                                            Get.toNamed(AppRoutes.profileDetailsScreen, arguments: {
                                              "id": id,
                                            });
                                          },
                                          child: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.backgroundColor.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.info_rounded, color: Colors.blueAccent),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10.h,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Obx(() {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(
                                            userGalleryLength.value,
                                                (dotIndex) {
                                              return AnimatedContainer(
                                                duration: const Duration(milliseconds: 50),
                                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                                width: currentImageIndex.value == dotIndex
                                                    ? 30.w
                                                    : 12.w,
                                                height: 5.h,
                                                decoration: BoxDecoration(
                                                  color: currentImageIndex.value == dotIndex
                                                      ? AppColors.primaryColor
                                                      : Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(12.r),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              );
                            },
                            onStackFinished: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('No more profiles')),
                              );
                            },
                            itemChanged: (SwipeItem item, int index) {
                              homeController.updateIndex(index);
                              currentImageIndex.value = index % userGalleryLength.value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: const BottomMenu(0),
    );
  }

}
