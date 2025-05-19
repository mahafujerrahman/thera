import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/clients/GetAllInventoryProduct.dart';
import 'package:thera_track_app/models/clients/treatMentModel.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/service/api_service_client.dart'
    show ApiServiceClient, MultipartBody2;

class ServiceController extends GetxController {
  ///Service Given Api
  ///================================ >> Add Animal To The Service << ================================


  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController addAnimal = TextEditingController();



  List<String> animals = ['Horse', 'Dog'];

  RxString selectedAnimal = ''.obs;

  var areaOfConcernList = ['Joints', 'Spine/Back', 'Paws', 'Muscles', 'Neck', 'Ears'].obs;
 //==================================>>> Inventory
  RxInt getQuantity = 0.obs;
  void incrementItemQuantity() {
    getQuantity.value++;
  }

  void decrementItemQuantity() {
    if (getQuantity.value > 0) {
      getQuantity.value--;
    }
  }

  var inventoryList = <GetAllInventoryModel>[].obs;




  //========================= Treatment
  var selectedList = <GetAllTreatMentModel>[].obs;

  var fullCost = 0.0.obs;
  var discount = 0.0.obs;
  var finalCost = 0.0.obs;






  TextEditingController addAreaOfConcern = TextEditingController();
  //for Human Section
  DateTime? selectedAppointmentDay;
  RxBool isReminderAllDay = false.obs;

  RxBool reTwelveHourBefore = false.obs;
  RxBool reOneDayBefore = false.obs;
  RxBool reTwoDayBefore = false.obs;
  RxBool reOneWeekBefore = false.obs;
  RxBool isPaid = false.obs;
  RxBool createServiceLoading = false.obs;

  RxString apStartTime = ''.obs;
  RxString apEndTime = ''.obs;

  var selectedAreaOfConcern = <String>[].obs;
  final TextEditingController descriptionTextController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  List<String> pointList = [];


  void calculateFinalCost() {
    finalCost.value = fullCost.value - discount.value;
  }

  void updateDiscount(String value) {
    discount.value = double.tryParse(value) ?? 0.0;
    calculateFinalCost();
  }

  final TextEditingController pointController = TextEditingController();

  File? selectedImage;

  createServiceClient() async {
    createServiceLoading(true);
    var clientId = await PrefsHelper.getString(AppConstants.createdServiceClientId);

    var files = <MultipartBody2>[
      MultipartBody2('Concern_images', selectedImage!)
    ];

    var treat = [];
    for (var x in selectedList) {
      treat.add(x.treatmentTitle);
    }
    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $bearerToken'
    };

    // Convert all values to strings for the multipart request
    var body = {
      "clientId": clientId,
      "areaOfConcern": jsonEncode(selectedAreaOfConcern),
      "treatments": jsonEncode(treat),
      "finalCost": finalCost.value.toString(),
      "discount": discount.value.toString(),
      "description": descriptionTextController.text.trim(),
      "points": jsonEncode(pointList),
      "isPaid": isPaid.value.toString(),
      "ApDate": selectedAppointmentDay.toString(),
      "ApStartTime": apStartTime.value,
      "ApEndTime": apEndTime.value,
      "reAllDay": isReminderAllDay.value.toString(),
      "reTwelveHourBefore": reTwelveHourBefore.value.toString(),
      "reOneDayBefore": reOneDayBefore.value.toString(),
      "reTwoDayBefore": reTwoDayBefore.value.toString(),
      "reOneWeekBefore": reOneWeekBefore.value.toString(),

      //animal


    };

    var response = await ApiServiceClient().postData(
        ApiConstants.createServiceEndPoint, body,
        files: files, headers: headers);
    if (response.statusCode == 200) {
      resetAllFields();
      Get.toNamed(AppRoutes.homeScreen);
      createServiceLoading(false);
      Get.snackbar('Success', 'Service created successfully');
      // Additional success handling...
    } else {
      createServiceLoading(false);
      ApiChecker.checkApi(response);
      Get.snackbar('Error!', 'Something Went Wrong');
    }
  }


  void resetAllFields() {
    addAnimal.clear();
    name.clear();
    age.clear();
    breed.clear();
    gender.clear();
    height.clear();
    color.clear();
    addAreaOfConcern.clear();
    descriptionTextController.clear();
    discountController.clear();
    pointController.clear();

    selectedAnimal.value = '';
    selectedAreaOfConcern.clear();
    selectedList.clear();
    pointList.clear();

    fullCost.value = 0.0;
    discount.value = 0.0;
    finalCost.value = 0.0;

    selectedAppointmentDay = null;
    isReminderAllDay.value = false;
    reTwelveHourBefore.value = false;
    reOneDayBefore.value = false;
    reTwoDayBefore.value = false;
    reOneWeekBefore.value = false;
    isPaid.value = false;

    apStartTime.value = '';
    apEndTime.value = '';

    selectedImage = null;
  }

}
