import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class EditPersonalInformation extends StatefulWidget {
  const EditPersonalInformation({super.key});

  @override
  State<EditPersonalInformation> createState() => _EditPersonalInformationState();
}

class _EditPersonalInformationState extends State<EditPersonalInformation> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController dateCTRl = TextEditingController();
  final TextEditingController locationCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.editPersonalInfo,
          style: TextStyle(fontSize: 18.h),
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
                //====================================> date Text Field <=========================
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.dateOfBirth),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: AppString.dateOfBirthText,
                      controller: dateCTRl,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
                //====================================> location Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.locationAcc),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: locationCTRl,
                      hintText: AppString.locationAccText,
                      isEmail: true,
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(height: 8.h,),
                //===============================> details Info <===============================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.bioDetails),
                    SizedBox(height: 8.h,),
                    Container(
                      padding: EdgeInsets.all(8.r),
                      color: AppColors.fillColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppString.bioDetailsText,
                            fontWeight: FontWeight.w400,
                            maxline: 6,
                            fontsize: 14.sp,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            bottom: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h,),
                //===============================> Eating Practice <===============================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.eatingDetailsPractice),
                    SizedBox(height: 8.h,),
                    Container(
                      padding: EdgeInsets.all(8.r),
                      color: AppColors.fillColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppString.eatingDetailsPracticeText,
                            fontWeight: FontWeight.w400,
                            maxline: 6,
                            fontsize: 14.sp,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            bottom: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h,),
                //===============================> Favourite Cousine <===============================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.favouriteCousine),
                    SizedBox(height: 8.h,),
                    Container(
                      padding: EdgeInsets.all(8.r),
                      color: AppColors.fillColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppString.favouriteCousineText,
                            fontWeight: FontWeight.w400,
                            maxline: 6,
                            fontsize: 14.sp,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            bottom: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                //===============================>  Button <===============================
                CustomButton(
                    text: AppString.save,
                    onTap: () {
                      Get.toNamed(AppRoutes.profileScreen);
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
