
import 'package:get/get.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/models/home_feed_model.dart';
import 'package:krave/models/home_profile_model.dart';
import 'package:krave/utils/app_constants.dart';

import '../helpers/api_checker.dart';
import '../models/congratulations_match_model.dart';
import '../models/restuarant_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class CongratulationsMatchController extends GetxController{


  RxBool congratulationLoading = false.obs;
  RxList<CongratulationsMatchModel> congratulationsUserData = <CongratulationsMatchModel>[].obs;
  getCongratulations({String? receiverId})async{
    var myId = await PrefsHelper.getString(AppConstants.userId);
    congratulationLoading(true);
    var response = await ApiClient.getData(ApiConstants.congratulationsEndPoint("$myId", "$receiverId"));
    if(response.statusCode == 200){
      congratulationsUserData.value = List<CongratulationsMatchModel>.from(response.body["data"]["profiles"].map((x)=> CongratulationsMatchModel.fromJson(x)));
      congratulationLoading(false);
    }else{
      congratulationLoading(false);
      ApiChecker.checkApi(response);
    }
  }





  ///===========================home profile details data======================///
  RxBool restaurantLoading = false.obs;
  RxList<RestaurantsModel> restaurantsData = <RestaurantsModel>[].obs;
  getRestaurants() async {
    restaurantLoading(true);
    var lat = await PrefsHelper.getString(AppConstants.lat);
    var log = await PrefsHelper.getString(AppConstants.log);
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer DsbvWyZVN-4OL-SimqtwJeUqG9Hsmh5GAtiPeI8gPMaBNha5HxSWfAnQ0HUyryBLrfMMdolxS2kzx_aqk8oavfv0xAXYeJd-LSJmA-H5Fa6CabSHyEzm7aPUQmYVZ3Yx'
    };
    var response = await ApiClient.getDataDemo("https://api.yelp.com/v3/businesses/search?term=resturant&latitude=35.263226&longitude=-116.726422", headers: header);
    // var response = await ApiClient.getData("https://api.yelp.com/v3/businesses/search?term=resturant&latitude=$lat&longitude=$log");

    print('--------------------------------------------${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      restaurantsData.value = List<RestaurantsModel>.from(response.body["businesses"].map((x)=> RestaurantsModel.fromJson(x)));
      restaurantLoading(false);
    } else{
      restaurantLoading(false);
    }
  }


}