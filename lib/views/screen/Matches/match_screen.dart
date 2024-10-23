import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krave/controllers/match_controller.dart';
import 'package:krave/services/api_constants.dart';
import 'package:krave/views/base/custom_loading.dart';
import '../../../controllers/chat_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class MatchDetailsScreen extends StatelessWidget {
  MatchDetailsScreen({super.key});

 final MatchController matchController = Get.put(MatchController());


  @override
  Widget build(BuildContext context) {
    matchController.getMatchUsers();
    print("===================================match home screen 2nd");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.matches,
          style: TextStyle(fontSize: 18.h),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Expanded(
              child: Obx(
                () => matchController.matchLoading.value
                    ? const CustomLoading()
                    : matchController.matchUsers.isEmpty ? noMatchsWidget() : ListView.builder(
                        shrinkWrap: true,
                        itemCount: matchController.matchUsers.length,
                        itemBuilder: (context, index) {
                          var matchUser = matchController.matchUsers[index];
                          print("=======================${matchUser.name}");
                          return MatchCard(
                            name: "${matchUser.name}",
                            age: "${matchUser.age}",
                            location: "${matchUser.address}",
                            imagePath: "${matchUser.profilePicture?.publicFileUrl}",
                            conversationId: '${matchUser.conversationId}',
                            receiverId: '${matchUser.id}',
                          );
                        },
                      ),
              ),
            )),
      ),
      bottomNavigationBar: const BottomMenu(0),
    );
  }

  Widget noMatchsWidget(){
    return  Container(
      padding: EdgeInsets.all(8.r),
      color: AppColors.fillColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppString.matchesInitial,
            fontWeight: FontWeight.w500,
            maxline: 1,
            fontsize: 16.sp,
            textAlign: TextAlign.start,
            softWrap: true,
            bottom: 12.h,
          ),
          CustomText(
            text: AppString.matchesInitialText,
            fontWeight: FontWeight.w400,
            maxline: 6,
            fontsize: 16.sp,
            textAlign: TextAlign.start,
            softWrap: true,
            bottom: 12.h,
          ),
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final String name;
  final String age;
  final String location;
  final String imagePath;
  final String conversationId;
  final String receiverId;

   MatchCard({
    required this.name,
    required this.age,
    required this.location,
    required this.imagePath,
    super.key, required this.conversationId, required this.receiverId,
  });

  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 120.w,
              height: 140.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.w),
                  bottomLeft: Radius.circular(8.w),
                ),
                image: DecorationImage(
                  image: NetworkImage("${ApiConstants.imageBaseUrl}/$imagePath"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // CustomNetworkImage(imageUrl: "${ApiConstants.baseUrl}/$imagePath", height: 120.h, width: 140.w),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      //favourite icon
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite,
                              color: AppColors.primaryColor, size: 20.w)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text('Age: $age', style: TextStyle(fontSize: 14.sp)),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.location,
                        height: 16.h,
                        width: 16.w,
                        color: AppColors.textColor,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        location,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Flexible(
                        child: CustomButton(
                          onTap: () {
                            Get.toNamed(AppRoutes.findRestaurantScreen);
                          },
                          text: 'Find Restaurant',
                        ),
                      ),
                      SizedBox(width: 10.w),
                      GestureDetector(
                        onTap: (){
                          chatController.createChat(
                            conversationId: "$conversationId",
                            receiverId: "${receiverId}",
                            message: "@@@###%%%^^^&&&***((())))@@@///+++***111222",
                            messageType: "text"
                          );
                        },
                        child: Container(
                          width: 28.w,
                          height: 28.h,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 2.w),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: SvgPicture.asset(
                            AppIcons.profileChat,
                            width: 10.w,
                            height: 10.h,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomButton({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.backgroundColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
