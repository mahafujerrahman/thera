import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thera_track_app/controller/clientController/invoice_controller.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class InvoiceSetupScreen extends StatefulWidget {
  const InvoiceSetupScreen({super.key});

  @override
  State<InvoiceSetupScreen> createState() => _InvoiceSetupScreenState();
}

class _InvoiceSetupScreenState extends State<InvoiceSetupScreen> {


  final InvoiceController invoiceController = Get.put(InvoiceController());
  File? selectedImage;
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      invoiceController.getInvoiceData().then((_) {
        // Initialize controllers after data is loaded
        if (invoiceController.invoiceInformationData.value != null) {
          final invoiceData = invoiceController.invoiceInformationData.value;
          invoiceController.institutionNameCRTL.text = invoiceData.institutionName ?? '';
          invoiceController.streetCRTL.text = invoiceData.street ?? '';
          invoiceController.cityCRTL.text = invoiceData.city ?? '';
          invoiceController.townCRTL.text = invoiceData.town ?? '';
          invoiceController.zipCodeCRTL.text = invoiceData.zipCode ?? '';
          invoiceController.phoneCRTL.text = invoiceData.phone ?? '';
          invoiceController.emailCRTL.text = invoiceData.emailAddress ?? '';
          invoiceController.websiteCRTL.text = invoiceData.website ?? '';
        }
      });
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
          if (invoiceController.isLoading.value) {
            return Center(child: CupertinoActivityIndicator(radius: 32.r, color:AppColors.primaryColor));
          }

          var invoiceData = invoiceController.invoiceInformationData.value;
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
                        Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children:  [
                                _image != null
                                    ? InkWell(
                                  onTap: (){
                                    showImagePickerOption(context);
                                  },
                                  child: Container(
                                    height: 120.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(color: AppColors.primaryColor),
                                      color: Colors.red,
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: MemoryImage(_image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                                    : InkWell(
                                  onTap: (){
                                    showImagePickerOption(context);
                                  },
                                  child: Container(
                                    height: 120.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(color: AppColors.primaryColor),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: invoiceData.invoiceImage != null && invoiceData!.invoiceImage!.isNotEmpty
                                            ? CachedNetworkImageProvider("${ApiConstants.imageBaseUrl}${invoiceData.invoiceImage}")
                                            : AssetImage("assets/images/image_placeHolder.png") as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                ),
                              ],
                            ),

                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.editInvoiceSetupScreen,
                                parameters: {
                              'invoiceID':invoiceData.id!
                            }
                            );
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
                    CustomTextField(
                      controller: invoiceController.institutionNameCRTL,
                      hintText: 'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Institution Name";
                        }
                        return null;
                      },
                    ),
                    // Street
                    Text('Street',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: invoiceController.streetCRTL,
                      hintText:'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Street";
                        }
                        return null;
                      },
                    ),
                    // City
                    Text('City', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: invoiceController.cityCRTL,
                      hintText:'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter city";
                        }
                        return null;
                      },
                    ),
                    // Town
                    Text('Town', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: invoiceController.townCRTL,
                      hintText:'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter town";
                        }
                        return null;
                      },
                    ),
                    // Zib code
                    SizedBox(height: 8.h),
                    Text('Zip Code', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: invoiceController.zipCodeCRTL,
                      hintText: 'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Zip Code";
                        }
                        return null;
                      },
                    ),
                    // Phone
                    SizedBox(height: 8.h),
                    Text('Phone',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: invoiceController.phoneCRTL,
                      hintText: 'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Phone";
                        }
                        return null;
                      },
                    ),
                    // Email
                    SizedBox(height: 8.h),
                    Text('Email',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: invoiceController.emailCRTL,
                      hintText: 'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Email";
                        }
                        return null;
                      },
                    ),
                    //===== Website
                    SizedBox(height: 8.h),
                    Text('Website',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: invoiceController.websiteCRTL,
                      hintText: 'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter website";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),

                      CustomButton(
                        color: (invoiceData.website == null || invoiceData.website!.isEmpty)
                            ? AppColors.primaryColor
                            : Colors.grey,
                          onTap: () {
                            invoiceController.createInvoice(image: selectedImage);
                          },
                          text: 'Create Invoice'
                      )
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
