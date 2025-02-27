import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_constants.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/gridview_tile.dart';
import 'package:thera_track_app/views/screens/Home/appDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Obx(() {
                var profileData = _profileController.profileInformationModel
                    .value;
                return Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConstants.imageBaseUrl}${profileData.profileImage}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(
                          child: CupertinoActivityIndicator(
                            radius: 16.r,
                            color: AppColors.primaryColor,
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 24.r, color: Colors.black),
                  ),
                );
              }
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Good Evening',
                    style: AppStyles.fontSize14(color: AppColors.whiteColor),
                  ),
                  Text(
                    'Setup Your Account',
                    style: AppStyles.fontSize16(color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            GridViewTile(
              child: SvgPicture.asset(AppIcons.newChart),
              label: 'Create New Chart',
              onTap: () {
                Get.toNamed(AppRoutes.createNewChartStepOneScreen);
              },
            ),
            GridViewTile(
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('01', style: TextStyle(fontSize: 18.sp)),
                ),
              ),
              label: 'Notification',
              onTap: () {
                Get.toNamed(AppRoutes.notificationScreen);
              },
            ),
            GridViewTile(
              child: SvgPicture.asset(AppIcons.chartArchive),
              label: 'Chart Archive',
              onTap: () {
                Get.toNamed(AppRoutes.chartArchiveScreen);
              },
            ),
            GridViewTile(
              child: SvgPicture.asset(AppIcons.contactIcon),
              label: 'Contacts',
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String selectedOption = prefs.getString(AppConstants.selectedOption) ?? "Human";

                if (selectedOption == "Human") {
                  Get.toNamed(AppRoutes.humanContactsScreen);
                } else {
                  Get.toNamed(AppRoutes.animalContactsScreen);
                }
              },
            ),
            GridViewTile(
              child: SvgPicture.asset(AppIcons.appointmentIcon),
              label: 'Appointments',
              onTap: () {
                Get.toNamed(AppRoutes.appointmentScreen);
              },
            ),
            GridViewTile(
              child: SvgPicture.asset(AppIcons.offlineIcon),
              label: 'Offline Files',
              onTap: () {
                Get.toNamed(AppRoutes.offLineFileScreen);
              },
            ),
            GridViewTile(
              child: SvgPicture.asset(AppIcons.inventoryIcon),
              label: 'Inventory',
              onTap: () {
                Get.toNamed(AppRoutes.inventoryScreen);
              },
            ),
            GridViewTile(
              child: SvgPicture.asset(AppIcons.walletIcon),
              label: 'Wallet',
              onTap: () {
                Get.toNamed(AppRoutes.walletDetailsScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
