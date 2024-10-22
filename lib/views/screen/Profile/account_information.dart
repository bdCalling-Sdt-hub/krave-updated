import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/controllers/profile_controller.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCTRl = TextEditingController();
  final TextEditingController emailCTRl = TextEditingController();
  final TextEditingController phoneCTRl = TextEditingController();

  @override
  void initState() {
    nameCTRl.text = Get.arguments["name"] ?? "";
    emailCTRl.text = Get.arguments["email"] ?? "";
    phoneCTRl.text = Get.arguments["phone"] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.accountProfile,
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
                SizedBox(height: 23.h),
                //====================================> name Text Field <=========================
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.name),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      readOnly: true,
                      hintText: AppString.nameText,
                      controller: nameCTRl,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
                //====================================> Email Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.email),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      readOnly: true,
                        controller: emailCTRl,
                        hintText: "N/A",
                       isEmail: true,
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),


                //====================================> Email Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.phoneNumber),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      readOnly: true,
                      controller: phoneCTRl,
                      hintText: "N/A",
                      isEmail: true,
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),


                SizedBox(height: 220.h,),
                //===============================>  Button <===============================
                CustomButton(
                    text: AppString.edit,
                    onTap: () {
                      Get.toNamed(AppRoutes.editAccountInformationScreen, arguments: {
                        "name" : "${Get.arguments['name']}",
                        "email" : "${Get.arguments["email"]}",
                        "phone" : "${Get.arguments["phone"]}"
                      });
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
