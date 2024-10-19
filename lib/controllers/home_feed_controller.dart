import 'package:get/get.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/models/home_feed_model.dart';
import 'package:krave/utils/app_constants.dart';

import '../helpers/api_checker.dart';
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

}