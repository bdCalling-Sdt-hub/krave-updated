import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController implements GetxService {
  String title = "Home Screen";

  // Observable for current index of the carousel
  var currentIndex = 0.obs;

  // Method to update the index
  void updateIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    debugPrint("On Init  $title");
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("On onReady  $title");
    super.onReady();
  }
}
