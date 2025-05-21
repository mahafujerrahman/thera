class ApiConstants {
  static const String baseUrl = "http://10.0.80.71:5000/api/v1";
  static const String imageBaseUrl = "http://10.0.80.71:5000";

/*  http://192.168.10.163:8081/api/v1
  http://192.168.10.163:8081/api/v1*/

  static String googleBaseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String googleApiKey="AIzaSyAszXC1be8aJ37eHuNcBm_-O1clWkPUwV4";

  //============================>> User Auth <<=================================
  static const String signUpEndPoint = "/auth/register";
  static const String signInEndPoint = "/auth/login";
  static const String otpVerifyEndPoint = "/auth/verify-email";
  static const String forgotPasswordEndPoint = "/auth/forgot-password";
  static const String resetPasswordEndPoint = "/auth/reset-password";
  static const String resendOTPEndPoint = "/auth/resend-otp";
  static const String geNotificationEndPoint = "/notifications/get-all-notifications";

  //ProfileInfo
  static const String getProfileDataEndPoint = "/user/profile";
  static const String editProfileEndPoint = "/user/profile";
  static const String updateAdvanceSettingEndPoint = "/user/change-user-status";
  static const String updateClientProfileEndPoint = "/client/update-client";
  static const String updateClientAnimalEndPoint = "/patient/update-service-for-contract";


  //============================>> Create Clients <<=================================
  static const String createHumanClientEndPoint = "/client/create-client";
  static const String grtAllClientDataEndPoint = "/client/read-client";
  static const String clientAnimalEndPoint = "/client/get-unique-animals";
  static const String clientWithAnimalEndPoint = "/client/get-clients-with-animal";
  static const String clientDetailsByIDEndPoint = "/client/get-one-client";
  static const String addInventoryEndPoint = "/inventory/create-product";
  static const String getAllInventoryEndPoint = "/inventory/get-all-product";
  static const String deleteSingelProductEndPoint = "/inventory/delete-product";

  static const String createTreatmentEndPoint = "/treatment/create-treatment";
  static const String getAllTreatmentEndPoint = "/treatment/get-all-treatment";
  static const String deleteSingelTreatmentEndPoint = "/treatment/delete-treatment";
  static const String getAllAnimalUnderOneClientEndPoint = "/patient/get-one-client-animal";
  static const String getAllWalletEndPoint = "/travel/get-all-travel-expenses";
  static const String addTravelCostEndPoint = "/travel/create-travel-expenses";
  static const String getOneTravelExpensesEndPoint = "/travel/get-one-travel-expenses";
  static const String createServiceEndPoint = "/patient/create-service";
  static const String getAnimalNameEndPoint = "/client/get-animal";


//============================>> Chart Archive  <<=================================
  static const String getAllServiceEndPoint = "/patient/get-all-service";
  static const String getAllAppointmentEndPoint = "/patient/get-all-appointment";

  static const String getAllPaidTreatmentEndPoint = "/patient/paid-treatment-service";
  static const String getAllUnPaidTreatmentEndPoint = "/patient/unpaid-treatment-service";
  static const String getOneServiceDetailsByIDEndPoint = "/patient/get-one-service";
  static const String getOneAppointmentDetailsByIDEndPoint = "/patient/get-one-service";
  static const String sendFeedBackEndPoint = "/send/feedback";


}
