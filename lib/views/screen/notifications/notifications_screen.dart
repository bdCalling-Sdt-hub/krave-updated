import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          textAlign: TextAlign.start,
          text: AppString.notification,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ),
      ),

      ///-----------------------------------body section-------------------------->
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.today),
            ///-----------------------notification------------------------>
            Expanded(
              child:
              ListView.builder(
                itemCount: 10,
                itemBuilder : (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h, top: index == 0 ? 20.h : 0),
                    child: _Notification('Your profile is matched with Jane Cooper!' , DateTime.now()),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  _Notification(String title, DateTime time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(4.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8.w, right: 7.w),
                padding: EdgeInsets.all(7.r),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFF3E6)),
                child: SvgPicture.asset(
                  AppIcons.notificationBell,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.fontSizeLarge.h,
                      color: AppColors.textColor,
                      fontFamily: "Open Sans/SB 18",
                      height: 1.5),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    top: 2.h,
                    text: TimeAgo.format(time),
                    fontsize: Dimensions.fontSizeSmall.h,
                    fontWeight: FontWeight.w400,
                    color: const Color(
                      0xFF8C8C8C,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}