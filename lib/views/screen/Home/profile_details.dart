import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/TimeFormatHelper.dart';
import 'package:krave/services/api_constants.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/home_feed_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key});

  final HomeFeedController homeFeedController = Get.put(HomeFeedController());

  @override
  Widget build(BuildContext context) {
    homeFeedController.getProfileData("${Get.arguments['id']}");
    final HomeController homeController = Get.put(HomeController());

    RxInt currentImageIndex = 0.obs; // To track the current image for the indicator

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.profileDetails,
          style: TextStyle(fontSize: 18.h),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (homeFeedController.profileLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if the profile data is null
        if (homeFeedController.profileData.value.profile == null) {
          return const Center(child: Text('Profile not available'));
        }

        // Extract profile and gallery details
        var profile = homeFeedController.profileData.value.profile;
        var gallery = homeFeedController.profileData.value.gallery ?? [];

        // Extract data from profile
        String name = profile?.userId?.name ?? "Unknown";
        String location = profile?.address ?? "No location";
        String age = TimeFormatHelper.formatDate(profile?.dateOfBirth ?? DateTime.now()); // Helper function to calculate age
        String bio = profile?.bio ?? "No bio available";
        String favoriteCuisine = profile?.favouriteCousing ?? "No favorite cuisine";

        // List of image URLs for SwipeCards
        List<SwipeItem> swipeItems = gallery
            .map((g) => SwipeItem(
          content: {
            'image': g.imageUrl!,
            'name': name,
            'age': "$age",
            'location': location
          },
          likeAction: () {
            debugPrint("Liked Profile: $name");
          },
          nopeAction: () {
            homeFeedController.like(id: profile?.userId?.id, name: name);
            debugPrint("Disliked Profile: $name");
          },
        ))
            .toList();

        final MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              // Swipe Cards for Profile Images and Info
              Expanded(
                child: Stack(
                  children: [
                    gallery.isNotEmpty
                        ? SwipeCards(
                      matchEngine: matchEngine,
                      itemBuilder: (BuildContext context, int index) {
                        var userData = swipeItems[index].content as Map<String, dynamic>;
                        String imageUrl = userData['image'];
                        String name = userData['name'];
                        String age = userData['age'];
                        String location = userData['location'];

                        return Stack(
                          children: [
                            // Profile Image
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  "${ApiConstants.imageBaseUrl}/$imageUrl",
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Indicator for image gallery (dots)
                            Positioned(
                              left: 20,
                              right: 20,
                              top: 12.h,
                              child: Obx(() {
                                return Row(
                                  children: List.generate(gallery.length, (index) {
                                    return AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                                      width: currentImageIndex.value == index ? 60.w : 60.w,
                                      height: 3.h,
                                      decoration: BoxDecoration(
                                        color: currentImageIndex.value == index
                                            ? AppColors.primaryColor
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    );
                                  }),
                                );
                              }),
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
                                          '$name,',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '$age',
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
                                          location,
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
                          ],
                        );
                      },
                      onStackFinished: () {
                        print("-------------------------Currecnt index ${currentImageIndex.value}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No more profiles')),
                        );
                      },
                      itemChanged: (SwipeItem item, int index) {
                        currentImageIndex.value = index; // Update the indicator
                      },
                    )
                        : const Center(child: Text('No images available')),
                    // Conditionally show the Like and Dislike buttons only if there are images
                    if (gallery.isNotEmpty)
                      Positioned(
                        bottom: 120.h,
                        left: 150,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Dislike (Cross) Button
                            GestureDetector(
                              onTap: () {
                                debugPrint("Dislike Button Tapped");
                                matchEngine.currentItem?.nope();
                              },
                              child: Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(Icons.close, color: Colors.white, size: 30.w),
                                ),
                              ),
                            ),
                            // Like (Heart) Button
                            GestureDetector(
                              onTap: () {
                                debugPrint("Like Button Tapped");
                                homeFeedController.like(id: profile?.userId?.id, name: name);
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
                                  color: Colors.white,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
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
                      text: bio,
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
                      text: favoriteCuisine,
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
        );
      }),
    );
  }
}
