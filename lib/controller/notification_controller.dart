import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/models/notification_model.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';

class NotificationController extends GetxController  implements GetxService {

  //============================> Get Notification All <=============================


  RxList<GetNotificationModel> getNotificationModel = <GetNotificationModel>[].obs;
  var isLoading = false.obs;

  getNotificationData() async {
    isLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.geNotificationEndPoint,
    );
    print("=============response : ${response.body}");
    if (response.statusCode == 200) {
      getNotificationModel.value = List<GetNotificationModel>.from(response.body['data']['attributes'].map((x) => GetNotificationModel.fromJson(x)));
      isLoading(false);
      update();
    }
    else{
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }

  }
}