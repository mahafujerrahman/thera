import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/price_details_row.dart';

import '../../../../../controller/profileController.dart';

class CreateNewChartStepSixScreen extends StatefulWidget {
  @override
  _CreateNewChartStepSixScreenState createState() =>
      _CreateNewChartStepSixScreenState();
}

class _CreateNewChartStepSixScreenState
    extends State<CreateNewChartStepSixScreen> {
  final TextEditingController _controller = TextEditingController();
  final ProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Step 6',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PriceDetailWidget(
                      title: _profileController.selectedList[index].treatmentTitle,
                      price: _profileController.selectedList[index].price.toString());
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16,
                  );
                },
                itemCount: _profileController.selectedList.length),

            Divider(color: AppColors.blackColor),
            PriceDetailWidget(title: 'Full Cost', price: '800'),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.colorE9F5FE,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discount",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Container(
                    width: 80.w,
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixText: "\$",
                        contentPadding: EdgeInsets.zero,
                      ),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            PriceDetailWidget(title: 'Final Cost', price: '720'),
            SizedBox(height: 20.h),
            // Next Button
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.createNewChartDetailsScreen);
              },
              text: 'Next',
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
