import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_constants.dart';
import 'package:thera_track_app/utils/app_images.dart';
import 'package:thera_track_app/views/base/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    StreamSubscription;
    getConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.appLogo,
                height: 130.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 80.h),

            ],
          ),
        ),
      ),
    );
  }


  ///===================internet connection checker==================>
  StreamSubscription? streamSubscription;
  bool isConnection = false;

  ///========================is internet connection check========================>
  void getConnectivity() {
    streamSubscription = Connectivity().onConnectivityChanged.listen((event) async {
     isConnection = await InternetConnectionChecker.instance.hasConnection;

      ///==================if internet is available===================>
      if (isConnection) {
        print("------------------Internet available");
        Timer(const Duration(seconds: 3), () async {
          bool? isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
          String token = await PrefsHelper.getString(AppConstants.bearerToken);
          var role = await PrefsHelper.getString(AppConstants.role);

          ///========================check islogged in, token, and role then decide where will be navigate====================>

          if (isLogged != null && isLogged) {
                Get.offAllNamed(AppRoutes.homeScreen);
          } else {
            Get.offAllNamed(AppRoutes.homeScreen);
          }
        });
      }

      ///======================no internet=========================>
      else {
       // Get.snack bar('Network Error!', 'Please connect your internet.');
       // AppCustomToast.showCustomToast('Please connect your internet.');
        print("----------------------No internet");
      }
    });
  }
}
