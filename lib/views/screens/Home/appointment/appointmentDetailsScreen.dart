import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:thera_track_app/controller/clientController/appointmentController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/helpers/time_formate.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_images.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_row.dart';


class AppointmentDetailsScreen extends StatefulWidget {
  @override
  State<AppointmentDetailsScreen> createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {

  final AppointmentController appointmentController = Get.put(AppointmentController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    final appointmentID = Get.parameters['appointmentID'] ?? '';
   appointmentController.getOneAppointmentByIdDetails(appointmentID);
  }

  bool isPaid = false;
  void togglePaidStatus(bool value) {
    setState(() {
      isPaid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
        ),
        body: Obx(() {
          return appointmentController.isLoading.value
              ? Center(child: CupertinoActivityIndicator(radius: 32.r, color: CupertinoColors.activeBlue))
              : Obx(() {
            var displayData = appointmentController.getOneAppoinmentDetailsModel.value;

            return Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 100.h,
                        width: double.infinity,
                        child: Image.asset(AppImages.appLogo)),
                    // Client Info Section
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRow(title: 'Name', displayData: displayData.clientId?.name ?? 'N/A'),
                          CustomRow(title: 'Email', displayData: displayData.clientId?.email ?? 'N/A'),
                          CustomRow(title: 'Mobile', displayData: displayData.clientId?.phoneNumber ?? 'N/A'),
                          CustomRow(title: 'Address', displayData: displayData.clientId?.city ?? 'N/A'),

                    // Description Section
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Container(
                              height: 217.h,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                              ),
                              child:ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: displayData.concernImages != null
                                        ? "${ApiConstants.imageBaseUrl}${displayData.concernImages?.first}"
                                        : "",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Center(
                                      child: Icon(
                                        Icons.error,
                                        size: 24.r,
                                        color: Colors.black,
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(
                                      child: CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.w),
                                  child: Text('Description', style: AppStyles.fontSize18(color: AppColors.color575757)),
                                ),
                                Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${displayData?.description}"),
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.w),
                            child: Text(
                              'Point',
                              style: AppStyles.fontSize18(color: AppColors.color575757),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: displayData.points != null && displayData.points!.isNotEmpty
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  displayData.points![0].split(",").length,
                                      (index) {
                                    String point = displayData.points![0]
                                        .split(",")[index]
                                        .replaceAll(RegExp(r'[\[\]"]'), '');
                                    return Text('${index + 1}. $point');
                                  },
                                ),
                              )
                                  : Text('No points available'),
                            ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.w),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Next Appointments', style: AppStyles.fontSize18(color: AppColors.color575757, fontWeight: FontWeight.w500)),
                                    SizedBox(height: 4.h),
                                    Text(
                                      displayData.apDate != null
                                          ? TimeFormatHelper.formatDate(displayData.apDate!)
                                          : 'No Date',
                                      style: AppStyles.fontSize14(color: AppColors.color575757),
                                    ),


                                    SizedBox(height: 4.h),
                                    Text('12.00 am', style: AppStyles.fontSize14(color: AppColors.color575757)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CustomButton(
                          onTap: () {
                            Get.toNamed(AppRoutes.appoinmentCalenderScreen);
                          },
                          prefixIcon: Icon(Icons.calendar_month),
                          text: 'Reschedule'),
                      SizedBox(height: 8.h),

                  ],
                )]
                )
              )
            );

          });
        }));
  }
}
