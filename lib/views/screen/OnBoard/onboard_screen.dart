import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/route.dart';
import 'package:krave/views/base/custom_button.dart';

import '../../../controllers/auth_controller.dart';

class OnboardScreen extends StatelessWidget {
   OnboardScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    authController.getLocalData();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 105.h),
            Center(child: Image.asset("assets/images/onboard_icon.png")),
            SizedBox(height: 16.h),
            Text(
              "Let’s meeting new people around you",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 44.h),
            CustomButton(
                onTap: () {
                  Get.offAllNamed(AppRoutes.signInScreen);
                },
                text: "Get Started")
          ],
        ),
      ),
    );
  }
}
