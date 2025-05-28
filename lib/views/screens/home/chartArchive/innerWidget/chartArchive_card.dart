import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';

class ChartCard extends StatelessWidget {
  final String id;
  final String date;
  final String name;
  final int? price;
  final bool paidStatus;


  const ChartCard({
    Key? key,
    required this.id,
    required this.date,
    required this.name,
    this.price,
    this.paidStatus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.color99CFF9,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: paidStatus ? AppColors.primaryColor : AppColors.redColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '#$id',
              style: AppStyles.fontSize18(color: AppColors.color424242, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              date,
              style: AppStyles.fontSize14(color: AppColors.color424242),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              name,
              style: AppStyles.fontSize18(color: AppColors.color424242, fontWeight: FontWeight.w500),
            ),
          ),
          if (price != null) ...[
            Container(
              width: double.infinity,
              color: AppColors.secondaryColor,
              padding:  EdgeInsets.symmetric(horizontal: 8.w),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  '$price \$',
                  style: AppStyles.fontSize18(color: AppColors.color424242, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
