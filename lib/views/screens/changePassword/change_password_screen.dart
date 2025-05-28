
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordCTRl = TextEditingController();
  final TextEditingController confirmPasswordCTRl = TextEditingController();
  final TextEditingController resetPasswordCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppStrings.changePassword,style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.back),
          padding: EdgeInsets.all(8.0),
          iconSize: 18.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //================================> Change Password Text Section <========================
                  Text( AppStrings.oldPassword,style: AppStyles.fontSize16(fontWeight:FontWeight.w700),),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    isPassword: true,
                    controller: passwordCTRl,
                    hintText: AppStrings.enterPassword,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: SvgPicture.asset(AppIcons.passWordIcon),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Old Password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  //=================================> Confirm Password Text Field <=========================
                  Text(AppStrings.setNewPassword,style: AppStyles.fontSize16(fontWeight:FontWeight.w700),),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    isPassword: true,
                    controller: confirmPasswordCTRl,
                    hintText: AppStrings.enterConfirmPassword,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: SvgPicture.asset(AppIcons.passWordIcon),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter New Password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  //================================> Re Enter New Password  <======================================
                  Text(AppStrings.reEnterNewPassword,style: AppStyles.fontSize16(fontWeight:FontWeight.w700),),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    isPassword: true,
                    controller: resetPasswordCTRl,
                    hintText: AppStrings.enterConfirmPassword,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: SvgPicture.asset(AppIcons.passWordIcon),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Password";
                      }
                      return null;
                    },
                  ),
                /*  Row(
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
                  ),*/
                  SizedBox(height: 20.h),
                  CustomButton(
                      onTap: (){},
                      text: AppStrings.changePassword)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
