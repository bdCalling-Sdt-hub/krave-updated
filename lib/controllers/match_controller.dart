import 'package:get/get.dart';

class MatchController extends GetxController {
  var favoriteMatches = <Map<String, String>>[].obs; // List to hold favorite matches

  // Function to add a match to favorites
  void addToFavorites(Map<String, String> match) {
    if (!favoriteMatches.contains(match)) {
      favoriteMatches.add(match);
    }
  }


  // RxBool feedLoading = false.obs;
  // RxList<HomeFeedModel> feeds = <HomeFeedModel>[].obs;
  // getActivities()async{
  //   var id = await PrefsHelper.getString(AppConstants.userId);
  //   feedLoading(true);
  //   var response = await ApiClient.getData(ApiConstants.homeFeed("$id"));
  //   if(response.statusCode == 200){
  //     feeds.value = List<HomeFeedModel>.from(response.body["data"]['users'].map((x)=> HomeFeedModel.fromJson(x)));
  //     feedLoading(false);
  //   }else{
  //     feedLoading(false);
  //     ApiChecker.checkApi(response);
  //   }
  // }


}
