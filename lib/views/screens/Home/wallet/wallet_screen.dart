import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/wallet/wallet_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/screens/Home/wallet/innerWidget/costRowWidget.dart';

class WalletDetailsScreen extends StatefulWidget {
  @override
  State<WalletDetailsScreen> createState() => _WalletDetailsScreenState();
}

class _WalletDetailsScreenState extends State<WalletDetailsScreen> {
  final WalletController walletController = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    walletController.getAllWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cost',
          style: AppStyles.fontSize16(),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.costAddScreen);
              },
              width: 50.w,
              text: 'Add New',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              if (walletController.getAllWalletModel.isEmpty) {
                return SizedBox.shrink();
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.secondaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Departure'),
                    Text('Destination'),
                    Text('Distance'),
                    Text('Total Cost'),
                  ],
                ),
              );
            }),

            Expanded(
              child: Obx(() {
                if (walletController.getAllWalletModel.isEmpty) {
                  return Center(
                    child: Text(
                      'No item added yet.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: walletController.getAllWalletModel.length,
                  itemBuilder: (context, index) {
                    var displayData = walletController.getAllWalletModel[index];
                    return InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.costDetailsScreen,
                            arguments :displayData.id
                          );
                      },
                      child: CostRowWidget(
                        departure: displayData.departure ?? 'N/A',
                        destination: displayData.destination ?? 'N/A',
                        distance: displayData.distance?.toString() ?? 'N/A',
                        totalCost: displayData.totalCost?.toString() ?? 'N/A',
                        index: index,
                      ),
                    );
                  },
                );
              }),
            ),
            _buildEmailInputSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInputSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColors.secondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter email here',
                hintStyle: AppStyles.fontSize14(color: AppColors.greyColor),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Data will be sent to the email above.',
              style: TextStyle(color: AppColors.blackColor),
            ),
            SizedBox(height: 16.h),
            Center(
              child: SizedBox(
                width: 194.w,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(AppRoutes.costDetailsScreen);
                  },
                  icon: Icon(Icons.send, color: AppColors.whiteColor),
                  label: Text('Send', style: TextStyle(color: AppColors.whiteColor)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
