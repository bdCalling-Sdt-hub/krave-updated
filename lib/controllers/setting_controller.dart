import 'dart:convert';

import 'package:get/get.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/utils/app_constants.dart';

import '../helpers/route.dart';
import '../helpers/toast.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class SettingController extends GetxController {
  ///===============Set Distance================<>
  RxBool setDistanceLoading = false.obs;

  setDistance(double distance) async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    setDistanceLoading(true);
    var body = {
      "selectedDistance": distance.toStringAsFixed(0),
      "userId": "$userId"
    };
    var response = await ApiClient.patch(ApiConstants.setDistance("$userId"), body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      PrefsHelper.setInt(AppConstants.distance, distance.toInt());
      ToastMessageHelper.showToastMessage('Set distance set successful!');
      print("======>>> successful");
      setDistanceLoading(false);
    } else {
      setDistanceLoading(false);
    }
  }



  RxBool termDataLoading = false.obs;
  RxString termData = "".obs;
  getTerms(String url) async {
    termData.value = "";
    termDataLoading(true);
    var response = await ApiClient.getData("$url");

    print('--------------------------------------------${response.body}');
    if (response.statusCode == 200) {
      termData.value = response.body["data"]["content"];
      termDataLoading(false);
    } else {
      termDataLoading(false);
    }
  }



  ///===============Delete================<>
  RxBool deleteLoading = false.obs;
  deleteAccount() async {
    deleteLoading(true);
    var body = {};
    var response = await ApiClient.postData(ApiConstants.deleteUsers, jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage('User Delete successful!');
     Get.back();
      print("======>>> successful");
      deleteLoading(false);
    } else {
      deleteLoading(false);
    }
  }


}
