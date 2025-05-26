import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_list_tile.dart';

class AnimalContactDetailsScreen extends StatefulWidget {
  const AnimalContactDetailsScreen({super.key});

  @override
  State<AnimalContactDetailsScreen> createState() => _AnimalContactDetailsScreenState();
}

class _AnimalContactDetailsScreenState extends State<AnimalContactDetailsScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  late final String animalId;

  @override
  void initState() {
    super.initState();
    animalId = Get.parameters['id'] ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (animalId.isNotEmpty) {
        profileController.getAnimalDetails(id: animalId);
      } else {
        Get.snackbar('Error', 'No animal ID provided');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Obx(() => Text(
          profileController.getAnimalData.value.name ?? 'Animal Details',
          style: AppStyles.fontSize16(fontWeight: FontWeight.w500),
        )),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: InkWell(
              onTap: () => Get.toNamed(AppRoutes.editAnimalContactDetailsScreen, parameters: {'id': animalId}),
              child: SvgPicture.asset(AppIcons.editIcon, color: AppColors.blackColor),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (profileController.showLoading.value) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 32.r,
              color: CupertinoColors.activeBlue,
            ),
          );
        }

        final animal = profileController.getAnimalData.value;
        if (animal.name == null) {
          return Center(child: Text('No animal data found', style: AppStyles.fontSize16()));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              _buildDetailSection('Name', animal.name),
              _buildDetailSection('Age', animal.age?.toString()),
              _buildDetailSection('Breed', animal.breed),
              _buildDetailSection('Gender', animal.gender),
              _buildDetailSection('Height', animal.height?.toString()),
              _buildDetailSection('Color', animal.color),
              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailSection(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.fontSize16(
          fontWeight: FontWeight.w400,
          color: AppColors.color424242,
        )),
        SizedBox(height: 8.h),
        CustomListTile(title: value ?? 'N/A'),
        SizedBox(height: 8.h),
      ],
    );
  }
}