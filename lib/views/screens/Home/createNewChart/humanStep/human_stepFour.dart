import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thera_track_app/controller/clientController/service_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/price_details_row.dart';

import '../../../../../controller/profileController.dart';

class HumanStepFour extends StatefulWidget {
  @override
  _HumanStepFourState createState() => _HumanStepFourState();
}

class _HumanStepFourState
    extends State<HumanStepFour> {

  final ProfileController _profileController = Get.find();
  final ServiceController serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {

    // Calculate the full cost
    double totalCost = serviceController.selectedList.fold(0, (sum, item) {
      return sum + (item.price ?? 0);
    });

    // Set full cost in controller
    serviceController.fullCost.value = totalCost;
    serviceController.calculateFinalCost();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Step 4 -Human',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PriceDetailWidget(
                        title: serviceController.selectedList[index].treatmentTitle,
                        price: serviceController.selectedList[index].price.toString());
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  itemCount: serviceController.selectedList.length),
        
              Divider(color: AppColors.blackColor),
              PriceDetailWidget(title: 'Full Cost', price: '$totalCost'),
        
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
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          onChanged: (value) {
                            serviceController.updateDiscount(value);
                          },
                          controller: serviceController.discountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixText: "\$",
                          ),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: AppStyles.fontSize16(),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Obx(() {
                return PriceDetailWidget(
                  title: 'Final Cost',
                  price: '${serviceController.finalCost.value}',
                );
              }),
              SizedBox(height: 20.h),
              // Next Button
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.humanStepFive);
                },
                text: 'Next',
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }
}
