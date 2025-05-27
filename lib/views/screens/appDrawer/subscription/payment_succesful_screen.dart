import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';


class PaymentSuccessfulScreen extends StatefulWidget {
  const PaymentSuccessfulScreen({super.key});

  @override
  State<PaymentSuccessfulScreen> createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              SvgPicture.asset(AppIcons.successfulIcon),
              SizedBox(height: 16.h),
              Text('Successfully Payment!',style: AppStyles.fontSize18(fontWeight: FontWeight.w700)),
              SizedBox(height: 16.h),
              Text('Return to the Home page to explore More Event',style: AppStyles.fontSize18(color: AppColors.color878787),textAlign: TextAlign.center),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.homeScreen);
                    },
                    text: 'Back to Home'
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
