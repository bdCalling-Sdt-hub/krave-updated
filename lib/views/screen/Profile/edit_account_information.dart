import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class EditAccountInformation extends StatefulWidget {
  const EditAccountInformation({super.key});

  @override
  State<EditAccountInformation> createState() => _EditAccountInformationState();
}

class _EditAccountInformationState extends State<EditAccountInformation> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCTRl = TextEditingController();
  final TextEditingController emailCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();

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
                      controller: emailCTRl,
                      hintText: AppString.emailText,
                      isEmail: true,
                    ),
                    SizedBox(height: 15.h,),
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
                SizedBox(height: 350.h,),
                //===============================>  Button <===============================
                CustomButton(
                    text: AppString.save,
                    onTap: () {
                      Get.toNamed(AppRoutes.personalInformationScreen);
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
