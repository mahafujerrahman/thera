import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());


  String selectedCountryCode = '+880';
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
                  SizedBox(height: 20.h),
                  Text(AppStrings.signupToYourAccount,
                    style: AppStyles.fontSize24(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20.h),
                  Text(AppStrings.welcomeBack,
                    style: AppStyles.fontSize14(fontWeight: FontWeight.w400,color: AppColors.color878787),
                  ),
                  SizedBox(height: 30.h),

                  // User Name
                  Text(AppStrings.nameText, style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: authController.userNameCTRL,
                    hintText: AppStrings.enterName,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: SvgPicture.asset(AppIcons.personIcon),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name"; // Corrected message
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),

                  // Email
                  Text(AppStrings.email, style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: authController.signUpEmailCtrl,
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

                  // Phone Number
                  Text(AppStrings.phoneNumber, style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            border: Border.all(
                                width: 1.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(4.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            //=================================> Country Code Picker Widget <============================
                            CountryCodePicker(
                              showFlag: false,
                              showFlagDialog: true,
                              onChanged: (countryCode) {
                                setState(() {
                                  authController.selectedCountryCodes = countryCode.dialCode!;
                                });
                              },
                              initialSelection: 'BD',
                              favorite: ['+880', 'BD'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: Icon(Icons.arrow_drop_down_sharp)
                            )
                          ],

                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: authController.phoneNumberCTRL,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 18.h),
                              child: const Icon(Icons.call),
                            ),
                            hintText: 'Phone',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Provide Phone Number';
                              }else if (value.length < 5) {
                                return 'Provide Phone Number';
                              }
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Password
                  Text(AppStrings.passwordText, style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: authController.passwordCTRL,
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
                  SizedBox(height: 8.h),

                  // Confirm Password
                  Text(AppStrings.confirmPasswordText, style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller:authController.confirmPasswordCTRL,
                    hintText: AppStrings.enterConfirmPassword,
                    isPassword: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: SvgPicture.asset(AppIcons.passwordLockIcon),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password again";
                      }
                      if (value != authController.passwordCTRL.text) { // Ensure passwords match
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  _checkboxSection(),
                  // Sign Up Button
                  SizedBox(height: 20.h),
                  Obx(()=>
                    CustomButton(
                      loading: authController.signUpLoading.value,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (isChecked) {
                            authController.signUpMethod();
                          } else {
                            Get.snackbar(
                              "Error in Checkbox",
                              "Must agree to terms and conditions",
                            );
                          }
                        }
                      },
                      text: AppStrings.signUp,
                    ),
              ),

                  // Don't Have an Account Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.alreadyHaveAnAccount.tr, style: AppStyles.fontSize14(color: AppColors.color878787)),
                      TextButton(
                        onPressed: () {
                           Get.toNamed(AppRoutes.signInScreen);
                        },
                        child: CustomText(
                          text: AppStrings.signIn,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
  //==========================> Checkbox Section Widget <=======================
  _checkboxSection() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.greyColor,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          side: BorderSide(
            color: isChecked ? AppColors.primaryColor : AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        Text.rich(
          maxLines: 2,
          TextSpan(
            text: AppStrings.byCreating,
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500,color: AppColors.color878787),
            children: [
              TextSpan(
                text: AppStrings.termsConditions,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                   // Get.toNamed(AppRoutes.termsConditionScreen);
                  },
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: AppStrings.privacyPolicy,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                   // Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
