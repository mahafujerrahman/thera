import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/utils/app_constants.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import '../service/api_constants.dart';

class AuthController extends GetxController {

  ///<=============================== Sign Up Method ===========================>
  final TextEditingController userNameCTRL = TextEditingController();
  final TextEditingController signUpEmailCtrl = TextEditingController();
  final TextEditingController phoneNumberCTRL = TextEditingController();
  final TextEditingController passwordCTRL = TextEditingController();
  final TextEditingController confirmPasswordCTRL = TextEditingController();

  var signUpLoading = false.obs;

  String selectedCountryCodes = '+880';
  String role = 'admin';

  signUpMethod() async {
    signUpLoading(true);
    // var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);

    String phoneNumber = phoneNumberCTRL.text.trim();
    String countryCode = selectedCountryCodes;
    var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);

    Map<String, dynamic> body = {
      "firstName": userNameCTRL.text.trim(),
      "email": signUpEmailCtrl.text.trim(),
      "phoneNumber": countryCode + phoneNumber,
      "password": passwordCTRL.text.trim(),
      "ConfirmPassword": confirmPasswordCTRL.text.trim(),
      "role": role,
      "fcmToken": fcmToken,
    };

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var response = await ApiClient.postData(ApiConstants.signUpEndPoint, jsonEncode(body), headers: headers
    );

    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.verifyScreen, parameters: {
        "email": signUpEmailCtrl.text.trim(),
        "screenType": "signupScreen"},
      );
      print('My signup token : $fcmToken');
      signUpLoading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      signUpLoading(false);
      update();
    }
  }

  ///===========================>> Sign In <<===============================

  final TextEditingController signInEmailCtrl = TextEditingController();
  final TextEditingController signInPasswordCtrl = TextEditingController();

  RxBool signInLoading = false.obs;

  signInMethod() async {
    try {
      signInLoading.value = true;
      print('======== 1 : ${signInLoading.value}');
      var headers = {
        'Content-Type': 'application/json'
      };

      Map<String, dynamic> body = {
        "email": signInEmailCtrl.text.trim(),
        "password": signInPasswordCtrl.text.trim(),
        //"fcmToken": await PrefsHelper.getString(AppConstants.fcmToken),
      };

      print("===================> $body");

      // Make the API call
      Response response = await ApiClient.postData(
        ApiConstants.signInEndPoint,
        jsonEncode(body),
        headers: headers,
      );

      print("============> Response Body: ${response.body}, Status Code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
         PrefsHelper.setBool(AppConstants.isLogged, true);
         PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['attributes']['tokens']['accessToken']);

        Get.offAllNamed(AppRoutes.homeScreen);
        Get.snackbar('Successfully', 'Logged In');
      } else {
        ApiChecker.checkApi(response);
        Get.snackbar('Error', response.body['message'] ?? 'An error occurred');
      }
    } catch (e) {
      print("=============================> Error: $e");
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      signInLoading.value = false;
      print('======== Final Loading State : ${signInLoading.value}');
    }
  }


  ///<=================================== verifyOTP Method==================================================>

  TextEditingController verifyCodeCtrl = TextEditingController();
  var verifyOTPLoading = false.obs;

  verifyCode({
    required String email,
    required String code,
    required String type,
  }) async {
    verifyOTPLoading(true);
    try {
      Map<String, dynamic> body = {
        "email": email,
        "oneTimeCode": code};
      print("===================> ${body}");
      var headers = {'Content-Type': 'application/json'};

      Response response = await ApiClient.postData(ApiConstants.otpVerifyEndPoint, jsonEncode(body), headers: headers);

      print("============> Response Body ${response.body} and ==> ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {

        Get.snackbar('Verified', 'Successfully');
        if (type == "signupScreen") {
          Get.offAllNamed(AppRoutes.signInScreen);
        } else if (type == "forgetPasswordScreen") {
          Get.offAllNamed(AppRoutes.resetPassword,
            parameters: {
              "email" : email,
            }
          );
        }
        verifyOTPLoading(false);
      } else if (response.statusCode == 400 || response.statusCode == 401) {

        Get.snackbar('Error', 'Invalid Code');
        verifyOTPLoading(false);
      } else {
        ApiChecker.checkApi(response);
        verifyOTPLoading(false);
      }
    } catch (e) {
      print("===> error : $e");
    }
    verifyOTPLoading(false);
  }


  ///==================>>  Forgot pass word   <<<===============
  TextEditingController forgetEmailTextCtrl = TextEditingController();

  var forgotLoading = false.obs;

  handleForget() async {
    forgotLoading(true);
    var body = {
      "email": forgetEmailTextCtrl.text.trim(),
    };
    var headers = {
      'Content-Type': 'application/json'
    };
    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordEndPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.verifyScreen, parameters: {
        "email": forgetEmailTextCtrl.text.trim(),
        "screenType": "forgetPasswordScreen",
      });

      Get.snackbar('Successfully', 'OTP Send your email');
      forgotLoading(false);
    }
    if (response.statusCode == 400) {
      Get.snackbar('Error', '${response.body['message']}');
      forgotLoading(false);
    }
    else {
      ApiChecker.checkApi(response);
      forgotLoading(false);
    }
    forgotLoading(false);
  }

  //====================================> Re-Set New password <==================================
  var setPasswordLoading = false.obs;
  final TextEditingController setNewPasswordCTRl = TextEditingController();
  final TextEditingController setConfirmNewPasswordCTRl = TextEditingController();

  setNewPassword({required String email}) async {
    setPasswordLoading(true);
    var body = {
      "email": email,
      "newPassword": setNewPasswordCTRl.text.trim(),
      "confirmPassword": setConfirmNewPasswordCTRl.text.trim()
    };
    var response = await ApiClient.postData(
        ApiConstants.resetPasswordEndPoint, body);
    if (response.statusCode == 200) {
      Get.snackbar('Done!', 'Password Reset Successful');
      Get.offNamed(AppRoutes.signInScreen);
    }
    setPasswordLoading(false);
    if (response.statusCode == 400) {
      Get.snackbar('Error', '${response.body['message']}');
      setPasswordLoading(false);
    }
    else {
      ApiChecker.checkApi(response);
      setPasswordLoading(false);
    }
    setPasswordLoading(false);
  }


  /// ==========================>> Resend otp   <<================
  var resendOtpLoading = false.obs;
  resendOtp(String email) async {
    resendOtpLoading(true);
    var body = {
      "email": email,
    };
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.resendOTPEndPoint, jsonEncode(body),
        headers: header);
    print("===> ${response.body}");
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', 'Resend OTP Send your email');
    } else {
      Get.snackbar('Error', '${response.body['message']}');
      ApiChecker.checkApi(response);
    }
    resendOtpLoading(false);
  }

}
