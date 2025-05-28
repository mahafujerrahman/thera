
import 'dart:convert';
import 'dart:io';
import 'dart:math' as logger;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:logger/logger.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/clients/getInvoiceDataModel.dart';
import 'package:thera_track_app/models/profile/profile_model.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';

class InvoiceController extends GetxController {
  //====================>>>>> Add Inventory <<<<<========================
  TextEditingController institutionNameCRTL = TextEditingController();
  TextEditingController streetCRTL = TextEditingController();
  TextEditingController cityCRTL = TextEditingController();
  TextEditingController townCRTL = TextEditingController();
  TextEditingController zipCodeCRTL = TextEditingController();
  TextEditingController phoneCRTL = TextEditingController();
  TextEditingController emailCRTL = TextEditingController();
  TextEditingController websiteCRTL = TextEditingController();

  var showLoading = false.obs;

  Future<void> createInvoice({
    required File? image
    }) async {
    showLoading(true);
    List<MultipartBody> multipartBody = image == null ? [] : [
      MultipartBody("invoiceImage", image)
    ];

    Map<String, String> body = {
      "institutionName": institutionNameCRTL.text.trim(),
      "street": streetCRTL.text.trim(),
      "city": cityCRTL.text.trim(),
      "town": townCRTL.text.trim(),
      "zipCode": zipCodeCRTL.text.trim(),
      "phone": phoneCRTL.text.trim(),
      "emailAddress": emailCRTL.text.trim(),
      "website": websiteCRTL.text.trim(),
    };

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    var response = await ApiClient.postMultipartData(
      ApiConstants.createInvoiceEndPoint,
      body,
      multipartBody : multipartBody,
      headers: headers,

    );

    if (response.statusCode == 200) {
      showLoading(false);
      Get.snackbar('Success', 'Invoice Created');
   //   clearFields();
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar('Error!', 'One invoice already exist for this user.');
      showLoading(false);
    }
  }


//============================> Get Invoice Data <=============================
  Rx<GetInvoiceDataModel> invoiceInformationData = GetInvoiceDataModel().obs;
  var isLoading = false.obs;

  getInvoiceData() async {
    isLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getInvoiceDataEndPoint,
    );
    print("=============response : ${response.body}");
    if (response.statusCode == 200) {

      invoiceInformationData.value = GetInvoiceDataModel.fromJson(response.body['data']['attributes']);
      isLoading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }
  }
  //====================== Edit Invoice

  editInvoice({
    required String? invoiceID,
    required File? image,
    required String instituteName,
    required String street,
    required String city,
    required String town,
    required String zipCode,
    required String phone,
    required String emailAddress,
    required String website,
  }) async {
    List<MultipartBody> multipartBody = image == null ? [] : [
      MultipartBody("invoiceImage", image)
    ];

    Map<String, String> body = {
      "institutionName": instituteName,
      "street": street,
      "city":  city,
      "town":  town,
      "zipCode": zipCode,
      "phone": phone,
      "emailAddress": emailAddress,
      "website": website,
    };

    var response = await ApiClient.patchMultipartData(
      '${ApiConstants.updateInvoiceDataEndPoint}/$invoiceID',
      body,
      multipartBody: multipartBody,
    );

    var logger = Logger();
    logger.i('======>>${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading(false);
      invoiceInformationData.value = GetInvoiceDataModel.fromJson(response.body['data']['attributes']);
      invoiceInformationData.refresh();
      Get.offAllNamed(AppRoutes.homeScreen);
      Get.snackbar('Successfully', response.body['message']);
    } else {
      isLoading(false);
      Get.snackbar('Error', response.body['message']);
      ApiChecker.checkApi(response);
    }
  }
}