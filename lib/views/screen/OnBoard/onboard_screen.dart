import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/route.dart';
import 'package:krave/views/base/custom_button.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal:20.w),
        child: Column(
          children: [
            SizedBox(height:105.h ,),
            Image.asset("assets/images/onboard_icon.png"),
            SizedBox(height: 16.h,),
            Text("Let’s meeting new people around you",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30.sp,),textAlign: TextAlign.center,),
            SizedBox(height:44.h,),
            CustomButton(onTap: (){
              Get.offAllNamed(AppRoutes.signUpScreen);

            }, text:"Get Started" )

          ],
        ),
      ),
    );
  }
}
