import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controllers/auth_controller.dart';
import '../../../helpers/route.dart';
import '../../../helpers/toast.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';


class UpdatePictureScreen extends StatefulWidget {
  const UpdatePictureScreen({super.key});

  @override
  State<UpdatePictureScreen> createState() => _UpdatePictureScreenState();
}

class _UpdatePictureScreenState extends State<UpdatePictureScreen> {
  final List<File> _photos = [];
  final AuthController authController = Get.find<AuthController>();

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
      appBar: AppBar(
        title: Text(
          AppString.updatePic,
          style: TextStyle(fontSize: 18.h),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              SizedBox(height: 150.h),
              //===============================> Update Button <===============================
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Obx(()=>
                   CustomButton(
                     loading: authController.photosLoading.value,
                    text: AppString.updates,
                    onTap: () {
                      authController.photosUpload(image: _photos, screenType: "profile");

                    },
                  ),
                ),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}
