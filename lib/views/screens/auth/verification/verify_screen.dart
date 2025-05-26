import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thera_track_app/controller/auth_controller.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/app_images.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text.dart';

import '../../../base/pin_code_text_field.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  var parameter = Get.parameters;
  bool isChecked = false;

  int _countdown = 180;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(AppIcons.backButton),
          padding: EdgeInsets.all(8.0),
          iconSize: 18.sp,
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  Text(AppStrings.verifyEmail,
                    style: AppStyles.fontSize24(fontWeight: FontWeight.w700),
                  ),
                  Text(AppStrings.pleaseCheckCode,
                    style: AppStyles.fontSize14(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 30.h),
                  CustomPinCodeTextField(
                    textEditingController: authController.verifyCodeCtrl,
                  ),
                  SizedBox(height: 25.h),
                  Center(
                    child: Text(
                      _formatCountdown(),
                      style: const TextStyle(fontSize: 18, color: AppColors.primaryColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Verify button
                  Obx(()=>
                      CustomButton(
                        loading: authController.verifyOTPLoading.value,
                        onTap: () {
                          authController.verifyCode(
                              email: "${parameter['email']}",
                              code: authController.verifyCodeCtrl.text,
                              type:"${parameter['screenType']}").
                          then((_) {
                            authController.verifyCodeCtrl.clear();
                          });
                        },
                        text: 'Confirm',
                        textColor: AppColors.whiteColor,
                      ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.didNotReceiveCode,style: AppStyles.fontSize14(color: AppColors.color878787)),
                      TextButton(
                        onPressed: () {
                        authController.resendOtp(
                          "${parameter['email']}",
                        );
                        },
                        child: CustomText(
                          fontSize: 14.sp,
                          text: AppStrings.resendIt,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer.cancel();
        //  Get.toNamed(AppRoutes.forgotPasswordScreen);
        }
      });
    });
  }

  // Format countdown from seconds to "MM:SS"
  String _formatCountdown() {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }

  //=========================>>>>>  Password Change BottomSheet    <<<================================
  void _showPasswordChangeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Divider(thickness: 1, color: AppColors.primaryColor),
              ),
              Lottie.asset(AppImages.passwordChangeAnimation,height: 150.h),
              SizedBox(height: 16.h),
              Text(AppStrings.passwordChanged, style: AppStyles.fontSize20(color: AppColors.blackColor,fontWeight: FontWeight.w700),),
              SizedBox(height: 20.h),
              Text(AppStrings.returnToLogIn,
                style: AppStyles.fontSize16(color: AppColors.color878787),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                  onTap: (){
                //    Get.toNamed(AppRoutes.signInScreen);
                  },
                  text: AppStrings.backToLogin
              )
            ],
          ),
        );
      },
    );
  }
}
