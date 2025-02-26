
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/clients/getAll_walletModel.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_constants.dart';

class WalletController extends GetxController {
  final TextEditingController departureController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController foodController = TextEditingController();
  final TextEditingController gasController = TextEditingController();
  final TextEditingController otherController = TextEditingController();

  var walletLoading = false.obs;

  Future<void> addTravelExpenses({
    required int? departure,
    required String destination,
    required int? distance,
    required int? food,
    required int? gas,
    required int? other,
    required File receiptImages,
  }) async {
    if (departure.isNull ||
        destination.isEmpty ||
        distance.isNull ||
        food.isNull ||
        gas.isNull ||
        gas.isNull ||
        other.isNull
    ) {
      Get.snackbar('Error', 'All fields are required and must be valid.');
      return;
    }

    walletLoading(true);
    update();
    List<MultipartBody> multipartBody = receiptImages == null ? [] : [MultipartBody("receipt_images", receiptImages)];
    Map<String, String> body = {
      "departure": departure.toString(),
      "destination": destination,
      "distance": distance.toString(),
      "food": food.toString(),
      "gas": gas.toString(),
      "other": other.toString(),
    };

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };


      var response = await ApiClient.postMultipartData(
        ApiConstants.addTravelCostEndPoint,
        body,
        multipartBody: multipartBody,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('================>>> ${response.statusCode}');
       /* var newOne = GetAllWalletModel.fromJson(response.body['data']['attributes']);
        getAllWalletModel.add(newOne);*/
        getAllWalletModel.refresh();
        Get.snackbar('Success', 'Travel Expenses added successfully.');
        clearFields();
        Get.toNamed(AppRoutes.homeScreen);
      } else {
        ApiChecker.checkApi(response);
    }
  }

  // Method to clear input fields after successful submission
  void clearFields() {
    departureController.clear();
    destinationController.clear();
    distanceController.clear();
    foodController.clear();
    gasController.clear();
    otherController.clear();
  }

  //============== Get All Wallet Model ============================================
  RxList<GetAllWalletModel> getAllWalletModel = <GetAllWalletModel>[].obs;

  getAllWallet() async {
    var response = await ApiClient.getData(ApiConstants.getAllWalletEndPoint);
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getAllWalletModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllWalletModel.fromJson(x)));
      getAllWalletModel.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //============== Get One Cost Details  ============================================
  RxBool isLoading=false.obs;
  Rx<GetAllWalletModel> getOnelWalletDetails = GetAllWalletModel().obs;
  getOneCostDetails(String travelID) async {
    isLoading.value=true;
    var response = await ApiClient.getData("${ApiConstants.getOneTravelExpensesEndPoint}/$travelID");
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getOnelWalletDetails.value = GetAllWalletModel.fromJson(response.body['data']['attributes']);
      getOnelWalletDetails.refresh();
      isLoading.value=false;
    } else {
      isLoading.value=false;
      ApiChecker.checkApi(response);
    }
  }


}