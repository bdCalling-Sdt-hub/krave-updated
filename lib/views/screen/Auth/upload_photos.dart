import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krave/helpers/toast.dart';

import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class UpdatePhotosScreen extends StatefulWidget {
  const UpdatePhotosScreen({super.key});

  @override
  State<UpdatePhotosScreen> createState() => _UpdatePhotosScreenState();
}

class _UpdatePhotosScreenState extends State<UpdatePhotosScreen> {
  final List<File> _photos = [];

  Future<void> _addPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _photos.add(File(image.path));
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // //===============================> App logo <===============================
              // Center(
              //   child: Image.asset(
              //     AppImages.appLogo,
              //     width: 164.w,
              //     height: 106.h,
              //   ),
              // ),
              SizedBox(height: 23.h),

              //===============================> Text Label field <===============================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppString.uploadPhotos,
                    fontWeight: FontWeight.w500,
                    fontsize: 18.sp,
                    color: AppColors.textColor,
                    textAlign: TextAlign.center,
                    bottom: 12.h,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: AppString.uploadPhotosText,
                    fontWeight: FontWeight.w400,
                    maxline: 1,
                    fontsize: 16.sp,
                    textAlign: TextAlign.start,
                    bottom: 12.h,
                  ),
                ],
              ),
              SizedBox(height: 25.h),

              //===============================> Photo Grid <===============================
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 5.h,
                  childAspectRatio: 180 / 250,
                ),
                itemCount: _photos.length + 1,
                itemBuilder: (context, index) {
                  if (index == _photos.length) {
                    return GestureDetector(
                      onTap: (){
                        if(_photos.length <= 3){
                          _addPhoto();
                        }else{
                          ToastMessageHelper.showToastMessage('You cannot select more than four pictures');
                        }
                      },
                      child: Container(
                        width: 107.w,
                        height: 151.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 50.w,
                          color: AppColors.primaryColor,
                        ),
                      ),

                    );
                  } else {
                    return Stack(
                      children: [
                        Container(
                          width: 107.w,
                          height: 151.h,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: FileImage(_photos[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10.h,
                          right: 10.w,
                          child: GestureDetector(
                            onTap: () => _removePhoto(index),
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 80.h),
              CustomButton(
                  text: AppString.next,
                  onTap: () {
                    Get.toNamed(AppRoutes.detailsScreen);
                  }),
              SizedBox(height: 18.h,),
            ],
          ),
        ),
      ),
    );
  }
}
