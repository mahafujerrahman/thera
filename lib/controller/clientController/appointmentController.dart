import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/models/appointment/get_all_appoinment_model.dart';
import 'package:thera_track_app/models/appointment/get_one_appointment_details.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';

class AppointmentController extends GetxController {

  //=========================>> Get All Appointment  <<============================

  RxList<GetAllAppointment> getAllAppointmentModel = <GetAllAppointment>[].obs;
  var loading = false.obs;

  getAllAppointment() async {
    loading(true);

    var response = await ApiClient.getData("${ApiConstants.getAllAppointmentEndPoint}");
    if (response.statusCode == 200) {
      getAllAppointmentModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllAppointment.fromJson(x)));
      loading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }


  //====================>> Get One Appointment Details by ID <<===========================================

  RxBool isLoading=false.obs;
  Rx<GetOneAppoinmentDetailsModel> getOneAppoinmentDetailsModel = GetOneAppoinmentDetailsModel().obs;
  getOneAppointmentByIdDetails(String appointmentID) async {
    isLoading.value=true;
    var response = await ApiClient.getData("${ApiConstants.getOneAppointmentDetailsByIDEndPoint}/$appointmentID");
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getOneAppoinmentDetailsModel.value = GetOneAppoinmentDetailsModel.fromJson(response.body['data']['attributes']);
      getOneAppoinmentDetailsModel.refresh();
      isLoading.value=false;
    } else {
      isLoading.value=false;
      ApiChecker.checkApi(response);
    }
  }

  //=================== Appointment reschedule ==============================

  DateTime? selectedAppointmentDay;
  RxBool isReminderAllDay = false.obs;
  RxBool reTwelveHourBefore = false.obs;
  RxBool reOneDayBefore = false.obs;
  RxBool reTwoDayBefore = false.obs;
  RxBool reOneWeekBefore = false.obs;
  RxString apStartTime = ''.obs;
  RxString apEndTime = ''.obs;


  Future<void>  appointmentReschedule({
    required String serviceID,

  }) async {
    loading(true);

    try {
      final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      final headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      };

      final body = {
        "ApDate": selectedAppointmentDay?.toString() ?? '',
        "ApStartTime": apStartTime.value,
        "ApEndTime": apEndTime.value,
        "reAllDay": isReminderAllDay.value.toString(),
        "reTwelveHourBefore": reTwelveHourBefore.value.toString(),
        "reOneDayBefore": reOneDayBefore.value.toString(),
        "reTwoDayBefore": reTwoDayBefore.value.toString(),
        "reOneWeekBefore": reOneWeekBefore.value.toString(),

      };

      final response = await ApiClient.patchData(
        '${ApiConstants.appointmentResechduleEndPoint}/$serviceID',
        body: jsonEncode(body),
        headers: headers,
      );

      debugPrint("Response body: ${response.body} \nStatus code: ${response.statusCode}");
      debugPrint("Full response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.toNamed(AppRoutes.appointmentScreen);
        Get.snackbar('Success', response.body['message'] ?? 'Appointment Rescheduled successfully');
      } else {
        Get.snackbar('Error', response.body['message'] ?? 'Appointment Rescheduled');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
    } finally {
      loading(false);
    }
  }

}