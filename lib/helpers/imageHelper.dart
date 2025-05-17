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
                    onTap: () {
                      _pickImageFromGallery(onImagePicked);
                    },
                    child: SizedBox(
                      child: Column(
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
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera(onImagePicked);
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt,
                              size: 50, color: AppColors.primaryColor),
                          CustomText(text: 'Camera')
                        ],
                      ),
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

  // Pick image from gallery
  static Future _pickImageFromGallery(Function(File) onImagePicked) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    File selectedImage = File(returnImage.path);
    onImagePicked(selectedImage);
    Get.back();
  }

  // Pick image from camera
  static Future _pickImageFromCamera(Function(File) onImagePicked) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    File selectedImage = File(returnImage.path);
    onImagePicked(selectedImage);
    Get.back();
  }
}
