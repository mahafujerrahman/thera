import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thera_track_app/controller/clientController/inventoryController.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryController inventoryController =
      Get.put(InventoryController());

  @override
  void initState() {
    super.initState();
    inventoryController.getAllInventory().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Inventory", style: AppStyles.fontSize14()),
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (inventoryController.allInventoryList.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Product Name', style: TextStyle(color: Colors.black)),
                    SizedBox(width: 12.w),
                    Text('Price Per One',
                        style: TextStyle(color: Colors.black)),
                    SizedBox(width: 12.w),
                    Text('Quantity', style: TextStyle(color: Colors.black)),
                    SizedBox(width: 20.w)
                  ],
                ),
              ),
            // Display the list of treatments
            Expanded(
              child: inventoryController.allInventoryList.isEmpty
                  ? Center(
                      child: Text('No item added yet.',
                          style: TextStyle(color: Colors.black)))
                  : Obx(
                      () => ListView.builder(
                        itemCount: inventoryController.allInventoryList.length,
                        itemBuilder: (context, index) {
                          var displayData = inventoryController.allInventoryList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.secondaryColor),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      displayData.productName ?? 'N/A',
                                      style: TextStyle(
                                          color: AppColors.color424242),
                                    ),
                                  ),
                                ),
                                // Price
                                Container(
                                  height: 44.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.secondaryColor),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      displayData.pricePerOne.toString() ??
                                          'N/A',
                                      style: TextStyle(
                                          color: AppColors.color424242),
                                    ),
                                  ),
                                ),
                                // Quantity
                                Container(
                                  height: 44.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.secondaryColor),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      displayData.currentQuantity.toString() ??
                                          'N/A',
                                      style: TextStyle(
                                          color: AppColors.color424242),
                                    ),
                                  ),
                                ),
                                // Delete Button
                                IconButton(
                                  icon: Icon(Icons.close, color: Colors.black),
                                  onPressed: () {
                                    Get.dialog(
                                      _confirmDialog(
                                        title: "Delete Product!",
                                        message:
                                            "Are you sure you want to delete this product?",
                                        onConfirm: () {
                                          inventoryController
                                              .deleteSingelProduct(
                                            productID:
                                                '${inventoryController.allInventoryList[index].id}',
                                          );
                                          inventoryController.allInventoryList
                                              .removeAt(index);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    child: CustomTextField(
                      keyboardType: TextInputType.text,
                      controller: inventoryController.productName,
                      contentPaddingVertical: 5,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 40.h,
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: inventoryController.pricePerOne,
                      contentPaddingVertical: 5,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 40.h,
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: inventoryController.quantity,
                      contentPaddingVertical: 5,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CustomButton(
                  width: 8.w,
                  height: 45.h,
                  onTap: () {
                    int? price = int.tryParse(
                        inventoryController.pricePerOne.text.trim());
                    int? quantity =
                        int.tryParse(inventoryController.quantity.text.trim());

                    if (price == null || price <= 0) {
                      Get.snackbar('Error', 'Please enter a valid price.');
                      return;
                    }
                    if (quantity == null || quantity <= 0) {
                      Get.snackbar('Error', 'Please enter a valid quantity.');
                      return;
                    }

                    inventoryController.addInventoryMethod(
                      productName: inventoryController.productName.text.trim(),
                      price: price,
                      quantity: quantity,
                    );
                  },
                  text: 'Add',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//=====================>>> Confirm Dialog <<<==================
Widget _confirmDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  return AlertDialog(
    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel", style: TextStyle(color: Colors.grey)),
      ),
      TextButton(
        onPressed: () {
          Get.back();
          onConfirm();
        },
        child: Text("Yes", style: TextStyle(color: Colors.red)),
      ),
    ],
  );
}
