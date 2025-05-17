import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/style.dart';

class SubscriptionCard extends StatelessWidget {
  final String planName;
  final double price;
  final String feature;
  final String billingCycle;
  final bool isCurrentPlan;

  const SubscriptionCard({
    Key? key,
    required this.planName,
    required this.price,
    required this.feature,
    required this.billingCycle,
    this.isCurrentPlan = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.subscriptionIcon,
                      color: AppColors.whiteColor,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    planName,
                    style: AppStyles.fontSize16(color: AppColors.primaryColor)
                  ),
                ],
              ),
              if (isCurrentPlan)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Current Plan',
                    style: AppStyles.fontSize12(color: AppColors.whiteColor)
                  ),
                ),
            ],
          ),
          // Divider before the Price Section
          Divider(
            color: Colors.blue.withOpacity(0.5),
            thickness: 1,
            height: 20,
          ),
          // Features List
          Row(
            children: [
              Icon(Icons.done, color: AppColors.primaryColor),
              SizedBox(width: 8.w),
              Text('$feature', style: AppStyles.fontSize16(color: Colors.blue)),
            ],
          ),

          // Price Section
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '\$$price',
                style: AppStyles.fontSize24(fontWeight: FontWeight.w600,color: AppColors.primaryColor)
              ),
              SizedBox(width: 5),
              Text(
                '/$billingCycle',
                style: AppStyles.fontSize16(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
