import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/models/subscription/get_one_subscription_model.dart';
import 'package:thera_track_app/models/subscription/subscription_model.dart';
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
      ApiConstants.getSubscriptionPlanEndPoint,
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


  //==========================>>>> Get one subscription Details <<<<===========================


  RxBool showLoading=false.obs;
  Rx<GetOneSubscriptionModel> getOneSubscriptionList = GetOneSubscriptionModel().obs;
  getOneSubscriptionDetails({required String subscriptionID}) async {
    showLoading.value=true;
    var response = await ApiClient.getData("${ApiConstants.getSubscriptionPlanEndPoint}/$subscriptionID");
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getOneSubscriptionList.value = GetOneSubscriptionModel.fromJson(response.body['data']['attributes']);
      showLoading.value=false;
    } else {
      showLoading.value=false;
      ApiChecker.checkApi(response);
    }
  }

}