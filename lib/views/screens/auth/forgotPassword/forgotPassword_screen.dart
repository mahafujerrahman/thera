import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/auth_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  bool isChecked = false;

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  Text(AppStrings.forgotPass,
                      style: AppStyles.fontSize24(fontWeight: FontWeight.w700)),
                  Text(AppStrings.pleaseEnterText,
                      style: AppStyles.fontSize14(fontWeight: FontWeight.w400)),
                  SizedBox(height: 30.h),
                  // Email Text Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppStrings.yourEmail,
                        style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: authController.forgetEmailTextCtrl,
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
                  SizedBox(height: 25.h),
                  Obx(()=>
                      CustomButton(
                        loading: authController.forgotLoading.value,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                           authController.handleForget();
                          }
                        },
                        text: AppStrings.sendOTP,
                        textColor: AppColors.whiteColor,
                      ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
