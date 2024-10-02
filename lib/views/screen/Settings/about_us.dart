import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';
import '../../base/custom_text.dart';



class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      //===========================================> AppBar Section <=============================================
      appBar: AppBar(
        title: CustomText(
          text: AppString.about,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge, vertical: 16.h),
          child: Column(
            children: [
              //===========================================> Text Section <=============================================
              CustomText(
                color: AppColors.textColor,
                textAlign: TextAlign.start,
                maxline: 5,
                text: AppString.text,
              ),
              SizedBox(height: 10,),
              CustomText(
                color: AppColors.textColor,
                textAlign: TextAlign.start,
                maxline: 5,
                text: AppString.text1,
              ),
              SizedBox(height: 10,),
              CustomText(
                color: AppColors.textColor,
                textAlign: TextAlign.start,
                maxline: 5,
                text: AppString.text2,
              )
            ],
          ),
        ),
      ),
    );
  }
}


























