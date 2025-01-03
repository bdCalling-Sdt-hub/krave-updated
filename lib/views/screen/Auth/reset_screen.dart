import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../controllers/auth_controller.dart';
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
  final AuthController authController = Get.find<AuthController>();

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //===============================> App logo <===============================
                Center(
                    child: Image.asset(AppImages.appLogo,
                        width: 164.w, height: 106.h)),
                SizedBox(height: 23.h),

                //===============================> Text Label field <===============================
                Column(
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
                        } else if (value.length < 6) {
                          return "Password must have 6 characters.";
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
                          } else if (value != passwordCTRl.text) {
                            return "Password do not match!";
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),
                SizedBox(height: 180.h,),
                //===============================> Reset Button <===============================
                Obx(()=>
                   CustomButton(
                     loading: authController.setPasswordLoading.value,
                      text: AppString.restPass,
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          authController.setPassword(passwordCTRl.text, passwordCTRl.text, "resetPassword");
                        }
                      }),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
