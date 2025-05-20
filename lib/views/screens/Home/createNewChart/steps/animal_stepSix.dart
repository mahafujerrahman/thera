import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/service_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/price_details_row.dart';

import '../../../../../controller/clientController/inventoryController.dart';

class AnimalStepSixScreen extends StatefulWidget {
  const AnimalStepSixScreen({super.key});

  @override
  _AnimalStepSixScreenState createState() => _AnimalStepSixScreenState();
}

class _AnimalStepSixScreenState extends State<AnimalStepSixScreen> {
  final ServiceController serviceController = Get.put(ServiceController());
  final InventoryController inventoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Calculate the treatments cost
    double treatmentsCost = serviceController.selectedList.fold(0, (sum, item) {
      return sum + (item.price ?? 0);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Step 6 - Animal',
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
              // Treatments Section
              if (serviceController.selectedList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Treatments",
                      style: AppStyles.fontSize16(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                    SizedBox(height: 8.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PriceDetailWidget(
                          title: serviceController
                                  .selectedList[index].treatmentTitle ??
                              'Unknown Treatment',
                          price: serviceController.selectedList[index].price
                                  ?.toString() ??
                              '0',
                        );
                      },
                      itemCount: serviceController.selectedList.length,
                    ),
                    Divider(color: AppColors.blackColor.withOpacity(0.3)),
                    PriceDetailWidget(
                        title: 'Treatments Subtotal', price: '$treatmentsCost'),
                    SizedBox(height: 16.h),
                  ],
                ),

              // Equipment Section
              Text(
                "Equipment",
                style: AppStyles.fontSize16(
                    fontWeight: FontWeight.w600, color: AppColors.primaryColor),
              ),
              SizedBox(height: 8.h),
              Obx(() {
                double equipmentTotal = 0;
                List<Widget> equipmentWidgets = [];

                // Loop through all inventory items to find ones with quantity > 0
                for (var item in inventoryController.allInventoryList) {
                  String itemId = item.id ?? '0';
                  int quantity =
                      serviceController.getItemQuantity(itemId).value;
                  num price = item.pricePerOne ?? 0;

                  if (quantity > 0) {
                    num itemTotal = quantity * price;
                    equipmentTotal += itemTotal;

                    equipmentWidgets.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${item.productName ?? 'Unknown'} (${quantity}x \$${price.toStringAsFixed(2)})",
                              style: AppStyles.fontSize16(
                                  color: AppColors.color424242),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "\$${itemTotal.toStringAsFixed(2)}",
                            style: AppStyles.fontSize16(
                                color: AppColors.color424242),
                          ),
                        ],
                      ),
                    );

                    equipmentWidgets.add(SizedBox(height: 8.h));
                  }
                }

                if (equipmentWidgets.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Text(
                      "No equipment selected",
                      style: AppStyles.fontSize16(color: AppColors.colorB1B1B1),
                    ),
                  );
                }

                // Calculate the full cost (treatments + equipment)
                double fullCost = treatmentsCost + equipmentTotal;

                // Set full cost in controller
                serviceController.fullCost.value = fullCost;
                serviceController.calculateFinalCost();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...equipmentWidgets,
                    Divider(color: AppColors.blackColor.withOpacity(0.3)),
                    PriceDetailWidget(
                        title: 'Equipment Subtotal',
                        price: equipmentTotal.toStringAsFixed(2)),
                    SizedBox(height: 16.h),
                    Divider(color: AppColors.blackColor),
                    PriceDetailWidget(
                        title: 'Full Cost', price: fullCost.toStringAsFixed(2)),
                  ],
                );
              }),

              SizedBox(height: 12.h),
              // Discount section
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
                      style: AppStyles.fontSize16(color: AppColors.color424242),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      width: 80.w,
                      height: 30.h,
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

              SizedBox(height: 8.h),
              // Final cost
              Obx(() {
                return PriceDetailWidget(
                  title: 'Final Cost',
                  price: serviceController.finalCost.value.toStringAsFixed(2),
                );
              }),

              SizedBox(height: 20.h),
              // Next Button
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.animalServiceDetailsScreen);
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
