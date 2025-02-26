import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/models/chartArchive/getAll_chart_archive_model.dart';
import 'package:thera_track_app/models/chartArchive/service_detailsByID_model.dart';
import 'package:thera_track_app/models/clients/paid_and_unpaid_treatment_service_model.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';

class ChartArchiveController extends GetxController {

  //=========================>> Get All Chart Archive <<============================

  RxList<GetAllChartArchiveModel> getAllChartArchiveModel = <GetAllChartArchiveModel>[].obs;
  var loading = false.obs;

  getAllChartArchive() async {
    loading(true);

    var response = await ApiClient.getData("${ApiConstants.getAllServiceEndPoint}");
    if (response.statusCode == 200) {
      getAllChartArchiveModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllChartArchiveModel.fromJson(x)));
      loading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }

  //============== Get One Service Details by ID ============================================
  RxBool isLoading=false.obs;
  Rx<GetServiceDetailByIdModels> getServiceDetailByIdModels = GetServiceDetailByIdModels().obs;
  getServiceDetailsByIdDetails(String serviceID) async {
    isLoading.value=true;
    var response = await ApiClient.getData("${ApiConstants.getOneServiceDetailsByIDEndPoint}/$serviceID");
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getServiceDetailByIdModels.value = GetServiceDetailByIdModels.fromJson(response.body['data']['attributes']);
      getServiceDetailByIdModels.refresh();
      isLoading.value=false;
    } else {
      isLoading.value=false;
      ApiChecker.checkApi(response);
    }
  }


}