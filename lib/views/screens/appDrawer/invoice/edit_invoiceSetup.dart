import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class EditInvoiceSetupScreen extends StatefulWidget {
  const EditInvoiceSetupScreen({super.key});

  @override
  State<EditInvoiceSetupScreen> createState() => _EditInvoiceSetupScreenState();
}

class _EditInvoiceSetupScreenState extends State<EditInvoiceSetupScreen> {

  final ProfileController _profileController = Get.put(ProfileController());
  TextEditingController institutionCTRl = TextEditingController();
  TextEditingController streetCTRl = TextEditingController();
  TextEditingController cityCTRl = TextEditingController();
  TextEditingController townCTRl = TextEditingController();
  TextEditingController zipcodeCTRl = TextEditingController();
  TextEditingController phoneCTRl = TextEditingController();
  TextEditingController emailCTRl = TextEditingController();
  TextEditingController websiteCTRl = TextEditingController();


  Uint8List? _image;
  File? selectedImage;

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
            'Edit Invoice Setup',
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
                            child: _image != null
                                ? Image.memory(
                              _image!,
                              fit: BoxFit.cover,
                            )
                                : CachedNetworkImage(
                              imageUrl: "https://your-image-url-or-placeholder.png",
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
                        )

                      ],
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: (){
                        showImagePickerOption(context);
                      },
                      child: Container(
                        width: 160.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyColor, width: 2.w),
                            borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.h),
                          child: Center(child: Row(
                            children: [
                              Icon(Icons.image,color: AppColors.greyColor),
                              SizedBox(width: 8.w),
                              Text('Add your logo',style: AppStyles.fontSize16(color: AppColors.greyColor)),
                            ],
                          )),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    // Institution Name
                    Text('Institution Name',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: institutionCTRl,
                      hintText: 'Type Insitution Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    // Street
                    Text('Street',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: streetCTRl,
                      hintText: 'Type Street',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Street";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    // City
                    Text('City', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: cityCTRl,
                      hintText: 'Type City',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your City";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    // Town
                    Text('Town', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: townCTRl,
                      hintText: 'Type Town',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Town";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    // Zib code
                    SizedBox(height: 8.h),
                    Text('Zip Code', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: zipcodeCTRl,
                      hintText: 'Type Zip Code',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Zip Code";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    // Phone
                    SizedBox(height: 8.h),
                    Text('Phone',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: phoneCTRl,
                      hintText: 'Type Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Phone Number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    // Email
                    SizedBox(height: 8.h),
                    Text('Email',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: emailCTRl,
                      hintText: 'Type Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    //===== Website
                    SizedBox(height: 8.h),
                    Text('Website',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: websiteCTRl,
                      hintText: 'Type Website',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your website";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(onTap: (){}, text: 'Update')
                  ],
                ),
              ),
            );
        }
        ));
  }
  // Show Image Picker Option
  void showImagePickerOption(BuildContext context) {
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
                      _pickImageFromGallery();
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 50.w,
                            color: AppColors.primaryColor,
                          ),
                          CustomText(text: 'Gallery'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 50.w, color: AppColors.primaryColor),
                          CustomText(text: 'Camera'),
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

  // Pick Image From Gallery
  Future _pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

  // Pick Image From Camera
  Future _pickImageFromCamera() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }
}
