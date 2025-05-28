import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';

class CostDetailsWidget extends StatelessWidget {
  final String title;
  final String value;

  const CostDetailsWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppStyles.fontSize16(color: AppColors.color575757),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Separator ":"
          Text(
            ':',
            style: AppStyles.fontSize16(color: AppColors.color575757),
          ),

          SizedBox(width: 10.w),

          // Fixed width container for price
          Container(
            width: 200.w,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:  EdgeInsets.only(left: 16.0),
              child: Text(
                '$value',
                style: AppStyles.fontSize16(color: AppColors.color575757),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
