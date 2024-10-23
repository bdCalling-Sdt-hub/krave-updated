import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/setting_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class SetDistanceScreen extends StatefulWidget {
  const SetDistanceScreen({super.key});

  @override
  _SetDistanceScreenState createState() => _SetDistanceScreenState();
}

class _SetDistanceScreenState extends State<SetDistanceScreen> {
  final SettingController settingController = Get.find<SettingController>();
  double _currentSliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: 'Set Distance',
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
                fontsize: 18.h,
                textAlign: TextAlign.start,
                maxline: 5,
                text: 'Your distance preference',
              ),
              SizedBox(height: 10.h),
              CustomText(
                color: AppColors.textColor,
                fontsize: 16.h,
                textAlign: TextAlign.start,
                maxline: 3,
                text: 'Use the slider to set the maximum distance you would like to see the potential matches & restaurants.',
              ),
              SizedBox(height: 20.h),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 14.sp, // Knob size
                  ),
                  thumbColor: Color(0xFFFFD9B0),
                  trackHeight: 4.h, // Track height
                  activeTrackColor: Color(0xFFFF8400),
                  inactiveTrackColor: Color(0xFFE8E8E8),
                  overlayColor: Colors.transparent,
                ),
                child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 10,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.h),
              CustomText(
                color: AppColors.textColor,
                textAlign: TextAlign.start,
                maxline: 5,
                text: 'Selected Distance: ${_currentSliderValue.round()} miles',
              ),
              SizedBox(height: 400.h,),
              CustomButton(
                  text: AppString.set,
                  onTap: () {
                    settingController.setDistance(_currentSliderValue);

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
