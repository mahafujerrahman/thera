import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:thera_track_app/controller/clientController/appointmentController.dart';
import 'package:thera_track_app/controller/clientController/chartArchive_controller.dart';
import 'package:thera_track_app/helpers/time_formate.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/app_images.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/price_details_row.dart';
import 'package:thera_track_app/views/screens/Home/chartArchive/innerWidget/addpoint_textBox.dart';

import '../../../base/custom_list_tile.dart';

class ChartArchiveDetailsScreen extends StatefulWidget {
  @override
  State<ChartArchiveDetailsScreen> createState() =>
      _ChartArchiveDetailsScreenState();
}

class _ChartArchiveDetailsScreenState extends State<ChartArchiveDetailsScreen> {
  final ChartArchiveController chartArchiveController = Get.put(ChartArchiveController());
  final AppointmentController appointmentController = Get.put(AppointmentController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    final serviceId = Get.parameters['serviceID'] ?? '';
    final appointmentID = Get.parameters['appointmentID'] ?? '';
    chartArchiveController.getServiceDetailsByIdDetails(serviceId);
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
    final String screenType = parameter['screenType'] ?? '';
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
        ),
        body: Obx(() {
          return chartArchiveController.isLoading.value
              ? Center(child: CupertinoActivityIndicator(radius: 32.r, color: CupertinoColors.activeBlue))
              : Obx(() {
                  var displayData = chartArchiveController.getServiceDetailByIdModels.value;

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
                                // Name
                                Text(
                                  AppStrings.nameText,
                                  style: AppStyles.fontSize16(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.color424242),
                                ),
                                SizedBox(height: 4.h),
                                CustomListTile(title: '${displayData.clientId?.name}'),
                                // Email
                                Text(
                                  'Email',
                                  style: AppStyles.fontSize16(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.color424242),
                                ),
                                SizedBox(height: 4.h),
                                CustomListTile(title: '${displayData.clientId?.email}'),
                                // Mobile
                                Text('Mobile',
                                  style: AppStyles.fontSize16(fontWeight: FontWeight.w400, color: AppColors.color424242),
                                ),
                                SizedBox(height: 4.h),
                                CustomListTile(title: '${displayData.clientId?.phoneNumber}'),
                                // Address
                                Text(
                                  'Address',
                                  style: AppStyles.fontSize16(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.color424242),
                                ),
                                SizedBox(height: 4.h),
                                CustomListTile(title: '${displayData.clientId?.address?.city}'),
                                // Date
                                Text(
                                  'Date',
                                  style: AppStyles.fontSize16(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.color424242),
                                ),
                                SizedBox(height: 4.h),
                                CustomListTile(title: TimeFormatHelper.formatDate(DateTime.parse(displayData.createdAt.toString())),),
                              ]),
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: "${ApiConstants.imageBaseUrl}${displayData.concernImages?[0]}",
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => Center(
                                            child: Icon(
                                              Icons.error,
                                              size: 24.r,
                                              color: Colors.black,
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(child:CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor)),
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
                                          child: Text("${displayData.description}"),
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                         /* //Add Point Section
                          TextBoxList(),*/
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

                          // Footer Actions
                          if (screenType == 'chartArchiveScreen') ...{
                            // Services Section
                            Column(
                            children: displayData.treatments!.map((treatment) {
                            return PriceDetailWidget(
                            title: treatment.name ?? 'N/A',
                            price: treatment.value.toString(),
                            );
                            }).toList(),
                            ),
                            Divider(color: AppColors.blackColor),
                            PriceDetailWidget(title: 'Full Cost', price: displayData.finalCost.toString()),
                            PriceDetailWidget(title: 'Discount ', price: displayData.discount.toString()),
                            Divider(color: AppColors.blackColor),
                            PriceDetailWidget(title: 'Final Cost', price: displayData.finalCost.toString()),
                            SizedBox(height: 8.h),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(Icons.send),
                                              text: 'Send')
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(Icons.sync_rounded),
                                              text: 'Sync')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(Icons.print),
                                              text: 'Print')
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(CupertinoIcons.delete),
                                              text: 'Delete')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                //Paid/unpaid
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Paid Container
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isPaid = true;
                                            });
                                          },
                                          child: Container(
                                            height: 50.h,
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: AppColors.primaryColor),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Transform.scale(
                                                  scale: 1.2,
                                                  child: Checkbox(
                                                    value: isPaid,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isPaid = value ?? false;
                                                      });
                                                    },
                                                    activeColor: AppColors.primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  'Paid',
                                                  style: TextStyle(color: AppColors.primaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      // Unpaid Container
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isPaid = false;
                                            });
                                          },
                                          child: Container(
                                            height: 50.h,
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: AppColors.redColor),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Transform.scale(
                                                  scale: 1.2,
                                                  child: Checkbox(
                                                      value: !isPaid,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          isPaid =
                                                              !(value ?? false);
                                                        });
                                                      },
                                                      activeColor: AppColors.redColor),
                                                ),
                                                Text(
                                                  'Unpaid',
                                                  style: TextStyle(
                                                      color: AppColors.redColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          } else if (screenType == 'offLineFileScreen') ...{
                            // Services Section
                            PriceDetailWidget(title: 'Cryotherapy', price: '200'),
                            PriceDetailWidget(title: 'Massage Therapy', price: '200'),
                            PriceDetailWidget(title: 'Acupuncture', price: '200'),
                            PriceDetailWidget(title: 'Heat and Cold Therapy', price: '200'),
                            Divider(color: AppColors.blackColor),
                            PriceDetailWidget(title: 'Full Cost', price: '200'),
                            PriceDetailWidget(title: 'Discount ', price: '200'),
                            Divider(color: AppColors.blackColor),
                            PriceDetailWidget(title: 'Final Cost', price: '1000'),
                            SizedBox(height: 8.h),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(Icons.send),
                                              text: 'Send')
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(Icons.sync_rounded),
                                              text: 'Sync')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(Icons.print),
                                              text: 'Print')
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomButton(
                                              onTap: () {},
                                              prefixIcon: Icon(CupertinoIcons.delete),
                                              text: 'Delete')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          } else if (screenType == 'appointmentScreen') ...{
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
                                          Text('Next Appointments',
                                              style: AppStyles.fontSize18(
                                                  color: AppColors.color575757,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(height: 4.h),
                                          Text('24 jan, 2025',
                                              style: AppStyles.fontSize14(
                                                  color: AppColors.color575757)),
                                          SizedBox(height: 4.h),
                                          Text('12.00 am',
                                              style: AppStyles.fontSize14(
                                                  color: AppColors.color575757)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            CustomButton(
                                onTap: () {},
                                prefixIcon: Icon(Icons.calendar_month),
                                text: 'Reschedule'),
                            SizedBox(height: 8.h),
                          }
                        ],
                      ),
                    ),
                  );
                });
        }));
  }
}
