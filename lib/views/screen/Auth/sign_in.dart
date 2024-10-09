import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/toast.dart';
import 'package:krave/utils/app_colors.dart';

import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isChecked = false;
  bool isCheckboxError = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberCTRl = TextEditingController();
  final TextEditingController passwordCTRl = TextEditingController();

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
                      text: AppString.signIn,
                      fontWeight: FontWeight.w500,
                      fontsize: 18.sp,
                      color: AppColors.textColor,
                      textAlign: TextAlign.center,
                      bottom: 12.h,),
                    SizedBox(height: 4.h,),
                    CustomText(
                      text: AppString.signTnText,
                      fontWeight: FontWeight.w400,
                      maxline: 1,
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
                                favorite: const ['+44', 'BD'],
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
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 24.w,
                              height: 25.h,
                              child: Checkbox(
                                value: _isChecked,
                                checkColor: AppColors.backgroundColor,
                                activeColor: Get.theme.primaryColor,
                                isError: isCheckboxError,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppString.remember,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.forgetPasswordScreen);
                          },
                          child: Text(
                            AppString.forgot,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),

                SizedBox(height: 26.h),

                //===============================> Sign In Button <===============================
                CustomButton(
                    text: AppString.signIn,
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        if(_isChecked){
                          Get.offAllNamed(AppRoutes.homeScreen);
                        }else{
                          Get.offAllNamed(AppRoutes.homeScreen);
                          ToastMessageHelper.showToastMessage("save");
                        }
                       
                      }
                    }),
                SizedBox(height: 20.h),
                /// ===============================> Already have an Account and Sign In <===============================
            Center(
              child: RichText(
                text: TextSpan(
                  text: AppString.dontHave,
                  style: const TextStyle(color: Colors.black), // Explicitly setting color here
                  children: [
                    TextSpan(
                      text: AppString.space,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black, // Ensure a color is set here
                      ),
                    ),
                    TextSpan(
                      text: AppString.signup,
                      style: TextStyle(color: Get.theme.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.signUpScreen);
                        },
                    ),
                  ],
                ),
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
