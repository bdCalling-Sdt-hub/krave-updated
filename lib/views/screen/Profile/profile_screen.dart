

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krave/controllers/profile_controller.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/utils/app_constants.dart';
import '../../../helpers/route.dart';
import '../../../services/api_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/cachnetwork_image.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    profileController.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(AppImages.appLogo2,
                          width: 74.w, height: 48.h)
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.settingsScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.fillColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: SvgPicture.asset(
                        AppIcons.notificationIcon,
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color:AppColors.cardColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  // Profile Image Section with Badge
                  Stack(
                    children: [
                      Container(
                        width: 160.w,
                        height: 160.h,
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child:Obx(
                                () => profileController.profileData.value.gallery?.first.imageUrl ==
                                null
                                ?   Image.asset(
                                  AppImages.profileImages,
                                  fit: BoxFit.cover,
                                  width: 128.w,
                                  height: 128.h,
                                )
                                : CustomNetworkImage(
                                boxShape: BoxShape.circle,
                                imageUrl:
                                "${ApiConstants.imageBaseUrl}/${profileController.profileData.value.gallery?.first.imageUrl}",
                                height: 128.h,
                                width: 128.w),
                          ),

                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 20,
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImages.profileImages,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Edit Section with Icon Prefix
                  Container(
                    width: 160.w,
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.r),
                        bottomLeft: Radius.circular(4.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.updatePictureScreen);
                            },
                            child: Icon(
                              Icons.edit,
                              size: 20.w,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            child: Text(
                              'Update Pictures',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.backgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Centered Text Section
                  ///==============name==============>
                  Obx(()=>
                     profileController.profileData.value.profile?.userId?.name == null ? const Text("N/A"): Text(
                      '${profileController.profileData.value.profile?.userId?.name}',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            /// ===============account information=========>
            Obx((){
              print(profileController.profileData.value.profile?.email);
             var email = profileController.profileData.value.profile?.email ?? "";
             return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.accountInformationScreen, arguments: {
                    "name" : "${profileController.profileData.value.profile?.userId?.name}",
                    "phone" : "${profileController.profileData.value.profile?.userId?.phone}",
                    "email" : email
                  });
                },
                child: Container(
                  width: 367.w,
                  height: 60.h,
                  padding: EdgeInsets.only(top: 12.h),
                  margin: EdgeInsets.only(left: 2.w),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor, // #FFF3E6 color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.r),
                      bottomLeft: Radius.circular(8.r),
                      topRight: Radius.circular(0.r),
                      bottomRight: Radius.circular(0.r),
                    ),

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.profile,
                              color: AppColors.textColor,
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              AppString.accountProfile,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SvgPicture.asset(
                          AppIcons.chevronRight,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }),
            SizedBox(height: 20.h),
            ///=================Profile Details==========><
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.personalInformationScreen, arguments: {
                  "date" : "${profileController.profileData.value.profile?.dateOfBirth}",
                  "location" : "${profileController.profileData.value.profile?.address}",
                  "bio" : "${profileController.profileData.value.profile?.bio}",
                  "eatingPractice" : "${profileController.profileData.value.profile?.eatingPractice}",
                  "datingIntention" : "${profileController.profileData.value.profile?.datingIntention}",
                  "favorite" : "${profileController.profileData.value.profile?.favouriteCousing}",
                });
              },
              child: Container(
                width: 367.w,
                height: 60.h,
                padding: EdgeInsets.only(top: 12.h),
                margin: EdgeInsets.only(left: 2.w),
                decoration: BoxDecoration(
                  color: AppColors.cardColor, // #FFF3E6 color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    bottomLeft: Radius.circular(8.r),
                    topRight: Radius.circular(0.r),
                    bottomRight: Radius.circular(0.r),
                  ),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.informationCircle,
                            color: AppColors.textColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.profileDetailsText,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        AppIcons.chevronRight,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ///================LogOut==================>
            GestureDetector(
              onTap: () {
                _showLogoutDialog(context);
              },
              child: Container(
                width: 367.w,
                height: 60.h,
                padding: EdgeInsets.only(top: 12.h),
                margin: EdgeInsets.only(left: 2.w),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    bottomLeft: Radius.circular(8.r),
                    topRight: Radius.circular(0.r),
                    bottomRight: Radius.circular(0.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.logout,
                            color: AppColors.redColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.logOut,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Other widgets or information
          ],
        ),
      ),
      bottomNavigationBar: const BottomMenu(3),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Log Out',
      titleStyle: TextStyle(
          color: AppColors.redColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold),
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: AppColors.cardColor,
      radius: 12.r,
      barrierDismissible: false,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 180.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Divider(
              color: AppColors.borderColor.withOpacity(0.5),
              thickness: 1.h,
              indent: 20.w,
              endIndent: 20.w,
            ),
            SizedBox(height: 10.h),
            Text(
              'Are you sure you want to log out of your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      backgroundColor: AppColors.borderColor,
                      fixedSize: Size(130.5.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),


                        side: BorderSide.none,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () async{
                      await PrefsHelper.remove(AppConstants.bearerToken);
                      await PrefsHelper.remove(AppConstants.userId);
                      await PrefsHelper.remove(AppConstants.isLogged);
                      await PrefsHelper.remove(AppConstants.name);
                      await PrefsHelper.remove(AppConstants.email);
                      Get.offAllNamed(AppRoutes.onboardScreen);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.backgroundColor,
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: Size(130.5.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide.none,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                    ),
                    child: Text(
                      'Yes,Log Out',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
