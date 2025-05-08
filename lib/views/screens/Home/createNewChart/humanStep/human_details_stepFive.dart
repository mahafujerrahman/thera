import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/controller/clientController/service_controller.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_images.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_list_tile.dart';
import 'package:thera_track_app/views/base/custom_row.dart';
import 'package:thera_track_app/views/base/dotted_border_container.dart';
import 'package:thera_track_app/views/base/price_details_row.dart';
import 'package:thera_track_app/views/screens/Home/chartArchive/innerWidget/addpoint_textBox.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/innerWidget/detailsRow_widget.dart';

class HumanStepFive extends StatefulWidget {
  const HumanStepFive({super.key});

  @override
  State<HumanStepFive> createState() => _HumanStepFiveState();
}

class _HumanStepFiveState extends State<HumanStepFive> {
  final TextEditingController fullNameCTRl = TextEditingController();
  final TextEditingController emailCTRl = TextEditingController();
  final TextEditingController addressCTRl = TextEditingController();

  final ClientController clientController = Get.put(ClientController());
  final ServiceController serviceController = Get.put(ServiceController());

  final ProfileController _profileController = Get.find();

  bool isPaid = false;


  void togglePaidStatus(bool value) {
    setState(() {
      isPaid = value;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var clientID = await PrefsHelper.getString(AppConstants.createdServiceClientId);
      clientController.clientDetailsByID(clientID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      //=============================> AppBar Section <=======================
      appBar: AppBar(
        title: Text(
          'Human - New Create Details',
          style: AppStyles.fontSize16(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.w),
          child: Obx(() {
            var clientInfo = clientController.getClientInfoByIdModel.value;

            // If clientInfo is null, display a loading spinner or placeholder
            if (clientInfo == null) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Center(
                  child: Image.asset(
                    height: 100.h,
                    AppImages.appLogo,
                    fit: BoxFit.cover,
                  ),
                ),
                CustomRow(title: 'Name', displayData: clientInfo.name ?? 'N/A'),
                CustomRow(title: 'Email', displayData: clientInfo.email ?? 'N/A'),
                CustomRow(title: 'Mobile', displayData: clientInfo.phoneNumber ?? 'N/A'),
                CustomRow(title: 'Address', displayData: clientInfo.address?.city ?? 'N/A'),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 12.w),
                  child: DottedBorderContainer(
                    child: Container(
                      height: 200.h,
                      width: double.infinity,
                      child: Center(
                        child: serviceController.selectedImage != null
                            ? Image.file(
                          serviceController.selectedImage!,
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                            : Image.asset('assets/images/image_placeHolder.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
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
                        child: Text('Description', style: AppStyles.fontSize18(color: AppColors.color575757)),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(serviceController.descriptionTextController.text.trim()),
                      ),
                    ],
                  ),
                ),
                // Recent Clients section
                SizedBox(height: 10.h),
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
                        child: Text('Added Point ', style: AppStyles.fontSize18(color: AppColors.color575757)),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < serviceController.pointList.length; i++)
                              Text('${i + 1}. ${serviceController.pointList[i]}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PriceDetailWidget(
                      title: _profileController.selectedList[index].treatmentTitle,
                      price: _profileController.selectedList[index].price.toString(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  itemCount: _profileController.selectedList.length,
                ),
                Divider(color: AppColors.blackColor),
                PriceDetailWidget(title: 'Full Cost', price: '800'),
                PriceDetailWidget(title: 'Discount ', price: '80'),
                Divider(),
                PriceDetailWidget(title: 'Final Cost', price: '720'),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              Get.toNamed(AppRoutes.appoinmentCalenderScreen);
                            },
                            prefixIcon: Icon(Icons.calendar_month),
                            text: 'Make Appointment',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            prefixIcon: Icon(Icons.send),
                            text: 'Sent',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            prefixIcon: Icon(Icons.save),
                            text: 'Save',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            prefixIcon: Icon(Icons.print),
                            text: 'Print',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    ),
                    // Paid/unpaid
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.scale(
                                      scale: 1.2,
                                      child: Checkbox(
                                          value: !isPaid,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isPaid = !(value ?? false);
                                            });
                                          },
                                          activeColor: AppColors.redColor),
                                    ),
                                    Text(
                                      'Unpaid',
                                      style: TextStyle(color: AppColors.redColor),
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
                ),
                SizedBox(height: 10.h),
                CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.createNewChartStepFiveScreen);
                    },
                    text: 'Finished'),
                SizedBox(height: 10.h),
              ],
            );
          }),
        ),
      ),
    );
  }
}
