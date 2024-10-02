import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krave/utils/app_colors.dart';

import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordCTRl = TextEditingController();
  final TextEditingController conformPasswordCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //===============================> App logo <===============================
              Center(
                  child: Image.asset(AppImages.appLogo,
                      width: 164.w, height: 106.h)),
              SizedBox(height: 23.h),

              //===============================> Text Label field <===============================
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppString.restPass,
                      fontWeight: FontWeight.w500,
                      fontsize: 18.sp,
                      color: AppColors.textColor,
                      textAlign: TextAlign.center,
                      bottom: 12.h,),
                    SizedBox(height: 4.h,),
                    CustomText(
                      text: AppString.restPassText,
                      fontWeight: FontWeight.w400,
                      maxline: 1,
                      fontsize: 16.sp,
                      textAlign: TextAlign.start,
                      bottom: 12.h,
                    ),

                  ],
                ),
              ),

              //====================================> Password Text Field <=========================
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.passwords),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: passwordCTRl,
                    hintText: AppString.password,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 8 || value.length > 10) {
                        return "Password must have 8-10 characters.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h,),
                ],
              ),
              //====================================> Conform Password Text Field <=========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.conformPass),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: conformPasswordCTRl,
                    hintText: AppString.reenterPass,
                    isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please re-enter your password";
                        } else if (value.length < 8 || value.length > 10) {
                          return "Password must have 8-10 characters.";
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 15.h,),
                ],
              ),
              SizedBox(height: 180.h,),
              //===============================> Reset Button <===============================
              CustomButton(
                  text: AppString.restPass,
                  onTap: () {
                      Get.toNamed(AppRoutes.signInScreen);

                  }),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),

    );
  }
}
