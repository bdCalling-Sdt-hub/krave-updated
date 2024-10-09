import 'dart:convert';
import 'dart:io';
import 'package:elevate_daily/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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
  RxString feeling = "".obs;
  RxString gender = "".obs;
  RxString enhance = "".obs;
  ///===============Sing up ================<>
  handleSignUp({String? name, email, password, fcmToken}) async {
    signUpLoading(true);
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "email": "$email",
      "name": "$name",
      "password": "$password",
      "enhance": "$enhance",
      "feeling": "$feeling",
      "gender": "$gender",
      "fcmToken":"$fcmToken"
    };

    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var userId = response.body["data"]['id'];
      print("************************user id $userId");
      await PrefsHelper.setString(AppConstants.userId,  userId);

      Get.toNamed(AppRoutes.verifyEmailScreen, parameters: {
        'email': "$email",
        'screenType': "signUp",
        "userId" : "$userId"
      });
      ToastMessageHelper.showToastMessage("Account create successful.\n \nNow you have a one time code your email");
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
  ///===============Verify Email================<>
  RxBool verfyLoading = false.obs;
  verfyEmail({String? otpCode, email, userId,  String screenType = ''}) async {
    verfyLoading(true);

    var body = screenType == "signUp" ?  {"userId": userId, "code": otpCode} : {"userId": userId, "code": otpCode} ;

    var response = await ApiClient.postData(
        ApiConstants.verifyEmailEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("==========bearer token save done : ${response.body['data']['token']}");
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);

      if (screenType == 'forgot') {
        Get.toNamed(AppRoutes.setNewPasswordScreen);
      }else if(screenType == "signUp"){
        Get.toNamed(AppRoutes.signInScreen);
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
  ///===============Log in================<>
  RxBool logInLoading = false.obs;
  handleLogIn(String email, String password, String fcmToken) async {
    ProfileController profileController = Get.find<ProfileController>();
    profileController.getProfileData();
    logInLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "email": email,
      "password": password,
      "fcmToken" : "$fcmToken"
    };
    var response = await ApiClient.postData(
        ApiConstants.signInEndPoint, jsonEncode(body),
        headers: headers);
    print("========================${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data'];

      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
      await PrefsHelper.setString(AppConstants.email, email);
      await PrefsHelper.setString(AppConstants.name, data['user']['name']);
      await PrefsHelper.setString(AppConstants.userId, data['user']['id']);
      await PrefsHelper.setBool(AppConstants.isLogged, true);

       Get.toNamed(AppRoutes.bottomNavBar);
            ToastMessageHelper.showToastMessage('Your are logged in');

      logInLoading(false);
    } else if(response.statusCode == 1){
      logInLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    }else{
      if (response.body["message"] == "Please verify your email") {
        Get.toNamed(AppRoutes.verifyEmailScreen,
            parameters: {'userId': "${response.body['data']["id"]}", "screenType" : "signUp"});
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

  handleForgot(String email, screenType) async {
    forgotLoading(true);
    var body = {"email": email};

    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('=================screen type $screenType');
      emailCtrl.clear();
      Get.toNamed(AppRoutes.verifyEmailScreen,
          parameters: {"screenType": "forgot", 'userId': response.body['data']['id']});
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
  setPassword(String password, type) async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    setPasswordLoading(true);
    var body = type == "forgot" ? {"newPassword": "$password"} : {"oldPassword": "body.oldPassword", "newPassword": "$password"};

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
  reSendOtp(String userId) async {
    resendLoading(true);
    // var body = {"email": email};
    var response = await ApiClient.getData(
        ApiConstants.resendOtpEndPoint("$userId"));

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
}
