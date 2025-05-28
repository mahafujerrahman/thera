import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/clients/getAll_walletModel.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_constants.dart';

class TravelController extends GetxController {
  final TextEditingController departureCRTL = TextEditingController();
  final TextEditingController destinationCRTL = TextEditingController();
  final TextEditingController distanceCRTL = TextEditingController();
  final TextEditingController foodCRTL = TextEditingController();
  final TextEditingController gasCRTL = TextEditingController();
  final TextEditingController otherCRTL = TextEditingController();

  var travelLoading = false.obs;

  Future<void> addTravelExpenses({
    required String departure,
    required String destination,
    required int? distance,
    required int? food,
    required int? gas,
    required int? other,
    required File receiptImages,
  }) async {

    travelLoading(true);
    update();
    List<MultipartBody> multipartBody = receiptImages == null ? [] : [MultipartBody("receipt_images", receiptImages)];
    Map<String, String> body = {
      "departure": departure,
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
        travelLoading(false);
        print('================>>> ${response.statusCode}');
        getAllTravelModel.refresh();
        Get.snackbar('Success', 'Travel Expenses added successfully.');
        clearFields();
        Get.toNamed(AppRoutes.homeScreen);
      } else {
        travelLoading(false);
        ApiChecker.checkApi(response);
    }
  }

  // Method to clear input fields after successful
  void clearFields() {
    departureCRTL.clear();
    destinationCRTL.clear();
    distanceCRTL.clear();
    foodCRTL.clear();
    gasCRTL.clear();
    otherCRTL.clear();
  }

  //============== Get All Wallet Model ============================================
  RxList<GetAllTravelModel> getAllTravelModel = <GetAllTravelModel>[].obs;

  getAllTravel() async {
    travelLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllTravelEndPoint);
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getAllTravelModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllTravelModel.fromJson(x)));
      getAllTravelModel.refresh();
      travelLoading(false);
    } else {
      ApiChecker.checkApi(response);
      travelLoading(false);
    }
  }

  //============== Get One Cost Details  ============================================
  RxBool isLoading=false.obs;
  Rx<GetAllTravelModel> getOnelWalletDetails = GetAllTravelModel().obs;

  getOneCostDetails(String travelID) async {
    isLoading.value = true;
    var response = await ApiClient.getData("${ApiConstants.getOneTravelExpensesEndPoint}/$travelID");
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getOnelWalletDetails.value = GetAllTravelModel.fromJson(response.body['data']['attributes']);
      getOnelWalletDetails.refresh();
      isLoading.value=false;
    } else {
      isLoading.value=false;
      ApiChecker.checkApi(response);
    }
  }


}