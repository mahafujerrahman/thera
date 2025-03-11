import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/time_formate.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/appDrawer/paid/innerWidget/clientRowWidget.dart';

class UnPaidDetailsScreen extends StatefulWidget {
  @override
  State<UnPaidDetailsScreen> createState() => _UnPaidDetailsScreenState();
}

class _UnPaidDetailsScreenState extends State<UnPaidDetailsScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getAllUnPaidTreatmentDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unpaid', style: AppStyles.fontSize16()),
        centerTitle: true,
      ),
      body: Obx(() {
        // Observing changes in the data for dynamic updates
        return Column(
          children: [
            Expanded(
              child: profileController.getAllUnPaidTreatmentModels.isEmpty
                  ? Center(
                  child: Text('No unPaid treatments added yet.',
                      style: TextStyle(color: Colors.black)))
                  : Column(
                    children: [
                      ListView.builder(
                      shrinkWrap: true,
                      itemCount: profileController.getAllUnPaidTreatmentModels.length,
                      itemBuilder: (context, index) {
                        final displayData = profileController.getAllUnPaidTreatmentModels[index];
                        return Column(
                          children: [
                            ClientRowWidget(
                              status: 'unpaid',
                              name: displayData.name ?? 'N/A',
                              date: TimeFormatHelper.formatDate(DateTime.parse(displayData.createdAt.toString())),
                              amount: int.parse(displayData.finalCost.toString()),
                            ),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(12.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  TimeFormatHelper.formatDate(DateTime.now()),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              '${profileController.unpaidTotalFinalCost} \$',
                              style: TextStyle(
                                color: AppColors.redColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
            _buildEmailInputSection(),
          ],
        );
      }),
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
                  onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}

