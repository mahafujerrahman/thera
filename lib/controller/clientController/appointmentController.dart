import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:thera_track_app/models/clients/all_appointment_model.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';

class AppointmentController extends GetxController {

  //=========================>> Get All Appointment  <<============================

  RxList<GetAllAppointmentModel> getAllAppointmentModel = <GetAllAppointmentModel>[].obs;
  var loading = false.obs;

  getAllAppointment() async {
    loading(true);

    var response = await ApiClient.getData("${ApiConstants.getAllAppointmentEndPoint}");
    if (response.statusCode == 200) {
      getAllAppointmentModel.value = List.from(response.body['data'].map((x) => GetAllAppointmentModel.fromJson(x)));
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
  Rx<GetAllAppointmentModel> getOneAppointmentById = GetAllAppointmentModel().obs;
  getOneAppointmentByIdDetails(String appointmentID) async {
    isLoading.value=true;
    var response = await ApiClient.getData("${ApiConstants.getOneAppointmentDetailsByIDEndPoint}/$appointmentID");
    print("===========>> Response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      getOneAppointmentById.value = GetAllAppointmentModel.fromJson(response.body['data']);
      getOneAppointmentById.refresh();
      isLoading.value=false;
    } else {
      isLoading.value=false;
      ApiChecker.checkApi(response);
    }
  }

}