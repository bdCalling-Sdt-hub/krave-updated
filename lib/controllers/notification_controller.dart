import 'package:get/get.dart';
import 'package:krave/helpers/prefs_helper.dart';
import 'package:krave/services/api_constants.dart';
import 'package:krave/utils/app_constants.dart';

import '../models/notification_model.dart';
import '../services/api_client.dart';

class NotificationController extends GetxController{


  RxBool notificationLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  getNotifications() async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    notificationLoading(true);
    var response = await ApiClient.getData(ApiConstants.notification("$userId"));
    if (response.statusCode == 200) {
      notifications.value = List<NotificationModel>.from(response.body["data"]['notifications'].map((x)=> NotificationModel.fromJson(x)));
      notificationLoading(false);
    } else {
      notificationLoading(false);
    }
  }

}