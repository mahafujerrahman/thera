
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  State<EditContactDetailsScreen> createState() =>
      _EditContactDetailsScreenState();
}

class _EditContactDetailsScreenState extends State<EditContactDetailsScreen> {

  final TextEditingController fullNameCTRl = TextEditingController();
  final TextEditingController addressCTRl = TextEditingController();
  final TextEditingController postCodeCTRl = TextEditingController();
  final TextEditingController telephoneCTRl = TextEditingController();
  final TextEditingController emailCTRl = TextEditingController();
  final TextEditingController otherCTRl = TextEditingController();

  final ClientController clientController = Get.put(ClientController());

  @override
  void initState() {
    super.initState();
    final profileData = clientController.getClientInfoByIdModel.value;
    fullNameCTRl.text = profileData.name ?? '';
    addressCTRl.text = profileData.address?.city ?? '';
    postCodeCTRl.text = profileData.address?.zip ?? '';
    telephoneCTRl.text = profileData.phoneNumber ?? 'N/A';
    emailCTRl.text = profileData.email ?? 'N/A';
    otherCTRl.text = profileData.other ?? 'N/A';
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
              Text('Address',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: addressCTRl,
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
              Text('Postcode',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: postCodeCTRl,
                hintText: 'Enter your postcode',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your postcode";
                  }
                  return null;
                },
              ),

              SizedBox(height: 8.h),

              ///====================>>> Telephone
              Text('Telephone',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: telephoneCTRl,
                hintText: 'Enter your Telephone',

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Telephone";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),

              Text('Mobile', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: telephoneCTRl,
                hintText: 'Enter your Telephone',

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Telephone";
                  }
                  return null;
                },
              ),
              /*IntlPhoneField(
                decoration: InputDecoration(
                  hintText: AppStrings.enterPhoneNumber,
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
                  ),
                ),
                showCountryFlag: true,
                initialCountryCode: 'US',
                flagsButtonMargin: EdgeInsets.only(left: 10.w),
                disableLengthCheck: true,
                dropdownIconPosition: IconPosition.trailing,
                onChanged: (phone) {
                  print("Phone===============> ${phone.completeNumber}");
                },
              ),*/

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
              CustomButton(
                  onTap: (){},
                  text: 'Update'),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

}
