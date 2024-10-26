import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TimeFormatHelper {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  static String justDateWithUnderscoll(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String dateMountFormat(DateTime date) {
    return DateFormat('dd\n MMM ').format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }




 static String timeWithAMPMNew(String time) {
    // Insert a colon to make the time format HH:mm
    String formattedTime = time.substring(0, 2) + ":" + time.substring(2);

    DateTime parsedTime = DateFormat('HH:mm').parse(formattedTime);
    String outputTime = DateFormat('h:mm a').format(parsedTime);
    return outputTime;
  }




  //===============================> Show Clock Function <=======================
  static Future<void> selectTime(BuildContext context, Function(String) onTimeSelected) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final hours = pickedTime.hour.toString().padLeft(2, '0');
      final minutes = pickedTime.minute.toString().padLeft(2, '0');
      final time = "$hours:$minutes";
      onTimeSelected(time);
      print('Selected time: $time');
    }
  }


}
