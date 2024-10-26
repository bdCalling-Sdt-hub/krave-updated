import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krave/helpers/TimeFormatHelper.dart';
import 'package:krave/utils/app_colors.dart';
import 'package:krave/views/base/cachnetwork_image.dart';
import '../../../../../utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../../models/restuarant_model.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/app_icons.dart';
import '../../base/custom_text.dart';

class RestaurantDetailsScreen extends StatefulWidget {
   RestaurantDetailsScreen({super.key});

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  RestaurantsModel data = Get.arguments;

  @override
  Widget build(BuildContext context) {

    // List<String> dayNameList = [];
    // List<String> closeDayList = [];
    // String todayStartTime = "";
    // String todayEndTime = "";
    // Map<int, String> daysOfWeek = {
    //   0: "Sunday",
    //   1: "Monday",
    //   2: "Tuesday",
    //   3: "Wednesday",
    //   4: "Thursday",
    //   5: "Friday",
    //   6: "Saturday",
    // };
    //
    // Set<int> openDaysSet = {};
    // for (var x in data.businessHours?.first.open ?? []) {
    //   openDaysSet.add(x.day ?? 0);
    //   dayNameList.add(daysOfWeek[x.day ?? 0] ?? "Unknown Day");
    //   if(DateTime.daysPerWeek == x.day){
    //     todayStartTime = x.start;
    //     todayEndTime = x.end;
    //   }
    // }
    //
    // for (int i = 0; i < 7; i++) {
    //   if (!openDaysSet.contains(i)) {
    //     closeDayList.add(daysOfWeek[i] ?? "Unknown Day");
    //   }
    // }


    List<String> dayNameList = [];
    List<String> closeDayList = [];
    String todayStartTime = "";
    String todayEndTime = "";
    Map<int, String> daysOfWeek = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      0: "Sunday", // Adjusted to match DateTime weekday values
    };

    Set<int> openDaysSet = {};
    int currentDayOfWeek = DateTime.now().weekday % 7; // Adjust for Sunday as 0

    for (var x in data.businessHours?.first.open ?? []) {
      int day = x.day ?? 0;
      openDaysSet.add(day);
      dayNameList.add(daysOfWeek[day] ?? "Unknown Day");

      // Set today's start and end times if it matches the current day
      if (day == currentDayOfWeek) {
        todayStartTime = x.start ?? "";
        todayEndTime = x.end ?? "";
      }
    }

// Collect closed days
    for (int i = 0; i < 7; i++) {
      if (!openDaysSet.contains(i)) {
        closeDayList.add(daysOfWeek[i] ?? "Unknown Day");
      }
    }

// Now `todayStartTime` and `todayEndTime` will have the values for today if available




    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: AppString.restaurant,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              RestaurantCard(
                name: "${data.name}",
                location: "${data.location?.displayAddress?.first}, ${data.location?.displayAddress?[1]}",
                imagePath: "${data.imageUrl}",
              ),
              // Add the text below the card section
              SizedBox(height: 16.h),
              CustomText(
                text: 'Turkish Balloon Café',
                fontsize: 20.h,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
              _row(AppString.shopAddress, '${data.location?.state}, ${data.location?.country}'),
              _row(AppString.shopCategory, '${data.categories?.first.title}'),
              _row(AppString.openingHour, todayStartTime.isEmpty ? "Close Now!" : '${TimeFormatHelper.timeWithAMPMNew(todayStartTime)}-${TimeFormatHelper.timeWithAMPMNew(todayEndTime)}'),
              _row(AppString.weekend, closeDayList.isEmpty ? "No Weekend" : closeDayList.join(", ")),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String trailingText, String leadingText) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: trailingText,
            color: AppColors.textColor,
            fontsize: 16.h,
          ),
          SizedBox(
            width: 204.w,
            child: CustomText(
              maxline: 4,
              textAlign: TextAlign.end,
              text: leadingText,
              color: AppColors.shadowColor,
              fontWeight: FontWeight.w500,
              fontsize: 16.h,
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String name;
  final String location;
  final String imagePath;

  const RestaurantCard({
    required this.name,
    required this.location,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        border: Border.all(color: AppColors.fillColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
            ),
            child: CustomNetworkImage(imageUrl: "$imagePath", height: 150.h, width: Get.width)

            // Image.asset(
            //   imagePath,
            //   width: double.infinity,
            //   height: 150.h,
            //   fit: BoxFit.cover,
            // ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontsize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16.h,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        SizedBox(
                          width: 250.w,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: location,
                            fontsize: 14.h,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      AppIcons.heart1,
                      color: AppColors.fillColor,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class DayNameModel {
  final bool? isOvernight;
  final String? start;
  final String? end;
  final int? day;

  DayNameModel({
    this.isOvernight,
    this.start,
    this.end,
    this.day,
  });

  factory DayNameModel.fromJson(Map<String, dynamic> json) => DayNameModel(
    isOvernight: json["is_overnight"],
    start: json["start"],
    end: json["end"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "is_overnight": isOvernight,
    "start": start,
    "end": end,
    "day": day,
  };
}
