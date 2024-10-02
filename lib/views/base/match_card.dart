// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
//
// import '../../utils/app_colors.dart';
//
// import '../../utils/app_icons.dart';
//
// import 'cachnetwork_image.dart';
// import 'custom_text.dart';
//
// class AllServiceCard extends StatelessWidget {
//   final VoidCallback? ontap;
//   const AllServiceCard(
//       {super.key,
//         this.ontap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: AppColors.primaryColor),
//             borderRadius: BorderRadius.circular(8.r)),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//           child: SizedBox(
//             child: Row(
//               children: [
//                 CustomNetworkImage(
//                   imageUrl:"",
//                   height: 112.h,
//                   width: 130.w,
//                   borderRadius: BorderRadius.circular(4.r),
//
//
//                 ),
//                 SizedBox(width: 24.w),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ///==========================Rating and Distance Row================================>
//                     Row(
//                       children: [
//                         SingleChildScrollView(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(
//                                     AppIcons.star,
//                                     fit: BoxFit.cover,
//                                   ),
//
//                                   SizedBox(width: 5,),
//                                   ///==================Rating Text===================>
//                                   CustomText(
//                                       top: 3.h,
//                                       text: helpInfo!.rating.toString(),
//                                       fontsize: 10.h,
//                                       fontWeight: FontWeight.w400,
//                                       color: AppColors.subTextColor5c5c5c)
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//
//                     ///========================service name======================>
//                     Container(
//                       constraints: const BoxConstraints(maxWidth: 150),
//                       child: CustomText(
//                           text:  ,
//                           fontsize: ,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                           top: 4.h,
//                           bottom: 4.h),
//                     ),
//
//                     ///=========================person name=========================>
//                     Container(
//                       constraints: const BoxConstraints(maxWidth: 150),
//                       child: Row(
//                         children: [
//                           SvgPicture.asset(
//                             AppIcons.person,
//                             height: 12.h,
//                             color: AppColors.subTextColor5c5c5c,
//                           ),
//                           SizedBox(width: 10,),
//                           Expanded(
//                             child: CustomText(
//                                 textAlign: TextAlign.start,
//                                 textOverflow: TextOverflow.ellipsis,
//                                 text:  toString(),
//                                 fontsize: 12.h,
//                                 color: AppColors.subTextColor5c5c5c),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
