
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class EditContactDetailsScreen extends StatefulWidget {
  const EditContactDetailsScreen({super.key});

  @override
  State<EditContactDetailsScreen> createState() => _EditContactDetailsScreenState();
}

class _EditContactDetailsScreenState extends State<EditContactDetailsScreen> {

  final TextEditingController fullNameCTRl = TextEditingController();
  final TextEditingController cityCTRl = TextEditingController();
  final TextEditingController stateCTRl = TextEditingController();
  final TextEditingController zipCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();
  final TextEditingController emailCTRl = TextEditingController();
  final TextEditingController otherCTRl = TextEditingController();
  String clientId = '';

  final ClientController clientController = Get.put(ClientController());

  @override
  void initState() {
    super.initState();
    final profileData = clientController.getClientInfoByIdModel.value;
    fullNameCTRl.text = profileData.name ?? '';
    cityCTRl.text = profileData.city ?? '';
    stateCTRl.text = profileData.state ?? '';
    zipCTRl.text = profileData.zip ?? '';
    phoneNumberCTRl.text = profileData.phoneNumber ?? 'N/A';
    emailCTRl.text = profileData.email ?? 'N/A';
    otherCTRl.text = profileData.other ?? 'N/A';
    clientId = profileData.id ?? 'N/A';
    print('Client ID: $clientId');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text('Edit Client Information',style:AppStyles.fontSize16()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.h,vertical: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.nameText,style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: fullNameCTRl,
                hintText: AppStrings.fullName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your full name";
                  }
                  return null;
                },
              ),
              //Address
              SizedBox(height: 8.h),
              Text('City',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: cityCTRl,
                hintText: 'Enter your address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              ///====================>>> PostCode
              Text('State',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: stateCTRl,
                hintText: 'Enter your state',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your state";
                  }
                  return null;
                },
              ),

              SizedBox(height: 8.h),

              ///====================>>> Zip
              Text('Zip',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: zipCTRl,
                hintText: 'Enter your zip',

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your zip";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),

              Text('Phone Number', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: phoneNumberCTRl,
                hintText: 'Enter your Phone Number',

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Phone Number";
                  }
                  return null;
                },
              ),

              // Email
              SizedBox(height: 8.h),
              Text('Email',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller:emailCTRl,
                hintText: 'Enter Your email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
              ),

              // Other
              SizedBox(height: 8.h),
              Text('Other',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller:otherCTRl,
                hintText: 'Enter Your Other',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Other";
                  }
                  return null;
                },
              ),

              SizedBox(height: 12.h),
              Obx((){
                return  CustomButton(
                  loading: clientController.loading.value,
                    onTap: (){
                      clientController.editClientProfile(
                        clientId: clientId,
                        name: fullNameCTRl.text,
                        city: cityCTRl.text,
                        state: stateCTRl.text,
                        zip: zipCTRl.text,
                        phoneNumber: phoneNumberCTRl.text,
                        email: emailCTRl.text,
                        other: otherCTRl.text,
                      );
                    },
                    text: 'Update');
              }),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

}
