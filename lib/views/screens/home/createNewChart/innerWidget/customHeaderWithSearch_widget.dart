import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';

class CustomHeaderWithSearch extends StatelessWidget {
  final String titleText;
  final Widget actionChild;
  final TextEditingController searchController;

  CustomHeaderWithSearch({
    required this.titleText,
    required this.actionChild,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.h,
          color: AppColors.secondaryColor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleText,
                    style: AppStyles.fontSize16(),
                  ),
                  actionChild,
                ],
              ),
            ),
          ),
        ),
        // Search field container
        Container(
          color: AppColors.secondaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_off_sharp),
                fillColor: AppColors.whiteColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                ),
              ),

            ),

          ),

        ),
      ],
    );
  }
}
