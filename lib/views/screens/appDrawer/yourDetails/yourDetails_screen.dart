import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_list_tile.dart';

class YourDetailsScreen extends StatefulWidget {
  const YourDetailsScreen({super.key});

  @override
  State<YourDetailsScreen> createState() => _YourDetailsScreenState();
}

class _YourDetailsScreenState extends State<YourDetailsScreen> {

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _profileController.getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=============================> AppBar Section <=======================
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'Your Details',
          style: AppStyles.fontSize16(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Obx((){
      var profileData = _profileController.profileInformationModel.value;
      if (_profileController.isLoading.value) {
        return Center(child: CupertinoActivityIndicator(radius: 32.r, color:AppColors.primaryColor));
      }
      return
      SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.h,vertical: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.editYourDetailsScreen);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor, width: 2.w),
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.primaryColor
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.h),
                          child: Center(child: Row(
                            children: [
                              Icon(Icons.edit,color: AppColors.whiteColor),
                              SizedBox(width: 8.w),
                              Text('Edit',style: AppStyles.fontSize16(color: AppColors.whiteColor)),
                            ],
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                //Full Name
                Text(AppStrings.nameText,style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                SizedBox(height: 8.h),
                CustomListTile(title: profileData.firstName  ?? 'N/A'),
                //Town
                Text('Town/City',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                SizedBox(height: 8.h),
                CustomListTile(title: profileData.city  ?? 'N/A'),
                //PostCode
                Text('Postcode', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: profileData.postCode  ?? 'N/A'),
                //Country
                Text('Country', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: profileData.country  ?? 'N/A'),
                // Mobile
                SizedBox(height: 8.h),
                Text('Mobile', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: profileData.phoneNumber  ?? 'N/A'),
                // Email
                SizedBox(height: 8.h),
                Text('Main Email Address',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: profileData.email  ?? 'N/A'),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      }
    ));
  }

}
