import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';

class EditPersonalInformation extends StatefulWidget {
  const EditPersonalInformation({super.key});

  @override
  State<EditPersonalInformation> createState() => _EditPersonalInformationState();
}

class _EditPersonalInformationState extends State<EditPersonalInformation> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController bioCTRl = TextEditingController();
  final TextEditingController locationCTRl = TextEditingController();
  final TextEditingController datingIntentionCTRl = TextEditingController();
  final TextEditingController eatingPracticeCTRl = TextEditingController();
  final TextEditingController favouriteCuisineCTRl = TextEditingController();

  final ProfileController profileController = Get.find<ProfileController>();

  String selectedGender = '';
  String selectedCategory = 'Select Category';
  late TextEditingController currentCategoryController;

  @override
  void initState() {
    bioCTRl.text = Get.arguments["bio"] ?? "";
    locationCTRl.text = Get.arguments["location"] ?? "";
    datingIntentionCTRl.text = Get.arguments["datingIntention"] ?? "";
    eatingPracticeCTRl.text = Get.arguments["eatingPractice"] ?? "";
    favouriteCuisineCTRl.text = Get.arguments["favorite"] ?? "";
    super.initState();
  }


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

                //====================================> location Text Field <=========================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.locationAcc),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: locationCTRl,
                      hintText: "Location",
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),
                SizedBox(height: 16.h),

                ///====================================> date Text Field <=========================

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.bio),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: "bio",
                      controller: bioCTRl,
                    ),
                    SizedBox(height: 16.h),
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

                //===============================>  Button <===============================
                CustomButton(
                    text: AppString.save,
                    onTap: () {
                      profileController.profileUpdatePersonalInfo(
                        bio: bioCTRl.text,
                        eatingPrice: eatingPracticeCTRl.text,
                        favorite: favouriteCuisineCTRl.text,
                        location: locationCTRl.text,
                        datingIntention: datingIntentionCTRl.text
                      );
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
