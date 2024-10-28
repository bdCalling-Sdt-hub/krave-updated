import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';

class EditAccountInformation extends StatefulWidget {
  const EditAccountInformation({super.key});

  @override
  State<EditAccountInformation> createState() => _EditAccountInformationState();
}

class _EditAccountInformationState extends State<EditAccountInformation> {

  final ProfileController profileController = Get.find<ProfileController>();
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
          AppString.editAccountInfo,
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
                      readOnly: emailCTRl.text.isEmpty ? false : true,
                      controller: emailCTRl,
                      hintText: AppString.emailText,
                      isEmail: true,
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),


                ///======phone=====//
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.phoneNumber),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      controller: phoneCTRl,
                      hintText: "N/A",
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),

                SizedBox(height: 220.h,),
                //===============================>  Button <===============================
                Obx(()=>
                   CustomButton(
                     loading: profileController.updateProfileLoading.value,
                      text: AppString.save,
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          profileController.profileUpdate(email: emailCTRl.text, name: nameCTRl.text);
                        }
                        // Get.toNamed(AppRoutes.personalInformationScreen);
                      }),
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
