import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:krave/utils/app_strings.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/route.dart';
import '../helpers/toast.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../utils/app_constants.dart';

class AuthController extends GetxController {
  final TextEditingController emailCtrl = TextEditingController(text: kDebugMode ? 'sagor4@gmail.com' : '',);
  // ProfileController profileController = Get.put(ProfileController());

  ///************************************************************************///
  RxBool signUpLoading = false.obs;
  ///===============Sing up ================<>
  handleSignUp({String? name, phoneNo, password}) async {
    signUpLoading(true);
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "phone": "$phoneNo",
      "name": "$name",
      "password": "$password",
      "role": "USER",
    };

    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var userId = response.body["data"]['_id'];
      print("************************user id $userId");
      await PrefsHelper.setString(AppConstants.userId,  userId);
      Get.toNamed(AppRoutes.otpScreen, parameters: {
        'phone': "$phoneNo",
        'screenType': "signUp",
        "userId" : "$userId"
      });
      ToastMessageHelper.showToastMessage("Account create successful");
      signUpLoading(false);
    } else if(response.statusCode == 1){
      signUpLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      signUpLoading(false);
    }
  }


  ///************************************************************************///
  ///===============Verify Phone================<>
  RxBool verfyLoading = false.obs;
  verfyPhone({String? otpCode, phone, String screenType = ''}) async {
    verfyLoading(true);

    var body =  {"phone": phone, "code": otpCode};

    var response = await ApiClient.postData(
        ApiConstants.verifyPhoneEndPoint, jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("==========bearer token save done : ${response.body['data']['token']}");
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);

      if (screenType == 'forgot') {
        // Get.toNamed(AppRoutes.setNewPasswordScreen);
      }else if(screenType == "SignUp"){
        Get.toNamed(AppRoutes.uploadPhotosScreen);
      }
      verfyLoading(false);
    } else if(response.statusCode == 1){
      verfyLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      verfyLoading(false);
    }
  }



  ///************************************************************************///
  ///===============photos================<>
  RxBool photosLoading = false.obs;
  photosUpload({String screenType = '', required List <File> image,}) async {
    photosLoading(true);
    var userId = await PrefsHelper.getString(AppConstants.userId);

    List<MultipartBody> photoList = [];
    for(var photos in image){
      photoList.add(MultipartBody("image", photos));
    }

    List<MultipartBody> multipartBody = photoList ?? [];
    Map<String, String> body =  {};
    var response = await ApiClient.postMultipartData(ApiConstants.photoUploadAuth("$userId"), body, multipartBody: multipartBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      photosLoading(false);
      Get.toNamed(AppRoutes.detailsScreen);
    } else if(response.statusCode == 1){
      photosLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      photosLoading(false);
    }
  }




  ///************************************************************************///
  ///===============Log in================<>
  RxBool logInLoading = false.obs;
  handleLogIn(String phoneNumber, String password) async {
    // ProfileController profileController = Get.find<ProfileController>();
    // profileController.getProfileData();
    logInLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "password": password,
      "phone" : "$phoneNumber"
    };
    var response = await ApiClient.postData(
        ApiConstants.signInEndPoint, jsonEncode(body),
        headers: headers);
    print("========================${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data']["user"];

      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
      await PrefsHelper.setString(AppConstants.name, data['userName']);
      await PrefsHelper.setString(AppConstants.userId, data['id']);
      await PrefsHelper.setBool(AppConstants.isLogged, true);

       Get.offAllNamed(AppRoutes.homeScreen);
            ToastMessageHelper.showToastMessage('Your are logged in');

      logInLoading(false);
    } else if(response.statusCode == 1){
      logInLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    }else{
      if (response.body["message"] == "Please verify your email") {
        // Get.toNamed(AppRoutes.verifyEmailScreen,
        //     parameters: {'userId': "${response.body['data']["id"]}", "screenType" : "signUp"});
        ToastMessageHelper.showToastMessage("your account create is successful but you don't verify your email. \n \n Please verify your account");

      }else{
        ToastMessageHelper.showToastMessage(response.body["message"]);
      }
      logInLoading(false);
    }
  }



  ///************************************************************************///
  ///===============Forgot Password================<>
  RxBool forgotLoading = false.obs;

  handleForgot(String phone, screenType) async {
    forgotLoading(true);
    var body = {"phone": phone};

    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('=================screen type $screenType');
      emailCtrl.clear();
      // Get.toNamed(AppRoutes.verifyEmailScreen,
      //     parameters: {"screenType": "forgot", 'userId': response.body['data']['id']});
      await PrefsHelper.setString(AppConstants.userId, response.body["data"]["id"]);
      // ToastMessageHelper.showToastMessage('');
      print("======>>> successful");
      forgotLoading(false);
    } else if(response.statusCode == 1){
      forgotLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      forgotLoading(false);
    }
  }



  ///===============Set Password================<>
  RxBool setPasswordLoading = false.obs;
  setPassword(String password, oldPassword, type) async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    setPasswordLoading(true);
    var body = {"oldPassword": "$oldPassword", "password": "$password"};

    var response = await ApiClient.patch(
       ApiConstants.setPasswordEndPoint("$userId"), jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.signInScreen);
      ToastMessageHelper.showToastMessage('Password Changed');
      print("======>>> successful");
      setPasswordLoading(false);
    } else if(response.statusCode == 1){
      setPasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      setPasswordLoading(false);
    }
  }

  ///===============Resend================<>
  RxBool resendLoading = false.obs;
  reSendOtp(String phone) async {
    resendLoading(true);
     var body = {"phone": phone.toString()};
    var response = await ApiClient.postData(
        ApiConstants.resendOtpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage(
          'You have got an one time code to your email');
      print("======>>> successful");
      resendLoading(false);
    }else{
      resendLoading(false);
    }
  }

  ///===============Change Password================<>
  RxBool changePasswordLoading = false.obs;

  changePassword(String oldPassword, newPassword) async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    changePasswordLoading(true);
    var body = {"oldPassword": "$oldPassword", "newPassword": "$newPassword"};

    var response =
        await ApiClient.patch(ApiConstants.setPasswordEndPoint("$userId"), jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage('Password Changed Successful');
      print("======>>> successful");
      changePasswordLoading(false);
    } else if(response.statusCode == 1){
      changePasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage(response.body['message']);
      changePasswordLoading(false);
    }
  }



  ///************************************************************************///
  RxBool moreInfoLoading = false.obs;
  ///===============personal details================<>
  moreInformationProfile({String? dateOfBirth, gender, bio, datignTntertion, favouriteCousing, distanceForMatch, longitude, latitude}) async {

    moreInfoLoading(true);
    var userId = await PrefsHelper.getString(AppConstants.userId);
    Map<String, String> body = {
      // "email": "email",
      "dateOfBirth": "$dateOfBirth",
      "gender": "$gender",
      "bio": "$bio",
      "datingIntention": "$datignTntertion",
      "favouriteCousing": "$favouriteCousing",
      "distanceForMatch": "$distanceForMatch",
      "latitude": "$latitude",
      "longitude": "$longitude",
    };

    var response = await ApiClient.postData(
      ApiConstants.profileMoreInfoEndPoint("$userId"),
      jsonEncode(body)
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.signInScreen);
      moreInfoLoading(false);
    } else if(response.statusCode == 1){
      moreInfoLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      moreInfoLoading(false);
      ToastMessageHelper.showToastMessage(response.body["message"]);
    }
  }

}
