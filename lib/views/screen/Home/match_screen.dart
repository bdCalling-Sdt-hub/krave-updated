// import 'package:flutter/material.dart';
//
// class MatchScreen extends StatelessWidget {
//   const MatchScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krave/services/api_constants.dart';
import 'package:krave/utils/app_colors.dart';
import 'package:krave/views/base/cachnetwork_image.dart';
import 'package:krave/views/base/custom_loading.dart';
import 'package:krave/views/base/custom_text.dart';
import '../../../controllers/congratulations_match_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';

class MatchScreen extends StatefulWidget {
  MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final CongratulationsMatchController congratulationsMatchController = Get.find<CongratulationsMatchController>();

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      congratulationsMatchController.getCongratulations(receiverId: "${Get.arguments["receiverId"]}");
      congratulationsMatchController.getRestaurants();
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    print("===================================match home screen");
    return Scaffold(
      backgroundColor: Color(0xFFFFF3E6),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 60.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  Obx(
                    () => congratulationsMatchController
                            .congratulationLoading.value
                        ? const CustomLoading()
                        : congratulationsMatchController
                                .congratulationsUserData.isEmpty
                            ? CustomText(text: "No profile")
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.zero,
                                          child: CustomNetworkImage(
                                            borderRadius: BorderRadius.circular(16.r),
                                              imageUrl: "${ApiConstants.imageBaseUrl}/${congratulationsMatchController.congratulationsUserData.first.userId?.profilePictureUrl?.publicFileUrl}",
                                              height: 300,
                                              width: 100)
                                          // Image.asset('assets/images/female.png', fit: BoxFit.contain,),
                                          )),
                                  SizedBox(width: 0.w),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(top: 200),
                                    child: CustomNetworkImage(
                                        borderRadius: BorderRadius.circular(16.r),
                                        imageUrl: "${ApiConstants.imageBaseUrl}/${congratulationsMatchController.congratulationsUserData[1].userId?.profilePictureUrl?.publicFileUrl}",
                                        height: 300,
                                        width: 100)

                                    // Image.asset(
                                    //   'assets/images/male.png',
                                    //   fit: BoxFit.contain,
                                    // ),
                                  )),
                                ],
                              ),
                  ),
                  Positioned(
                    //top: 50,
                    child: Center(
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Transform.rotate(
                          angle: 125,
                          child: SvgPicture.asset(
                            AppIcons.heart,
                            color: AppColors.primaryColor,
                            height: 30.h,
                            width: 30.w,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              const Text(
                "Congratulations",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
               Text(
                "It's a match, ${Get.arguments["name"]}!!",
                style: TextStyle(
                  fontSize: 24.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
               Text(
                "Here's some restaurant recommendation.",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14.h,
                  color: Colors.grey,
                ),
              ),
               SizedBox(height: 16.h),

              SizedBox(
                height: 215.h,
                child: Obx(()=>
                  congratulationsMatchController.restaurantLoading.value ? const Center(child: CustomLoading()) :  congratulationsMatchController.restaurantsData.isEmpty ? CustomText(text: "No Restaurant Match") : ListView.builder(
                    itemCount: congratulationsMatchController.restaurantsData.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var data = congratulationsMatchController.restaurantsData[index];
                      return _buildRestaurantCard(
                        context,
                        '${data.imageUrl}',
                        '${data.name}',
                        '${data.location?.displayAddress?.first ?? ""}, ${data.location?.displayAddress?[1] ?? ""}',
                      );
                    },
                  ),
                ),
              ),


              SizedBox(height: 15.h),
              // const Text('Start a conversation now with each other'),
              //  SizedBox(height: 25.h),
            Get.arguments["screenType"] == "message" ? const SizedBox() :   ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8400), // Background color
                  minimumSize: const Size(double.infinity, 58),
                  shape: const RoundedRectangleBorder(),
                ),
                child: Text(
                  "Say Hello!",
                  style:
                      TextStyle(fontSize: 16.h, color: AppColors.backgroundColor),
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.homeScreen);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  backgroundColor: AppColors.borderColors,
                  // Text color
                  side: const BorderSide(color: Colors.orange),
                  minimumSize: const Size(double.infinity, 58),
                  shape: const RoundedRectangleBorder(),
                ),
                child:  Text(
                  "Back to home",
                  style: TextStyle(fontSize: 18.h),
                ),
              ),
              // SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(
      BuildContext context, String imagePath, String name, String distance) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 210.h,
        width: 239.w,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:
              CustomNetworkImage(imageUrl: "$imagePath", height: 100.h, width: Get.width)
            ),
            SizedBox(height: 8.h),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.location_on,
                    color: AppColors.subTextColor, size: 16),
                SizedBox(width: 4.h),
                Expanded(
                  child: Text(
                    maxLines: 2,
                    distance,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
