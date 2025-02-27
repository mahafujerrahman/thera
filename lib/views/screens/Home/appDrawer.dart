import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_constants.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/app_images.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
           Radius.circular(16),
        ),
      ),
      child: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
        DrawerHeader(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
        ),
        child:  Image.asset(
          AppImages.appLogo,
          fit: BoxFit.cover,
        ),
      ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.accountSetUp,color: Colors.white),
              title: Text('Account Setup',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                Get.toNamed(AppRoutes.accountSetUpScreen);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.personIcon,color: Colors.white),
              title: Text('Your Details',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                Get.toNamed(AppRoutes.yourDetailsScreen);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.treatMentIcon,color: Colors.white),
              title: Text('Treatments',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                Get.toNamed(AppRoutes.treatmentScreen);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.paidIcon,color: Colors.white),
              title: Text('Paid',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                  Get.toNamed(AppRoutes.paidDetailsScreen);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.treatMentIcon),
              title: Text('Unpaid',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                Get.toNamed(AppRoutes.unPaidDetailsScreen);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.unPaidIcon),
              title: Text('Feedback',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                Get.toNamed(AppRoutes.feedbackScreen);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.settingIcon),
              title: Text('Advance Setting',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                  Get.toNamed(AppRoutes.advanceSettingsScreen);
              },
            ),
            SizedBox(height: 100.h),
            // ================================== >>>>
            ListTile(
              leading: SvgPicture.asset(AppIcons.logOut),
              title: Text('Log Out',style: TextStyle(color: AppColors.whiteColor),),
              onTap: () {
                // Clear user data on logout
              PrefsHelper.remove(AppConstants.isLogged);
              PrefsHelper.remove(AppConstants.bearerToken);
         /*       await PrefsHelper.remove(AppConstants.userId);*/

                Get.toNamed(AppRoutes.signInScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
