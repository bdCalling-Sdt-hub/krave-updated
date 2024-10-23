// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../helpers/route.dart';
// import '../../../utils/app_colors.dart';
// import '../../../utils/app_strings.dart';
// import '../../base/bottom_menu..dart';
// import '../../base/custom_text.dart';
//
//
// class MatchesScreen extends StatelessWidget {
//   const MatchesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppString.matches,
//           style: TextStyle(fontSize: 18.h),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//         child: Column(
//           children: [
//             SizedBox(height: 8.h,),
//             //===============================> Matches info <===============================
//             GestureDetector(
//               onTap: () {
//                 Get.toNamed(AppRoutes.matchDetailsScreen);
//               },
//               child: Container(
//                 padding: EdgeInsets.all(8.r),
//                 color: AppColors.fillColor,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: AppString.matchesInitial,
//                       fontWeight: FontWeight.w500,
//                       maxline: 1,
//                       fontsize: 16.sp,
//                       textAlign: TextAlign.start,
//                       softWrap: true,
//                       bottom: 12.h,
//                     ),
//                     CustomText(
//                       text: AppString.matchesInitialText,
//                       fontWeight: FontWeight.w400,
//                       maxline: 6,
//                       fontsize: 16.sp,
//                       textAlign: TextAlign.start,
//                       softWrap: true,
//                       bottom: 12.h,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.h,),
//
//           ],
//         ),
//       ),
//       bottomNavigationBar: const BottomMenu(0),
//     );
//
//   }
// }
