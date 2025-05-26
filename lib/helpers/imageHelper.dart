import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/views/base/custom_text.dart';

class ImagePickerHelper {

  static void showImagePickerOption(BuildContext context, Function(File) onImagePicked) {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Get.back(); // dismiss bottom sheet immediately
                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        onImagePicked(File(pickedImage.path));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 50,
                          color: AppColors.primaryColor,
                        ),
                        CustomText(text: 'Gallery')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Get.back(); // dismiss bottom sheet immediately
                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (pickedImage != null) {
                        onImagePicked(File(pickedImage.path));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt,
                            size: 50, color: AppColors.primaryColor),
                        CustomText(text: 'Camera')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
