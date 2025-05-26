import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/travel/travel_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/screens/home/travel/innerWidget/costRowWidget.dart';


class TravelDetailsScreen extends StatefulWidget {
  const TravelDetailsScreen({super.key});

  @override
  State<TravelDetailsScreen> createState() => _TravelDetailsScreenState();
}

class _TravelDetailsScreenState extends State<TravelDetailsScreen> {
  final TravelController travelController = Get.put(TravelController());

  @override
  void initState() {
    super.initState();
    travelController.getAllTravel();
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
              height: 40.h,
              text: 'Add New',
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (travelController.isLoading.value) {
          return Center(
            child: CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (travelController.getAllTravelModel.isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.h),
                    padding: EdgeInsets.all(12.r),
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
                  ),

                Expanded(
                  child: travelController.getAllTravelModel.isEmpty
                      ? Center(
                    child: Text(
                      'No item added yet.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                      : ListView.builder(
                    itemCount: travelController.getAllTravelModel.length,
                    itemBuilder: (context, index) {
                      var displayData = travelController.getAllTravelModel[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.costDetailsScreen,
                              arguments: displayData.id
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
                  ),
                ),
                _buildEmailInputSection(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildEmailInputSection() {
    return Padding(
      padding: EdgeInsets.all(8.r),
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
