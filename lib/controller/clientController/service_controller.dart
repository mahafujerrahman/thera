import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/controller/clientController/inventoryController.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/clients/treatMentModel.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/service/api_service_client.dart'
    show ApiServiceClient, MultipartBody2;

import '../../helpers/sql_helper.dart';

class ServiceController extends GetxController {
  ///Service Given Api
  ///================================ >> Add Animal To The Service << ================================
  final InventoryController inventoryController =
      Get.put(InventoryController());

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController addAnimal = TextEditingController();

  List<String> animals = ['Horse', 'Dog'];

  RxString selectedAnimal = ''.obs;

  var areaOfConcernList =
      ['Joints', 'Spine/Back', 'Paws', 'Muscles', 'Neck', 'Ears'].obs;

  //==================================>>> Inventory
  // Map to store quantity for each inventory item by its ID
  var itemQuantities = <String, RxInt>{}.obs;

  // Get quantity for a specific item
  RxInt getItemQuantity(String itemId) {
    if (!itemQuantities.containsKey(itemId)) {
      itemQuantities[itemId] = 0.obs;
    }
    return itemQuantities[itemId]!;
  }

  // Increment quantity for a specific item
  void incrementItemQuantity(String itemId) {
    getItemQuantity(itemId).value++;
  }

  // Decrement quantity for a specific item
  void decrementItemQuantity(String itemId) {
    if (getItemQuantity(itemId).value > 0) {
      getItemQuantity(itemId).value--;
    }
  }

  // Reset quantities (useful when clearing the cart)
  void resetQuantities() {
    itemQuantities.clear();
  }

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
  RxString apStartTime = ''.obs;
  RxString apEndTime = ''.obs;

  RxBool isPaid = false.obs;
  RxBool createServiceLoading = false.obs;

  var selectedAreaOfConcern = <String>[].obs;
  final TextEditingController descriptionTextController =
      TextEditingController();
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
    var clientId =
        await PrefsHelper.getString(AppConstants.createdServiceClientId);

    var files = <MultipartBody2>[];
    if (selectedImage != null) {
      files.add(MultipartBody2('Concern_images', selectedImage!));
    }

    var treat = [];
    for (var x in selectedList) {
      treat.add(x.treatmentTitle);
    }
    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $bearerToken'
    };

    // Prepare inventory items
    List<Map<String, String>> inventoryItems = [];

    for (var item in inventoryController.allInventoryList) {
      String itemId = item.id ?? '0';
      int quantity = getItemQuantity(itemId).value;

      inventoryItems.add(
          {'productName': item.productName!, 'quantity': quantity.toString()});
    }

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

      "ApDate": selectedAppointmentDay?.toString() ?? '',
      "ApStartTime": apStartTime.value,
      "ApEndTime": apEndTime.value,
      "reAllDay": isReminderAllDay.value.toString(),
      "reTwelveHourBefore": reTwelveHourBefore.value.toString(),
      "reOneDayBefore": reOneDayBefore.value.toString(),
      "reTwoDayBefore": reTwoDayBefore.value.toString(),
      "reOneWeekBefore": reOneWeekBefore.value.toString(),

      "selectedAnimal": selectedAnimal.value.toString(),

      //============>> Animal
      "name": name.text.trim(),
      "age": age.text.trim(),
      "breed": breed.text.trim(),
      "height": height.text.trim(),
      "gender": gender.text.trim(),
      "color": color.text.trim(),

      // Convert the inventory list to a JSON string
      "inventoryAcc": jsonEncode(inventoryItems),
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

  saveToLocal() async {
    var clientId =
        await PrefsHelper.getString(AppConstants.createdServiceClientId);

    var treat = [];
    for (var x in selectedList) {
      treat.add(x.treatmentTitle);
    }

    List<Map<String, String>> inventoryItems = [];
    for (var item in inventoryController.allInventoryList) {
      String itemId = item.id ?? '0';
      int quantity = getItemQuantity(itemId).value;
      inventoryItems.add(
          {'productName': item.productName!, 'quantity': quantity.toString()});
    }

    debugPrint("Saving to local image....tut..tut....tut....");

    String? localImagePath;

    try {
      // Save image to local storage if exists
      if (selectedImage != null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        await appDocDir.create(recursive: true);

        String filePath =
            '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

        File file = File(filePath);
        Uint8List imageBytes = await selectedImage!.readAsBytes();
        await file.writeAsBytes(imageBytes);

        localImagePath = filePath;
        print("Image saved to local path: $localImagePath");
      }

      // Prepare data for database including image path
      var body = {
        "clientId": clientId,
        "areaOfConcern": jsonEncode(selectedAreaOfConcern),
        "treatments": jsonEncode(treat),
        "finalCost": finalCost.value.toString(),
        "discount": discount.value.toString(),
        "description": descriptionTextController.text.trim(),
        "points": jsonEncode(pointList),
        "isPaid": isPaid.value.toString(),

        "ApDate": selectedAppointmentDay?.toString() ?? '',
        "ApStartTime": apStartTime.value,
        "ApEndTime": apEndTime.value,
        "reAllDay": isReminderAllDay.value.toString(),
        "reTwelveHourBefore": reTwelveHourBefore.value.toString(),
        "reOneDayBefore": reOneDayBefore.value.toString(),
        "reTwoDayBefore": reTwoDayBefore.value.toString(),
        "reOneWeekBefore": reOneWeekBefore.value.toString(),

        "selectedAnimal": selectedAnimal.value.toString(),

        //============>> Animal
        "name": name.text.trim(),
        "age": age.text.trim(),
        "breed": breed.text.trim(),
        "height": height.text.trim(),
        "gender": gender.text.trim(),
        "color": color.text.trim(),

        // Convert the inventory list to a JSON string
        "inventoryAcc": jsonEncode(inventoryItems),

        // Add local image path to the data
        "localImagePath": localImagePath ?? '',
      };

      DatabaseHelper dbHelper = DatabaseHelper(dbName: "munnaBadnam.db");
      await dbHelper.insert('local_data', body);

      print("Data saved to local database successfully");
    } catch (e) {
      print("Error saving data: $e");
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
    resetQuantities();

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
