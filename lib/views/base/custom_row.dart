import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String displayData;

  const CustomRow({
    super.key,
    required this.title,
    required this.displayData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: AppStyles.fontSize16(color: AppColors.color424242),
              overflow: TextOverflow.ellipsis,
            ),
          ),


          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  ':',
                  style: AppStyles.fontSize16(color: AppColors.color424242),
                ),
                SizedBox(width: 10.w),
                Text(
                  '$displayData',
                  style: AppStyles.fontSize16(color: AppColors.color424242),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ],
            ),
          ),

          SizedBox(width: 10.w),

          // Fixed width container for displayData

        ],
      ),
    );
  }
}
