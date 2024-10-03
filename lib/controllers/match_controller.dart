import 'package:get/get.dart';

class MatchController extends GetxController {
  var favoriteMatches = <Map<String, String>>[].obs; // List to hold favorite matches

  // Function to add a match to favorites
  void addToFavorites(Map<String, String> match) {
    if (!favoriteMatches.contains(match)) {
      favoriteMatches.add(match);
    }
  }
}
