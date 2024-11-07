import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/helpers/toast.dart';
import 'package:krave/utils/app_colors.dart';
import 'package:krave/utils/app_constants.dart';

import '../../../controllers/auth_controller.dart';
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
  final TextEditingController phoneCompleteNumberCTRl = TextEditingController();
  final TextEditingController passwordCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl2 = TextEditingController();

  final AuthController authController = Get.find<AuthController>();
  FocusNode focusNode = FocusNode();
  RxBool isPhoneEmpty = false.obs;

  @override
  void initState() {
    super.initState();
    getLocalData();  // Call function to load stored data
  }

  getLocalData() async {
    // Retrieve saved values
    authController. phoneNumberCodeCTRl.text = await PrefsHelper.getString(AppConstants.loginCountryCode);
    phoneNumberCTRl2.text = await PrefsHelper.getString(AppConstants.loginPhoneSave);
    passwordCTRl.text = await PrefsHelper.getString(AppConstants.logInPasswordSaveRemember);

    // Set phone number with the saved country code
    phoneCompleteNumberCTRl.text = authController.phoneNumberCodeWithNumberCTRl.text + phoneNumberCTRl2.text;
  }

  @override
  Widget build(BuildContext context) {
    print("++++++++++++++++++++++++++++++++++++++++++${ authController.phoneNumberCodeCTRl.text}");
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
                Center(
                    child: Image.asset(AppImages.appLogo, width: 164.w, height: 106.h)
                ),
                SizedBox(height: 23.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppString.signIn,
                      fontWeight: FontWeight.w500,
                      fontsize: 18.sp,
                      color: AppColors.textColor,
                      textAlign: TextAlign.center,
                      bottom: 12.h,
                    ),
                    SizedBox(height: 4.h),
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.phoneNumber),
                    SizedBox(height: 8.h),
                    IntlPhoneField(
                      controller: phoneNumberCTRl2,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.hintColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.hintColor),
                        ),
                      ),
                      initialCountryCode: authController. phoneNumberCodeCTRl.text,
                      onChanged: (phone) {
                        if (phone.number.isNotEmpty) {
                          isPhoneEmpty.value = false;
                        }
                        setState(() {
                          authController. phoneNumberCodeCTRl.text = phone.countryISOCode;
                        });
                        phoneCompleteNumberCTRl.text = phone.completeNumber;
                        PrefsHelper.setString(AppConstants.phoneNumberCodeWithNumberCTRl, phone.countryCode);
                      },
                    ),
                    Obx(() => isPhoneEmpty.value ? CustomText(text: "Please enter your phone number") : const SizedBox.shrink()),
                  ],
                ),

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
                            Get.toNamed(AppRoutes.forgetPasswordScreen, arguments: phoneCompleteNumberCTRl.text);
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
                Obx(()=>
                    CustomButton(
                        loading: authController.logInLoading.value,
                        text: AppString.signIn,
                        onTap: () async {
                          if (phoneCompleteNumberCTRl.text.isEmpty) {
                            isPhoneEmpty.value = true;
                          }
                          if (_formKey.currentState!.validate()) {
                            if (_isChecked) {
                              authController.handleLogIn(phoneCompleteNumberCTRl.text, passwordCTRl.text.trim());
                              await PrefsHelper.setString(AppConstants.loginCountryCode, authController. phoneNumberCodeCTRl.text);
                              await PrefsHelper.setString(AppConstants.logInPasswordSaveRemember, passwordCTRl.text.trim());
                              await PrefsHelper.setString(AppConstants.loginPhoneSave, phoneNumberCTRl2.text.trim());
                            } else {
                              authController.handleLogIn(phoneCompleteNumberCTRl.text, passwordCTRl.text.trim());
                            }
                          }
                        }
                    ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: AppString.dontHave,
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: AppString.space,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: AppString.signup,
                          style: TextStyle(color: Get.theme.primaryColor),
                          recognizer: TapGestureRecognizer()..onTap = () {
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
