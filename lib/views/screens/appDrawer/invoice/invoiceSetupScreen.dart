import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_list_tile.dart';

class InvoiceSetupScreen extends StatefulWidget {
  const InvoiceSetupScreen({super.key});

  @override
  State<InvoiceSetupScreen> createState() => _InvoiceSetupScreenState();
}

class _InvoiceSetupScreenState extends State<InvoiceSetupScreen> {

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=============================> AppBar Section <=======================
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'Invoice Setup',
            style: AppStyles.fontSize16(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        backgroundColor: AppColors.whiteColor,
        body: Obx((){

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 104.h,
                          width: 104.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: CachedNetworkImage(
                              // imageUrl: "${ApiConstants.imageBaseUrl}${profileData.profileImage}",
                              imageUrl: "assets/images/image_placeHolder.png",

                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CupertinoActivityIndicator(
                                  radius: 12.r,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/image_placeHolder.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.editInvoiceSetupScreen);
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

                    SizedBox(height: 16.h),
                    // Institution Name
                    Text('Institution Name',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                    SizedBox(height: 8.h),
                    CustomListTile(title: 'Dhaka Collage'),
                    // Street
                    Text('Street',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                    SizedBox(height: 8.h),
                    CustomListTile(title:  'Rampura'),
                    // City
                    Text('City', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomListTile(title: 'Banasree'),
                    // Town
                    Text('Town', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomListTile(title: 'Dhaka'),
                    // Zib code
                    SizedBox(height: 8.h),
                    Text('Zip Code', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomListTile(title: '1200'),
                    // Phone
                    SizedBox(height: 8.h),
                    Text('Phone',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomListTile(title: '0175555555'),
                    // Email
                    SizedBox(height: 8.h),
                    Text('Email',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomListTile(title: 'maha@gmail.com'),
                    //===== Website
                    SizedBox(height: 8.h),
                    Text('Website',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomListTile(title: 'www.website.com'),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            );
        }
        ));
  }

}
