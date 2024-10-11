import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:krave/utils/app_colors.dart';

import '../../../controllers/auth_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class ForegetPasswordScreen extends StatefulWidget {
  const ForegetPasswordScreen({super.key});

  @override
  State<ForegetPasswordScreen> createState() => _ForegetPasswordScreenState();
}

class _ForegetPasswordScreenState extends State<ForegetPasswordScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberCTRl = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  FocusNode focusNode = FocusNode();
  RxBool isPhoneEmpty = false.obs;

  @override
  void initState() {
    setState(() {
      phoneNumberCTRl.text = Get.arguments ?? "";
    });

    super.initState();
  }

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
                      text: AppString.forgots,
                      fontWeight: FontWeight.w500,
                      fontsize: 18.sp,
                      color: AppColors.textColor,
                      textAlign: TextAlign.center,
                      bottom: 12.h,),
                    SizedBox(height: 4.h,),
                    CustomText(
                      text: AppString.pleaseEnter,
                      fontWeight: FontWeight.w400,
                      maxline: 2,
                      fontsize: 16.sp,
                      textAlign: TextAlign.start,
                      bottom: 12.h,
                    ),

                  ],
                ),

                //====================================> Phone Number Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.phoneNumber),
                    SizedBox(height: 8.h),
                    IntlPhoneField(
                      focusNode: focusNode,
                      decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.hintColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.hintColor)
                          )
                      ),
                      initialCountryCode: 'US',
                      onChanged: (phone) {
                        if(phone.number.isNotEmpty){
                          isPhoneEmpty.value = false;
                        }
                        phoneNumberCTRl.text = phone.completeNumber;

                      },
                    ),
                    Obx(() => isPhoneEmpty.value? CustomText(text: "Please enter your phone number",) : const SizedBox.shrink(),)
                  ],
                ),
                SizedBox(height: 240.h),
                //===============================> OTP Button <===============================
                CustomButton(
                    text: AppString.otp,
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        authController.handleForgot(phoneNumberCTRl.text, "forgot");
                        phoneNumberCTRl.clear();
                      }

                    }),
                SizedBox(height: 25.h),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
