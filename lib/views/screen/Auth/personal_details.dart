import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krave/helpers/TimeFormatHelper.dart';
import 'package:krave/helpers/toast.dart';
import 'package:krave/views/screen/Auth/location.dart';

import '../../../controllers/auth_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController dateBirthCTRl = TextEditingController();
  final TextEditingController locationCTRl = TextEditingController();
  final TextEditingController bioCTRl = TextEditingController();
  final TextEditingController datingIntentionCTRl = TextEditingController();
  final TextEditingController eatingPracticeCTRl = TextEditingController();
  final TextEditingController favouriteCuisineCTRl = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  var latitude = '';
  var longitude = '';


  String selectedGender = '';
  String selectedCategory = 'Select Category';
  late TextEditingController currentCategoryController;

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      String formattedDate =   DateFormat('MM-dd-yyyy').format(pickedDate);
      dateBirthCTRl.text = formattedDate;
    }
  }

  void _showCategoryDialog(TextEditingController controller, List<String> categories) {
    currentCategoryController = controller;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Category'),
          content: Container(
            height: 400.h,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index]),
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                      currentCategoryController.text = selectedCategory;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 23.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///====================================> Personal Details <=========================
                    CustomText(
                      text: AppString.personalDetails,
                      fontWeight: FontWeight.w500,
                      fontsize: 18.sp,
                      color: AppColors.textColor,
                      textAlign: TextAlign.center,
                      bottom: 12.h,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: AppString.personalDetailsText,
                      fontWeight: FontWeight.w400,
                      maxline: 3,
                      fontsize: 16.sp,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      bottom: 12.h,
                    ),
                    CustomText(
                      text: AppString.personalDetailText,
                      fontWeight: FontWeight.w400,
                      maxline: 3,
                      fontsize: 16.sp,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      bottom: 12.h,
                    ),
                  ],
                ),
                ///====================================> Date of Birth <=========================
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.dateBirth),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          hintText: AppString.dateBirthText,
                          controller: dateBirthCTRl,
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryColor,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter data of birth";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
                ///====================================> Gender Selection <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.gender),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildGenderRadio('Male'),
                        _buildGenderRadio('Female'),
                        _buildGenderRadio('Others'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ///====================================> Location Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.location),
                    SizedBox(height: 8.h),
                    // Inside DetailsScreen build method
                    CustomTextField(
                      onTap: () async {
                        final Map data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationScreen(), // Show the LocationScreen
                          ),
                        );
                        if (data.isNotEmpty) {
                          setState(() {
                            locationCTRl.text = data["address"];
                            latitude = "${data["latitude"]}";
                            longitude = "${data["longitude"]}";
                          });
                        }
                      },
                      hintText: AppString.locationText,
                      readOnly: true,
                      controller: locationCTRl,
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your location";
                        }
                        return null;
                      },
                    ),

                  ],
                ),
                SizedBox(height: 16.h),
                ///====================================> Bio Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.bio),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: AppString.bios,
                      controller: bioCTRl,
                      validator: (value) {
                        if(value!.length < 10){
                          return "Bio data mush have more then 10 letter!";
                        }return null;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ///====================================> Dating Intention Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.datingIntention),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _showCategoryDialog(datingIntentionCTRl,datingIntenTionsList ),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: AppString.datingIntentionText,
                          controller: datingIntentionCTRl,
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SvgPicture.asset(
                              AppIcons.downArrow,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select dating intention";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ///====================================> Eating Practice Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.eatingPractice),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _showCategoryDialog(eatingPracticeCTRl, eatingPractices),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: AppString.eatingPracticeText,
                          controller: eatingPracticeCTRl,
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SvgPicture.asset(
                              AppIcons.downArrow,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select eating practice";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ///====================================> Favorite Cuisine Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.favoriteCuisine),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _showCategoryDialog(favouriteCuisineCTRl, favoriteCuisines),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: AppString.favoriteCuisineText,
                          controller: favouriteCuisineCTRl,
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SvgPicture.asset(
                              AppIcons.downArrow,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select favorite cuisine";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                ///====================================> Complete Button <=========================
                CustomButton(
                  text: AppString.completeProfile,
                  onTap: () {
                    if(_formKey.currentState!.validate()){

                      if(selectedGender.isEmpty){
                        ToastMessageHelper.showToastMessage("Please select gender");
                      }else{
                        authController.moreInformationProfile(
                          dateOfBirth: dateBirthCTRl.text,
                          bio: bioCTRl.text,
                          gender: selectedGender.toString(),
                          datignTntertion: datingIntentionCTRl.text,
                          favouriteCousing: favouriteCuisineCTRl.text,
                          distanceForMatch: eatingPracticeCTRl.text,
                          latitude: "$latitude",
                          longitude: "$longitude",
                          address: locationCTRl.text,
                        );
                      }

                    }

                    // Get.toNamed(AppRoutes.signUpScreen);
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderRadio(String gender) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          gender,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16.sp,
          ),
        ),
        leading: Radio<String>(
          value: gender,
          groupValue: selectedGender,
          onChanged: (String? value) {
            setState(() {
              selectedGender = value ?? '';
            });
          },
          activeColor: AppColors.primaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact, 
        ),
      ),
    );
  }



  List<String> datingIntenTionsList = [
    "Casual Dating",
    "Serious/Long-term Relationship",
    "Friendship/Dating with No Expectations",
    "Marriage",
    "Exploration/Curiosity",
    "Hookups/Fun",
    "Open Relationship/Polyamory",
    "Rebound Relationship",
    "Companionship",
    "Activity Partner"
  ];


  List<String> favoriteCuisines = [
    "Italian",
    "Mexican",
    "Chinese",
    "Indian",
    "Japanese",
    "Thai",
    "French",
    "Greek",
    "Mediterranean",
    "Korean"
  ];



  List<String> eatingPractices  = [
    "Vegetarian",
    "Vegan",
    "Pescatarian",
    "Keto",
    "Paleo",
    "Gluten-Free",
    "Dairy-Free",
    "Low-Carb",
    "Intermittent Fasting",
    "Omnivore"
  ];


}
