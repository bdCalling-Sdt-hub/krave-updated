import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/match_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';


class MatchCard extends StatelessWidget {
  final String name;
  final String age;
  final String location;
  final String imagePath;

  const MatchCard({
    required this.name,
    required this.age,
    required this.location,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MatchController matchController = Get.find(); // Get the MatchController

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 120.w,
              height: 140.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.w),
                  bottomLeft: Radius.circular(8.w),
                ),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      // Update the favorite icon button to add to favorites
                      IconButton(
                        onPressed: () {
                          matchController.addToFavorites({
                            'name': name,
                            'age': age,
                            'location': location,
                            'image': imagePath,
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: AppColors.primaryColor,
                          size: 20.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text('Age: $age', style: TextStyle(fontSize: 14.sp)),
                  const SizedBox(height: 8),
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
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
