import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../utils/app_colors.dart';

class CustomPinCodeTextField extends StatelessWidget {
  final TextEditingController otpCTE;

  CustomPinCodeTextField({
    Key? key,
    required this.otpCTE,
  }) : super(key: key);

  static Color borderColor = const Color(0xFFFFC68A);
  static Color textColor = const Color(0xFF222222);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoDisposeControllers: false,
      backgroundColor: Colors.transparent,
      cursorColor: AppColors.primaryColor,
      controller: otpCTE,
      textStyle: TextStyle(color: textColor),
      autoFocus: false,
      appContext: context,
      length: 6,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        selectedColor: AppColors.primaryColor,
        activeFillColor: borderColor,
        selectedFillColor: borderColor,
        inactiveFillColor: borderColor,
        fieldHeight: 57.h,
        fieldWidth: 44.w,
        inactiveColor: borderColor,
        activeColor: AppColors.primaryColor,
      ),
      obscureText: false,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        print("----value: $value");
      },
    );
  }
}
