import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/models/clients/get_all_inventory_product.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_constants.dart';

class InventoryController extends GetxController {
  //====================>>>>> Add Inventory <<<<<========================
  TextEditingController productName = TextEditingController();
  TextEditingController pricePerOne = TextEditingController();
  TextEditingController quantity = TextEditingController();

  var addInventoryLoading = false.obs;

  Future<void> addInventoryMethod({
    required String productName,
    required int price,
    required int quantity,
  }) async {
    if (productName.isEmpty || price <= 0 || quantity <= 0) {
      Get.snackbar('Error', 'All fields are required and must be valid.');
      return;
    }

    addInventoryLoading(true);
    update();

    Map<String, dynamic> body = {
      "productName": productName,
      "pricePerOne": price,
      "buyQuantity": quantity,
    };

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    var response = await ApiClient.postData(
      ApiConstants.addInventoryEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var newProduct = GetAllInventoryModel.fromJson(response.body['data']);
      allInventoryList.add(newProduct);
      allInventoryList.refresh();
      Get.snackbar('Success', 'Inventory added successfully.');
      clearFields();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  // Method to clear input fields after successful submission
  void clearFields() {
    productName.clear();
    pricePerOne.clear();
    quantity.clear();
  }

  //============== All Inventory
  RxList<GetAllInventoryModel> allInventoryList = <GetAllInventoryModel>[].obs;

  getAllInventory() async {
    var response =
        await ApiClient.getData(ApiConstants.getAllInventoryEndPoint);
    print(
        "===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      allInventoryList.value = List.from(
          response.body['data'].map((x) => GetAllInventoryModel.fromJson(x)));

      allInventoryList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

//=================================================>>>>>> Delete Single Product <<<<<<=========================================================
  deleteSingelProduct({required String productID}) async {
    var response = await ApiClient.deleteData(
        '${ApiConstants.deleteSingelProductEndPoint}/${productID}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Successfully', 'Deleted Product');
      allInventoryList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
