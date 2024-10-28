import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import 'InnerWidget/pin_code_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpCtrl = TextEditingController();
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
                    text: AppString.getOtp,
                    fontWeight: FontWeight.w500,
                    fontsize: 18.sp,
                    color: AppColors.textColor,
                    textAlign: TextAlign.center,
                    bottom: 12.h,
                  ),
                  SizedBox(height: 4.h,),
                  CustomText(
                    text: AppString.otpCode,
                    fontWeight: FontWeight.w400,
                    maxline: 2,
                    fontsize: 16.sp,
                    textAlign: TextAlign.start,
                    bottom: 12.h,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomPinCodeTextField(otpCTE: otpCtrl,),
              SizedBox(height: 24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      authController.reSendOtp("${Get.parameters["phone"]}");
                    },
                    child: CustomText(
                      text: AppString.otpDidnt,
                      fontsize: 18.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 240.h),
              //===============================> OTP Button <===============================
              Obx(()=>
                 CustomButton(
                   loading: authController.verfyLoading.value,
                    text: AppString.verify,
                    onTap: () {
                      if(Get.parameters["screenType"] == "forgot"){
                        authController.verfyPhone(phone: Get.parameters["phone"], otpCode: otpCtrl.text.trim(), screenType: "forgot");
                      }else{
                        authController.verfyPhone(phone: Get.parameters["phone"], otpCode: otpCtrl.text.trim(), screenType: "SignUp");
                      }

                      otpCtrl.clear();
                      // Get.toNamed(AppRoutes.resetScreen);
                    }),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}
