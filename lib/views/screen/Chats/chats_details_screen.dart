import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krave/controllers/chat_controller.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/services/api_constants.dart';
import 'package:krave/utils/app_constants.dart';
import 'package:krave/views/base/cachnetwork_image.dart';
import 'package:krave/views/base/custom_loading.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../../models/chat_user_list_model.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/app_images.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key});

  ChatController chatController = Get.find<ChatController>();

  Future<String?> getCurrectUser() async {
    return await PrefsHelper.getString(AppConstants.userId);
  }

  @override
  Widget build(BuildContext context) {
    chatController.getChatUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.chats,
          style: TextStyle(fontSize: 18.h),
        ),
        centerTitle: true,
        backgroundColor: AppColors.fillColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault.w,
          vertical: Dimensions.paddingSizeDefault.h,
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return chatController.chatUserLoading.value
                    ? const CustomLoading()
                    :
                chatController.chatUsers.isEmpty ? noListUser() : ListView
                    .builder(
                  itemCount: chatController.chatUsers.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<String?>(
                      future: getCurrectUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CustomLoading();
                        } else if (snapshot.hasError) {
                          return const Text("Error fetching user ID");
                        } else {
                          var currectUserId = snapshot.hasData;
                          var perticepents = chatController.chatUsers[index];
                          var user = perticepents.participants?.firstWhere((
                              perticepent) => perticepent.id != currectUserId, orElse: null //Participant()
                          );

                          if(user == null)() => const SizedBox();

                         return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.chatPageScreen);
                              },
                              child: userListWidget(
                                name: user?.name,
                                image: user?.profilePictureUrl?.publicFileUrl ?? "",
                                lastMessgae: "${perticepents.lastMessage?.message}"
                              ),
                            ),
                          );
                        }
                      },
                    );



                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomMenu(2),
    );
  }
  
  Widget userListWidget({String? name, lastMessgae, image}){
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 12.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 38.h,
                  width: 38.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: image != "" ? CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: "${ApiConstants.imageBaseUrl}/$image",
                      height: 38.h, width: 38.w) :

                  Image.asset(AppImages.chatImage,
                      width: 38.h, height: 38.h),
                ),
                Positioned(
                  top: 6.h,
                  left: 26.36.w,
                  child: Container(
                    width: 6.05.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors
                          .green, // Adjust color if needed
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name ?? "",
                  fontsize: 16.h,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: 220.w,
                  child: CustomText(
                    text: lastMessgae ?? "",
                    fontsize: 12.h,
                    fontWeight: FontWeight.w400,
                    color: AppColors.shadowColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget noListUser() {
    return Container(
      padding: EdgeInsets.all(8.r),
      color: AppColors.fillColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppString.chatsInitial,
            fontWeight: FontWeight.w500,
            maxline: 1,
            fontsize: 16.sp,
            textAlign: TextAlign.start,
            softWrap: true,
            bottom: 12.h,
          ),
          CustomText(
            text: AppString.chatsInitialText,
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
