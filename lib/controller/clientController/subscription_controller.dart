import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/models/clients/subscription_model.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';

class SubscriptionController extends GetxController {

  //============================> Get Subscription Plan <=============================
  RxList<SubscriptionPlanModel> subscriptionPlanList = <SubscriptionPlanModel>[].obs;
  var isLoading = false.obs;

  getSubscriptionPlanData() async {
    isLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getAllSubscriptionPlanEndPoint,
    );
    print("=============response : ${response.body}");
    if (response.statusCode == 200) {
      subscriptionPlanList.value = List<SubscriptionPlanModel>.from(response.body['data']['attributes'].map((x) => SubscriptionPlanModel.fromJson(x)));
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