import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../base/custom_text.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});


  void _showDeleteDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Delete Account',
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
              'Are you sure you want to delete your Account?',
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
                    onPressed: () {

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
                      'Yes,Delete',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: AppString.setting,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault.w,
          vertical: Dimensions.paddingSizeDefault.h,
        ),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.changePasswordScreen);
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
                            AppIcons.lock,
                            color: AppColors.textColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.changePassword,
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
            // SizedBox(height: 16.h),
            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed(AppRoutes.matchScreen);
            //   },
            //   child: Container(
            //     width: 367.w,
            //     height: 60.h,
            //     padding: EdgeInsets.only(top: 12.h),
            //     margin: EdgeInsets.only(left: 2.w),
            //     decoration: BoxDecoration(
            //       color: AppColors.cardColor, // #FFF3E6 color
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(5.r),
            //         bottomLeft: Radius.circular(8.r),
            //         topRight: Radius.circular(0.r),
            //         bottomRight: Radius.circular(0.r),
            //       ),
            //
            //     ),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 12.w),
            //             child: Row(
            //               children: [
            //                 SvgPicture.asset(
            //                   AppIcons.heart,
            //                   color: AppColors.textColor,
            //                 ),
            //                 SizedBox(width: 10.w),
            //                 Text(
            //                   AppString.findMatches,
            //                   style: TextStyle(
            //                     fontSize: 16.sp,
            //                     color: AppColors.textColor,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 12.w),
            //             child: SvgPicture.asset(
            //               AppIcons.chevronRight,
            //               color: AppColors.primaryColor,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.setDistanceScreen);

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
                            AppIcons.locations,
                            color: AppColors.textColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.findResturants,
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
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.privacyPolicyScreen);
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
                            AppIcons.privacy,
                            color: AppColors.textColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.privacyPolicy,
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
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.termsServicesScreen);
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
                            AppIcons.terms,
                            color: AppColors.textColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.terms,
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
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.aboutUsScreen);
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
                            AppIcons.about,
                            color: AppColors.textColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.aboutUs,
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
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                _showDeleteDialog(context);
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
                            AppIcons.delete,
                            color: AppColors.textColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppString.deleteAccount,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
