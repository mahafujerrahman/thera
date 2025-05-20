import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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

}