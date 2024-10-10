import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/toast.dart';
import 'package:krave/utils/app_colors.dart';

import '../../../controllers/auth_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false;
  bool isCheckboxError = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  final TextEditingController nameCTRl = TextEditingController();
  final TextEditingController phoneNumberCodeCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();
  final TextEditingController passwordCTRl = TextEditingController();
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
                      text: AppString.signupCreateAccount,
                      fontWeight: FontWeight.w500,
                      fontsize: 18.sp,
                      color: AppColors.textColor,
                      textAlign: TextAlign.center,
                      bottom: 12.h,),
                    SizedBox(height: 4.h,),
                    CustomText(
                      text: AppString.signupText,
                      fontWeight: FontWeight.w400,
                      maxline: 1,
                      fontsize: 16.sp,
                      textAlign: TextAlign.start,
                      bottom: 12.h,
                    ),

                  ],
                ),
                //===============================> Full Name Text-field <===============================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.name),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: AppString.enterName,
                      controller: nameCTRl,
                    ),
                    SizedBox(height: 16.h),
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
                                    phoneNumberCodeCTRl.text = countryCode.toString();
                                    print("*********************contry code $countryCode");
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
                  ],
                ),

                SizedBox(height: 16.h),
                //===============================> Terms and Conditions Check Box <===============================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
                      width: 16.h,
                    ),
                    Expanded(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: AppString.agree,
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: AppString.space,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                        ),
                        TextSpan(
                            text: AppString.terms,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: AppColors.primaryColor))
                      ])),
                    )
                  ],
                ),
                SizedBox(height: 24.h,),
                //===============================> Sign Up Button <===============================
                CustomButton(
                    text: AppString.signup,
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        if(_isChecked){
                          authController.handleSignUp(name: nameCTRl.text, phoneNo: "${phoneNumberCodeCTRl.text}${phoneNumberCTRl.text}", password: passwordCTRl.text.trim());

                        }else{
                          ToastMessageHelper.showToastMessage("Please accept terms of services" , color: Colors.red);
                        }
                      }

                    }),
                SizedBox(height: 18.h,),

             /// ===============================> Already have an Account and Sign In <===============================

                Center(
                  child: RichText(
                    text:TextSpan(
                        text: AppString.alreadyAccount,
                        style: const TextStyle(color:Colors.black),
                        children: [
                          TextSpan(
                              text: AppString.space,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                          ),
                          TextSpan(
                            text: AppString.signsIn,
                            style: TextStyle(color:Get.theme.primaryColor),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Get.toNamed(AppRoutes.signInScreen);
                            },
                          )
                        ]),),
                ),
                SizedBox(
                  height: 16.h,
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
