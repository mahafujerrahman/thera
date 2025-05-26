import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';

import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class CreateNewChartStepTwoScreen extends StatefulWidget {
  @override
  _CreateNewChartStepTwoScreenState createState() => _CreateNewChartStepTwoScreenState();
}

class _CreateNewChartStepTwoScreenState extends State<CreateNewChartStepTwoScreen> {

  TextEditingController searchController = TextEditingController();

  final ClientController addClientController = Get.put(ClientController());

  List<String> recentClients = [
    'Christopher Rogers',
    'Joshua Walker',

  ];
  List<String> allClients = [
    'Christopher Rogers',
    'Joshua Walker',

  ];

  @override
  void dispose() {
    addClientController.clearValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text('Step 2',style: AppStyles.fontSize16(),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Name
              Text(AppStrings.nameText, style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: addClientController.nameCtrl,
                hintText: AppStrings.enterName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              // Address
              Text('City', style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: addClientController.cityCtrl,
                hintText: AppStrings.enterName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your city";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              // State / Zip
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
                            Text('State', style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                            SizedBox(height: 8.h),
                            CustomTextField(
                              controller: addClientController.stateCtrl,
                              hintText: 'Enter State',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your State";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Zip', style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
                            SizedBox(height: 8.h),
                            CustomTextField(
                              controller: addClientController.zipCtrl,
                              hintText: 'Zip Code',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your Zip Code";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              // Phone Number
              Text('Phone Number', style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: addClientController.phoneNumberCtrl,
                hintText: 'Enter Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Phone Number";
                  }
                  return null;
                },
              ),

              // Email
              SizedBox(height: 8.h),
              Text('Email', style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: addClientController.emailCtrl,
                hintText: 'Enter Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Email";
                  }
                  return null;
                },
              ),
              // Email
              SizedBox(height: 8.h),
              Text('Other', style: AppStyles.fontSize16(fontWeight: FontWeight.w700)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller:addClientController.otherCtrl,
                hintText: 'Enter Other',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Other";
                  }
                  return null;
                },
              ),


              SizedBox(height: 12.h),
              Obx(() =>
                 CustomButton(
                   loading: addClientController.addClientLoading.value,
                     onTap: () {
                       addClientController.addClient();
                }, text: 'Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
