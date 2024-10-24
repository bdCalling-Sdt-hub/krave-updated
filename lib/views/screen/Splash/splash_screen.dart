import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/helpers/route.dart';
import 'package:krave/utils/app_constants.dart';
import 'package:krave/views/screen/OnBoard/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   jump();
    super.initState();
  }

  jump()  {
    Future.delayed(const Duration(seconds: 3), () async{
      var token = await PrefsHelper.getString(AppConstants.bearerToken);
      var isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
      if(isLogged){
        if(token.isNotEmpty){
          Get.offAllNamed(AppRoutes.homeScreen);
        }
      }else{
        Get.offAllNamed(AppRoutes.onboardScreen);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png",height: 156.h,width: 240.w,),
      ),
    );
  }
}
