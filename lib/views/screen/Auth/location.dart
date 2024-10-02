import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController favouriteCuisineCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 23.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppString.location,
                    fontWeight: FontWeight.w500,
                    fontsize: 18.sp,
                    color: AppColors.textColor,
                    textAlign: TextAlign.center,
                    bottom: 12.h,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: AppString.locationsText,
                    fontWeight: FontWeight.w400,
                    maxline: 3,
                    fontsize: 16.sp,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    bottom: 12.h,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Image.asset(
                'assets/images/Map.png',
                height: 423.h,
                width: 353.w,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.redColor,
                        size: 24.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Current Location",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.subTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.only(left: 32.w),
                    child: Text(
                      "Kancilan, Kembang, Jepara",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
           // Search Section
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Container(
                  width: 370.w,
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),
                    ),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 0.5,
                    ),
                  ),
                  child: TextField(
                    controller: favouriteCuisineCTRl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                      suffixIcon: SvgPicture.asset(
                        AppIcons.search,
                        width: 10.w,
                        height: 10.h,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 100.h),
              // Complete Button
              CustomButton(
                text: AppString.addLocation,
                onTap: () {
                  Get.toNamed(AppRoutes.detailsScreen);
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
