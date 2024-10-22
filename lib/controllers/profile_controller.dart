import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/route.dart';
import '../helpers/toast.dart';
import '../models/profile_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../utils/app_constants.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  RxBool profileLoading = false.obs;

  Rx<ProfileModel> profileData = ProfileModel().obs;

  getProfileData() async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    profileLoading(true);
    var response = await ApiClient.getData(ApiConstants.profileEndPoint("$userId"));

    print('--------------------------------------------${response.body}');
    if (response.statusCode == 200) {
      var responseData = response.body;
      profileData.value = ProfileModel.fromJson(responseData['data']);
      profileLoading(false);
    } else if (response.statusCode == 404) {
      profileLoading(false);
    }
  }





  ///===============profile update================<>
  RxBool updateProfileLoading = false.obs;
  profileUpdate({
    String? email,
    String? name,
  }) async {
    print("**********************************************************");
    updateProfileLoading(true);
    String userId = await PrefsHelper.getString(AppConstants.userId);
    var body = {
      "name": '$name',
      "email": "$email",
    };
    var response = await ApiClient.patch(
        ApiConstants.profileNameEdit(userId), body);

    print("=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage('Profile Updated Successful');
      getProfileData();
      update();
      Get.back();    Get.back();
      updateProfileLoading(false);

    }
  }
}
