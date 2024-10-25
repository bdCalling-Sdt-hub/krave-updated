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
            Obx(() {
              return chatController.chatUserLoading.value
                  ? const CustomLoading()
                  : chatController.chatUsers.isEmpty
                      ? noListUser()
                      : Expanded(
                          child: ListView.builder(
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
                                    var currectUserId = snapshot.data;
                                    var perticepents =
                                        chatController.chatUsers[index];
                                    var user = perticepents.participants
                                        ?.firstWhere(
                                            (perticepent) =>
                                                perticepent.id != currectUserId,
                                            orElse: null //Participant()
                                            );

                                    print(
                                        "===================$currectUserId ami");
                                    if (user == null) () => const SizedBox();

                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.chatPageScreen,
                                              arguments: {
                                                "chatId": "${perticepents.id}",
                                                "receiverId": "${user?.id}",
                                                "myId": "$currectUserId",
                                                "name": "${user?.name}",
                                                "time": user?.isOnline == true ? "Active now" : "${perticepents.lastMessage?.createdAt}",
                                                "image": "${user?.profilePictureUrl?.publicFileUrl}",
                                                "isBlocked" : perticepents.isBlocked
                                              });
                                        },
                                        child: userListWidget(
                                            name: user?.name,
                                            image: user?.profilePictureUrl?.publicFileUrl ?? "",
                                            lastMessgae: "${perticepents.lastMessage?.message}",
                                            isActive: user?.isOnline),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
            }),
          ],
        ),
      ),
      bottomNavigationBar: const BottomMenu(2),
    );
  }

  Widget userListWidget({String? name, lastMessgae, image, bool? isActive}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
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
                  height: 55.h,
                  width: 55.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: image != ""
                      ? CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl: "${ApiConstants.imageBaseUrl}/$image",
                          height: 55.h,
                          width: 55.w)
                      : Image.asset(AppImages.chatImage,
                          width: 55.h, height: 55.h),
                ),
                Positioned(
                  bottom: 0.h,
                  right: 0.w,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.5),
                      shape: BoxShape.circle,
                      color: isActive == true ? AppColors.green : Colors.grey,
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
                    textAlign: TextAlign.start,
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
        mainAxisSize: MainAxisSize.min,
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
