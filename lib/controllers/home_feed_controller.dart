import 'dart:convert';

import 'package:get/get.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/helpers/route.dart';
import 'package:krave/models/home_feed_model.dart';
import 'package:krave/models/home_profile_model.dart';
import 'package:krave/utils/app_constants.dart';

import '../helpers/api_checker.dart';
import '../helpers/toast.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class HomeFeedController extends GetxController{


  RxBool feedLoading = false.obs;
  RxList<HomeFeedModel> feeds = <HomeFeedModel>[].obs;
  getActivities()async{
    var id = await PrefsHelper.getString(AppConstants.userId);
    feedLoading(true);
    var response = await ApiClient.getData(ApiConstants.homeFeed("$id"));
    if(response.statusCode == 200){
      feeds.value = List<HomeFeedModel>.from(response.body["data"]['users'].map((x)=> HomeFeedModel.fromJson(x)));
      feedLoading(false);
    }else{
      feedLoading(false);
      ApiChecker.checkApi(response);
    }
  }


  ///===================like==============>
  RxBool likeLoading = false.obs;
  like({String? id, name}) async {
    likeLoading(true);
    var userId = await PrefsHelper.getString(AppConstants.userId);
    var body =  {
      "userId_1": "$userId",
      "userId_2": "$id"
    };

    var response = await ApiClient.postData(ApiConstants.likeMatch, jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      ///*******************when match two person go to the match screen=====================///
      if(response.body["message"]== "Congratulations, it's a match!"){
        Get.toNamed(AppRoutes.matchScreen, arguments: {
          "receiverId" : "${id}",
          "name" : "$name",
          "screenType" : "message"
        });
      }
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      likeLoading(false);
    } else if(response.statusCode == 1){
      likeLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      likeLoading(false);
    }
  }




///===========================home profile details data======================///
  RxBool profileLoading = false.obs;
  Rx<HomeProfileModel> profileData = HomeProfileModel().obs;
  getProfileData(String userId) async {
    profileLoading(true);
    var response = await ApiClient.getData(ApiConstants.profileEndPoint("$userId"));

    print('--------------------------------------------${response.body}');
    if (response.statusCode == 200) {
      var responseData = response.body;
      profileData.value = HomeProfileModel.fromJson(responseData['data']);
      profileLoading(false);
    } else if (response.statusCode == 404) {
      profileLoading(false);
    }
  }


}