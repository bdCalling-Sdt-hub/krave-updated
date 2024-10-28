import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../controllers/auth_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  final AuthController authController = Get.find<AuthController>();

  // void _showUpdateDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor:AppColors.fillColor,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(40),
  //             topRight: Radius.circular(40),
  //             bottomLeft: Radius.circular(40),
  //             bottomRight: Radius.circular(40),
  //           ),
  //         ),
  //         contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
  //         content: SizedBox(
  //           width: 410.w,
  //           height: 320.h,
  //           child: SingleChildScrollView(
  //             scrollDirection: Axis.vertical,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.topRight,
  //                   child: IconButton(
  //                     icon: const Icon(Icons.close, color: Colors.red),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: 20.h),
  //                 Text(
  //                   "Enter your current password to delete your account.",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(fontSize: 16.sp),
  //                 ),
  //                 //====================================> Current Password Text Field <=========================
  //                 SizedBox(height: 16.h),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(AppString.currentPass),
  //                     SizedBox(height: 8.h),
  //                     CustomTextField(
  //                       controller: currentPasswordCTRl,
  //                       hintText: AppString.currentPassText,
  //                       isPassword: true,
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return "Please enter your password";
  //                         } else if (value.length < 8 || value.length > 10) {
  //                           return "Password must have 8-10 characters.";
  //                         }
  //                         return null;
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 20.h),
  //                 CustomButton(
  //                   text: AppString.updatePass,
  //                   onTap: () {
  //                     if(_formKey.currentState!.validate()){
  //                       authController.changePassword(
  //                           currentPasswordCTRl.text.trim(),
  //                           newPasswordCTRl.text.trim()
  //                       );
  //                     }
  //                     // Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.changePass,
          style: TextStyle(fontSize: 18.h),
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
                //====================================> Current Password Text Field <=========================
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.currentPass),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller:  authController. currentPasswordCTRl,
                      hintText: AppString.currentPassText,
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
                  ],
                ),
                //====================================> New Password Text Field <=========================
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.newPass),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller:  authController. newPasswordCTRl,
                      hintText: AppString.newPassText,
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
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
                //====================================> Conform Password Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.confirmNewPass),
                    SizedBox(height: 8.h),
                    CustomTextField(
                        controller:  authController. conformPasswordCTRl,
                        hintText: AppString.confirmNewPassText,
                        isPassword: true,
                        validator: (value) {
                          if (value != authController.newPasswordCTRl.text) {
                            return "Password do not match";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                //===============================>  Text <===============================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.forgetPasswordScreen);
                      },
                      child: CustomText(
                        text: AppString.forgotPass,
                        fontWeight: FontWeight.w500,
                        fontsize: 18.sp,
                        color: AppColors.primaryColor,
                        textAlign: TextAlign.center,
                        bottom: 12.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 230.h,
                ),
                //===============================> Update Button <===============================
                Obx(()=>
                   CustomButton(
                     loading: authController.changePasswordLoading.value,
                      text: AppString.updatePass,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authController.changePassword(
                             authController. currentPasswordCTRl.text.trim(),
                              authController. newPasswordCTRl.text.trim());
                        }

                      }
                      // _showUpdateDialog,
                      ),
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
