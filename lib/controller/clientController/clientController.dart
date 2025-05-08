import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/clients/all_clients_model.dart';
import 'package:thera_track_app/models/clients/client_with_animal_model.dart';
import 'package:thera_track_app/models/clients/getAllAnimalUnderClientModel.dart';
import 'package:thera_track_app/models/clients/getClient_details_byID_model.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_constants.dart';

class ClientController extends GetxController {

//============= Add Client ==========================
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController zipCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController otherCtrl = TextEditingController();

  var addClientLoading = false.obs;

  addClient() async {
    addClientLoading(true);
    Map<String, dynamic> body = {
      'name': nameCtrl.text.trim(),
      "address": {
        "city": cityCtrl.text.trim(),
        "state": stateCtrl.text.trim(),
        "zip": zipCtrl.text.trim(),
      },
      'phoneNumber': phoneNumberCtrl.text.trim(),
      'email': emailCtrl.text.trim(),
      'other': otherCtrl.text.trim(),
    };

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    print("====> API Request Body: ${jsonEncode(body)}");

    var response = await ApiClient.postData(
      ApiConstants.createHumanClientEndPoint, headers: headers,
      jsonEncode(body),);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Successfully", "New Client Added!");
      Get.toNamed(AppRoutes.createNewChartStepOneScreen);
      addClientLoading(false);
      clearValues();
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar("Error", '${response.body['message']}');
      addClientLoading(false);
    }
  }

  void clearValues() {
    nameCtrl.clear();
    cityCtrl.clear();
    stateCtrl.clear();
    zipCtrl.clear();
    phoneNumberCtrl.clear();
    otherCtrl.clear();
    emailCtrl.clear();
    update();
  }

  //=========================>> All Client Info <<============================

  RxList<GetClientInfoModel> getClientInfoModel = <GetClientInfoModel>[].obs;
  var loading = false.obs;

  getAllClientInfo() async {
    loading(true);

    var response = await ApiClient.getData(
        "${ApiConstants.grtAllClientDataEndPoint}");
    if (response.statusCode == 200) {
      getClientInfoModel.value = List.from(response.body['data']['attributes'].map((x) => GetClientInfoModel.fromJson(x)));
      loading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }

  //=========================>> Client Animal <<============================

  RxList<String> animalList=<String>[].obs;

  clientAnimalList() async {
    loading(true);

    var response = await ApiClient.getData("${ApiConstants.clientAnimalEndPoint}");
    if (response.statusCode == 200) {
      var animals=response.body['data']['attributes'];
     for(var x in animals ){
        animalList.add(x);
      }
      Logger log=Logger();
      log.i("animal list is==================> ${animalList.length}");
      loading(false);
    }
    else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }
  //=========================>> Get Client with Animal <<============================

  RxList<GetClientWithAnimalModel> getClientWithAnimalModel = <GetClientWithAnimalModel>[].obs;
  var showLoading = false.obs;

  getClientWithAnimal(String animalName) async {
    showLoading(true);

    var response = await ApiClient.getData("${ApiConstants.clientWithAnimalEndPoint}/$animalName");
    if (response.statusCode == 200) {
      getClientWithAnimalModel.value = List.from(response.body['data']['attributes']['clientDetails'].map((x) => GetClientWithAnimalModel.fromJson(x)));
      showLoading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      showLoading(false);
      update();
    }
  }
  //=========================>> Get Client with Animal <<============================

  RxList<GetAnimalUnderOneClientModel> getAnimalUnderOneClientModel = <GetAnimalUnderOneClientModel>[].obs;

  getAnimalUnderOneClient(String clientID) async {
    showLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getAllAnimalUnderOneClientTreatmentEndPoint}/$clientID");
    if (response.statusCode == 200) {
      getAnimalUnderOneClientModel.value = List.from(response.body['data']['attributes'].map((x) => GetAnimalUnderOneClientModel.fromJson(x)));
      showLoading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      showLoading(false);
      update();
    }
  }
  // ======================= Client Details by ID ==========================
  
  Rx<GetClientInfoByIdModel> getClientInfoByIdModel = GetClientInfoByIdModel().obs;
  var clientInfoLoading = false.obs;
  
  clientDetailsByID(String carId) async {
    clientInfoLoading(true);
    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    var response = await ApiClient.getData("${ApiConstants.clientDetailsByIDEndPoint}/$carId",headers: headers);
    if (response.statusCode == 200) {
      getClientInfoByIdModel.value = GetClientInfoByIdModel.fromJson(response.body['data']['attributes']);
      clientInfoLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      clientInfoLoading(false);
      update();
    }
  }










}

