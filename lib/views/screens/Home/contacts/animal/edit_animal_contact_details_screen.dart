import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class EditAnimalContactDetailsScreen extends StatefulWidget {
  const EditAnimalContactDetailsScreen({super.key});

  @override
  State<EditAnimalContactDetailsScreen> createState() =>
      _EditAnimalContactDetailsScreenState();
}

class _EditAnimalContactDetailsScreenState extends State<EditAnimalContactDetailsScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  late final String animalId;



  @override
  void initState() {
    super.initState();
    animalId = Get.parameters['id'] ?? '';
    final profileData = profileController.getAnimalData.value;
    profileController.nameCTRl.text = profileData.name ?? '';
    profileController.ageCTRl.text = profileData.age?.toString() ?? '';
    profileController.breedCTRl.text = profileData.breed ?? '';
    profileController.genderCTRl.text = profileData.gender ?? '';
    profileController.heightCTRl.text = profileData.height?.toString() ?? '';
    profileController.colorCTRl.text = profileData.color ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'Edit ${profileController.nameCTRl.text} Information',
          style: AppStyles.fontSize16(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              Text(
                AppStrings.nameText,
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w400,
                  color: AppColors.color424242,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: profileController.nameCTRl,
                hintText: AppStrings.fullName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),

              // Age Field
              SizedBox(height: 8.h),
              Text(
                'Age',
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w400,
                  color: AppColors.color424242,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: profileController.ageCTRl,
                hintText: 'Enter age',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter age";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter valid number";
                  }
                  return null;
                },
              ),

              // Breed Field
              SizedBox(height: 8.h),
              Text(
                'Breed',
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w400,
                  color: AppColors.color424242,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: profileController.breedCTRl,
                hintText: 'Enter breed',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter breed";
                  }
                  return null;
                },
              ),

              // Gender Field
              SizedBox(height: 8.h),
              Text(
                'Gender',
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w400,
                  color: AppColors.color424242,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: profileController.genderCTRl,
                hintText: 'Enter gender',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter gender";
                  }
                  return null;
                },
              ),

              // Height Field
              SizedBox(height: 8.h),
              Text(
                'Height',
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w400,
                  color: AppColors.color424242,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: profileController.heightCTRl,
                hintText: 'Enter height',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter height";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter valid number";
                  }
                  return null;
                },
              ),

              // Color Field
              SizedBox(height: 8.h),
              Text(
                'Color',
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w400,
                  color: AppColors.color424242,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: profileController.colorCTRl,
                hintText: 'Enter color',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter color";
                  }
                  return null;
                },
              ),

              // Update Button
              SizedBox(height: 12.h),
              // In your onTap handler for the Update button:
              Obx(() {
                return CustomButton(
                  loading: profileController.loading.value,
                  onTap: () {
                    final age = int.tryParse(profileController.ageCTRl.text);
                    final height = int.tryParse(profileController.heightCTRl.text);

                    if (age == null) {
                      Get.snackbar('Error', 'Please enter a valid age number');
                      return;
                    }

                    if (height == null) {
                      Get.snackbar('Error', 'Please enter a valid height number');
                      return;
                    }

                    profileController.editClientAnimal(
                      animalId: animalId,
                      name: profileController.nameCTRl.text.trim(),
                      age: age,
                      breed: profileController.breedCTRl.text.trim(),
                      gender: profileController.genderCTRl.text.trim(),
                      height: height,
                      color: profileController.colorCTRl.text.trim(),
                    );
                  },



                  text: 'Update',
                );
              }),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}