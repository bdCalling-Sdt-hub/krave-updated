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

class ForegetPasswordScreen extends StatefulWidget {
  const ForegetPasswordScreen({super.key});

  @override
  State<ForegetPasswordScreen> createState() => _ForegetPasswordScreenState();
}

class _ForegetPasswordScreenState extends State<ForegetPasswordScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberCTRl = TextEditingController();

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
              ),

              //====================================> Phone Number Text Field <=========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.phoneNumber),
                  SizedBox(height: 8.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //=================================> Country Code Picker Widget <============================
                            CountryCodePicker(
                              showFlag: false,
                              showFlagDialog: true,
                              onChanged: (countryCode) {
                                setState(() {

                                });
                              },
                              initialSelection: 'BD',
                              favorite: ['+44', 'BD'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: SvgPicture.asset(
                                AppIcons.downArrow,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child:
                        CustomTextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneNumberCTRl,
                          hintText: AppString.phoneNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your phone \nnumber";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 240.h),
              //===============================> OTP Button <===============================
              CustomButton(
                  text: AppString.otp,
                  onTap: () {
                    Get.toNamed(AppRoutes.otpScreen);
                  }),
              SizedBox(height: 25.h),

            ],
          ),
        ),
      ),

    );
  }
}
