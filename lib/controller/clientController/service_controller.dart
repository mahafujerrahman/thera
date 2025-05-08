import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ServiceController extends GetxController {

  ///Service Given Api
  ///================================ >> Add Animal To The Service << ================================

  TextEditingController addAnimal = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController addController = TextEditingController();

  List<String> animals = ['Horse', 'Dog'];

  RxString selectedAnimal = ''.obs;

  var areaOfConcernList = ['Joints', 'Spine/Back','Paws','Muscles','Neck','Ears'].obs;
  var selectedAreaOfConcern = <String>[].obs;
  final TextEditingController descriptionTextController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  List<String> pointList = [];

  var fullCost = 0.0.obs;
  var discount = 0.0.obs;
  var finalCost = 0.0.obs;

  void calculateFinalCost() {
    finalCost.value = fullCost.value - discount.value;
  }

  void updateDiscount(String value) {
    discount.value = double.tryParse(value) ?? 0.0;
    calculateFinalCost();
  }

  final TextEditingController pointController = TextEditingController();

  File? selectedImage;




  createServiceClient(){

  }

}