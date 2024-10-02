import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/app_images.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.chats,
          style: TextStyle(fontSize: 18.h),
        ),
        centerTitle: true,
        backgroundColor: AppColors.fillColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault.w,
          vertical: Dimensions.paddingSizeDefault.h,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.chatPageScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 12.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.fillColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 38.h,
                                  width: 38.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(AppImages.chatImage,
                                      width: 38.h, height: 38.h),
                                ),
                                Positioned(
                                  top: 6.h,
                                  left: 26.36.w,
                                  child: Container(
                                    width: 6.05.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.green, // Adjust color if needed
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Rida Anam',
                                  fontsize: 16.h,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: 'Hello, are you here?',
                                  fontsize: 12.h,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.shadowColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomMenu(2),
    );
  }
}
