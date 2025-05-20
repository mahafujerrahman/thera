import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/inventoryController.dart';
import 'package:thera_track_app/controller/clientController/service_controller.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/helpers/route.dart';

class EquipmentScreen extends StatelessWidget {
  final InventoryController inventoryController =
      Get.put(InventoryController());
  final ServiceController serviceController = Get.put(ServiceController());

  EquipmentScreen({super.key}) {
    inventoryController.getAllInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Equipment",
          style: AppStyles.fontSize16(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Product name",
                    style: AppStyles.fontSize16(color: AppColors.color424242)),
                Text("Quantity",
                    style: AppStyles.fontSize16(color: AppColors.color424242)),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (inventoryController.allInventoryList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: inventoryController.allInventoryList.length,
                  itemBuilder: (context, index) {
                    var item = inventoryController.allInventoryList[index];
                    // Use item's ID as a unique identifier
                    String itemId = item.id ?? index.toString();

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.productName ?? 'N/A',
                              style: AppStyles.fontSize16(
                                  color: AppColors.colorB1B1B1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline,
                                    color: AppColors.colorB1B1B1),
                                onPressed: () {
                                  serviceController
                                      .decrementItemQuantity(itemId);
                                },
                              ),
                              Container(
                                width: 60.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.colorB1B1B1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Obx(() => Text(
                                      "${serviceController.getItemQuantity(itemId).value}",
                                      style: AppStyles.fontSize16(
                                          color: AppColors.color707070),
                                    )),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline,
                                    color: AppColors.colorB1B1B1),
                                onPressed: () {
                                  serviceController
                                      .incrementItemQuantity(itemId);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              onTap: () {
                Get.toNamed(
                  AppRoutes.animalStepSixScreen,
                );
              },
              text: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
