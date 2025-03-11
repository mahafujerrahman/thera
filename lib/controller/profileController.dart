import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/clients/paid_and_unpaid_treatment_service_model.dart';
import 'package:thera_track_app/models/clients/treatMentModel.dart';
import 'package:thera_track_app/models/profile/profile_model.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_constants.dart';

class ProfileController extends GetxController  implements GetxService{

//============================> Get Profile Data <=============================

  Rx<ProfileInformationModel> profileInformationModel = ProfileInformationModel().obs;
  var isLoading = false.obs;

  getProfileData() async {
    isLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getProfileDataEndPoint,
    );
    print("=============response : ${response.body}");
    if (response.statusCode == 200) {
      profileInformationModel.value = ProfileInformationModel.fromJson(response.body['data']['attributes']);
      isLoading(false);
      update();
    }
    else{
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }

  }

  ///======================edit/update profile============================>

  editProfile({
    required File? image,
    required String fullName,
    required city ,
    required postCode,
    required country,
    required phoneNumber,
  }) async {
    List<MultipartBody> multipartBody = image == null ? [] : [
      MultipartBody("profileImage", image)
    ];

    Map<String, String> body = {
      "fullName": fullName,
      "city": city,
      "postCode": postCode,
      "country": country,
      "phoneNumber": phoneNumber,
    };

    var response = await ApiClient.patchMultipartData(
      ApiConstants.editProfileEndPoint,
      body,
      multipartBody: multipartBody,
    );

    print("===========response body : ${response.body} \nand status code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      profileInformationModel.value = ProfileInformationModel.fromJson(response.body['data']['attributes']);
      profileInformationModel.refresh();
      Get.offAllNamed(AppRoutes.homeScreen);
      Get.snackbar('Successfully', 'Profile Updated');
    } else {
      ApiChecker.checkApi(response);
    }
  }
//===============================>>>>> Add Treatment <<<<<=================================
  TextEditingController treatmentName = TextEditingController();
  TextEditingController treatmentPrice = TextEditingController();
  var addTreatmentLoading = false.obs;

  addTreatmentMethod({required String treatmentTitle , required String price}) async {
    addTreatmentLoading(true);
    // var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);

    double? priceValue = double.tryParse(price);
    if (priceValue == null) {
      Get.snackbar('Error', 'Invalid price format. Please enter a valid number.');
      addTreatmentLoading(false);
      update();
      return;
    }

    Map<String, dynamic> body = {
      "treatmentTitle": treatmentTitle,
      "price": double.tryParse(price),
    };

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    var response = await ApiClient.postData(
        ApiConstants.createTreatmentEndPoint, jsonEncode(body), headers: headers
    );

    if (response.statusCode == 200) {
      var newTreatment = GetAllTreatMentModel.fromJson(response.body['data']['attributes']);
      getAllTreatMentList.add(newTreatment);
      getAllTreatMentList.refresh();

      Get.snackbar('Done','Added Successfully');
      treatmentName.clear();
      treatmentPrice.clear();

      addTreatmentLoading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      addTreatmentLoading(false);
      update();
    }
  }
//============== All treatment
  RxList<GetAllTreatMentModel> getAllTreatMentList = <GetAllTreatMentModel>[].obs;


  getAllTreatment() async {
    isLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllTreatmentEndPoint);
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getAllTreatMentList.value = List.from(response.body['data']['attributes'].map((x) => GetAllTreatMentModel.fromJson(x)));
      getAllTreatMentList.refresh();
      isLoading(false);
    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
    }
  }


//=================================================>>>>>> Delete Singel Treatment <<<<<<=========================================================
  deleteSingelTreatment({required String treatmentID}) async {
    var response = await ApiClient.deleteData('${ApiConstants.deleteSingelTreatmentEndPoint}/${treatmentID}');
    if (response.statusCode == 200 || response.statusCode == 201) {
     Get.snackbar('Successfully', 'Deleted Treatment');
     getAllTreatMentList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

//===============================>>>>> Advance Setting <<<<<=================================
  updateSelection({required String isHumanTrue}) async {
    String isHuman = (isHumanTrue == "Human") ? "true" : "false";

    Map<String, dynamic> body = {
      "isHumanTrue": isHuman,
    };
    var response = await ApiClient.patchData(ApiConstants.updateAdvanceSettingEndPoint, body: body);
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      profileInformationModel.value = ProfileInformationModel.fromJson(response.body['data']['attributes']);
      profileInformationModel.refresh();
      Get.back();
      Get.snackbar('Successfully', 'Setting Updated');
    } else {
      ApiChecker.checkApi(response);
    }
  }


  //=========================>> Get All Paid Treatment <<============================

  RxList<GetAllTreatmentModels> getAllPaidTreatmentModels = <GetAllTreatmentModels>[].obs;

  Rx<num> paidTotalFinalCost = 0.obs;
  var loading = false.obs;
  getAllPaidTreatmentDetails() async {
    loading(true);

    var response = await ApiClient.getData("${ApiConstants.getAllPaidTreatmentEndPoint}");
    if (response.statusCode == 200) {
      paidTotalFinalCost.value = response.body['data']['attributes']['totalFinalCost'];

      getAllPaidTreatmentModels.value = List<GetAllTreatmentModels>.from(response.body['data']['attributes']['result'].map((x) => GetAllTreatmentModels.fromJson(x)));
      loading(false);
      update();
      debugPrint('==============>> Paid Total Final Cost :  ${paidTotalFinalCost.value}');
    }
    else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }

  //=========================>> Get All unPaid Treatment <<============================

  RxList<GetAllTreatmentModels> getAllUnPaidTreatmentModels = <GetAllTreatmentModels>[].obs;

  Rx<num> unpaidTotalFinalCost = 0.obs;
  getAllUnPaidTreatmentDetail() async {
    loading(true);
    var response = await ApiClient.getData("${ApiConstants.getAllUnPaidTreatmentEndPoint}");
    if (response.statusCode == 200) {
      unpaidTotalFinalCost.value = response.body['data']['attributes']['totalFinalCost'];

      getAllUnPaidTreatmentModels.value = List<GetAllTreatmentModels>.from(response.body['data']['attributes']['result'].map((x) => GetAllTreatmentModels.fromJson(x)));
      loading(false);
      update();
      debugPrint('==============>> Unpaid Total Final Cost : ${unpaidTotalFinalCost.value}');
    }
    else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }
}
