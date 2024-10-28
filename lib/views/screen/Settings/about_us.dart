import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_strings.dart';
import '../../../controllers/setting_controller.dart';
import '../../../utils/app_dimensions.dart';
import '../../base/custom_loading.dart';
import '../../base/custom_text.dart';



class AboutUsScreen extends StatelessWidget {
   AboutUsScreen({super.key});
  final SettingController settingController = Get.find<SettingController>();


  @override
  Widget build(BuildContext context) {
    settingController.getTerms("/about-us");
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

              Obx(
                    () => settingController.termDataLoading.value
                    ? const CustomLoading()
                    : HtmlWidget(
                  settingController.termData.value,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14.h,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


























