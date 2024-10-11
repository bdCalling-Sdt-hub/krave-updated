import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../helpers/prefs_helper.dart';
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

  getProfileData(String userId) async {
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
    File? image,
    String? name,
    String? address,
    String? phone,
    String? dateOfBirth,
    String? screenType,
    String? language,
    String? feeling,
  }) async {
    print("**********************************************************");
    updateProfileLoading(true);
    String userId = await PrefsHelper.getString(AppConstants.userId);
    List<MultipartBody> multipartBody = image == null ? [] : [MultipartBody("image", image)];

    var body = screenType == "language"
        ? {"language": "$language"}
        : screenType == "mode" ? {"feeling" : "$feeling"} : {
      "name": '$name',
      "address": "$address",
      "number": "$phone",
      "dateOfBirth": "$dateOfBirth",
    };
    var response = await ApiClient.putMultipartData(
        ApiConstants.editProfile(userId), body,
        multipartBody: multipartBody);

    print("=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      ToastMessageHelper.showToastMessage('Profile Updated Successful');
      getProfileData("");
      update();
      updateProfileLoading(false);
    }
  }
}
