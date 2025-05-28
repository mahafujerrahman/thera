import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:thera_track_app/controller/auth_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(height: 150.h),
                  Text(AppStrings.signInToYourAccount,style: AppStyles.fontSize24(color: AppColors.blackColor),),
                  SizedBox(height: 20.h),
                  Text(AppStrings.welcomeBack,style: AppStyles.fontSize14(fontWeight:FontWeight.w400),),
                  SizedBox(height: 30.h),
                  // Email Text Field
                  Text(AppStrings.yourEmail,style: AppStyles.fontSize16(fontWeight:FontWeight.w700),),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: authController.signInEmailCtrl,
                    hintText: AppStrings.enterEmail,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: SvgPicture.asset(AppIcons.emailIcon),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(AppStrings.passwordText,style: AppStyles.fontSize16(fontWeight:FontWeight.w700),),
                  SizedBox(height: 8.h),
                  // Password Text Field
                  CustomTextField(
                    controller: authController.signInPasswordCtrl,
                    hintText: AppStrings.enterPassword,
                    isPassword: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: SvgPicture.asset(AppIcons.passwordLockIcon),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  //forgotPassword Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgotPasswordScreen);
                        },
                        child: CustomText(
                          fontWeight: FontWeight.bold,
                          text: AppStrings.forgotPassword,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  // Sign In Button
                  SizedBox(height: 20.h),
                  Obx(()=>
                      CustomButton(
                        loading: authController.signInLoading.value,
                        onTap: () {
                          if(_formKey.currentState!.validate()){
                            authController.signInMethod();
                          }
                        },
                        text: 'Sign In',
                        textColor: AppColors.whiteColor,
                      ),

                  ),

                  // Don't Have an Account Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.doNotHaveAnAccount.tr,style: AppStyles.fontSize14(color: AppColors.greyColor)),
                      TextButton(
                        onPressed: () {
                           Get.toNamed(AppRoutes.signUpScreen);
                        },
                        child: CustomText(
                          text: AppStrings.signUp,
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
}
