import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:krave/helpers/TimeFormatHelper.dart';
import 'package:krave/utils/app_colors.dart';
import '../../../controllers/profile_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
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
  final TextEditingController datingIntentionCTRl = TextEditingController();
  final TextEditingController eatingPracticeCTRl = TextEditingController();
  final TextEditingController favouriteCuisineCTRl = TextEditingController();

  final ProfileController profileController = Get.find<ProfileController>();

  String selectedGender = '';
  String selectedCategory = 'Select Category';
  late TextEditingController currentCategoryController;

  @override
  void initState() {
    dateCTRl.text = TimeFormatHelper.formatDate(DateTime.parse(Get.arguments["date"] ?? DateTime.now()));
    locationCTRl.text = Get.arguments["location"] ?? "";
    datingIntentionCTRl.text = Get.arguments["bio"] ?? "";
    eatingPracticeCTRl.text = Get.arguments["eating"] ?? "";
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
                //====================================> date Text Field <=========================
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.dateOfBirth),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      readOnly: true,
                      onTap: (){
                        _selectDate(context);
                      },
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
      dateCTRl.text = formattedDate;
    }
  }

}
