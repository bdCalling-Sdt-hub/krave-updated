import 'package:get/get.dart';

import '../constant/app_constant.dart';
import '../helpers/api_checker.dart';
import '../helpers/prefs_helper.dart';
import '../models/match_user_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../utils/app_constants.dart';

class MatchController extends GetxController {
  var favoriteMatches = <Map<String, String>>[].obs; // List to hold favorite matches

  // Function to add a match to favorites
  void addToFavorites(Map<String, String> match) {
    if (!favoriteMatches.contains(match)) {
      favoriteMatches.add(match);
    }
  }


  RxBool matchLoading = false.obs;
  RxList<MatchUserModel> matchUsers = <MatchUserModel>[].obs;
  getMatchUsers()async{
    var id = await PrefsHelper.getString(AppConstants.userId);
    matchLoading(true);
    var response = await ApiClient.getData(ApiConstants.likeMatchGet("$id"));
    if(response.statusCode == 200){
      matchUsers.value = List<MatchUserModel>.from(response.body["data"]['matches'].map((x)=> MatchUserModel.fromJson(x)));
      matchLoading(false);
    }else{
      matchLoading(false);
      ApiChecker.checkApi(response);
    }
  }


}
