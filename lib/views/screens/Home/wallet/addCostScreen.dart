import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thera_track_app/controller/wallet/wallet_controller.dart';
import 'package:thera_track_app/helpers/imageHelper.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text.dart';
import 'package:thera_track_app/views/base/dotted_border_container.dart';

class CostAddScreen extends StatefulWidget {

  CostAddScreen({Key? key}) : super(key: key);

  @override
  State<CostAddScreen> createState() => _CostAddScreenState();
}

class _CostAddScreenState extends State<CostAddScreen> {
WalletController walletController = Get.put(WalletController());

  Uint8List? _image;
File? selectedImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cost', style: AppStyles.fontSize16()),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField('Departure', walletController.departureController, TextInputType.text),
              _buildTextField('Destination', walletController.destinationController, TextInputType.text),
              _buildTextField('Distance', walletController.distanceController, TextInputType.number),
              _buildTextField('Food', walletController.foodController, TextInputType.number),
              _buildTextField('Gas', walletController.gasController, TextInputType.number),
              _buildTextField('Other', walletController.otherController, TextInputType.number),
              SizedBox(height: 20.h),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _image != null
                      ?  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w),
                        child: GestureDetector(
                            onTap: () {
                              ImagePickerHelper.showImagePickerOption(context, (File pickedImage) {
                                setState(() {
                                  selectedImage = pickedImage;
                                  _image = pickedImage.readAsBytesSync();
                                });
                              });
                            },
                        child: DottedBorderContainer(
                          child: Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 2.w, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(
                                    image: MemoryImage(_image!),
                                    fit: BoxFit.cover)),
                          )
                        ) ),
                      ):
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w),
                    child: InkWell(
                      onTap: () {
                        ImagePickerHelper.showImagePickerOption(context, (File pickedImage) {
                          setState(() {
                            selectedImage = pickedImage;
                            _image = pickedImage.readAsBytesSync();
                          });
                        });
                      },
                      child: DottedBorderContainer(
                          child: Container(
                            height: 200.h,
                            child: Center(
                                child: Text('Click to browse or \ndrag and drop your files',textAlign: TextAlign.center)),
                          )
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 20.h),
              CustomButton(onTap: () {
                if (selectedImage == null) {
                  Get.snackbar('Error', 'Please select a receipt image.');
                  return;
                }
                int? departure = int.tryParse(walletController.departureController.text.trim());
                int? distance = int.tryParse(walletController.distanceController.text.trim());
                int? food = int.tryParse(walletController.foodController.text.trim());
                int? gas = int.tryParse(walletController.gasController.text.trim());
                int? other = int.tryParse(walletController.otherController.text.trim());

                walletController.addTravelExpenses(
                    departure: departure,
                    destination: walletController.destinationController.text.trim(),
                    distance: distance,
                    food: food,
                    gas: gas,
                    other: other,
                    receiptImages: selectedImage!
                );

              }, text: 'Save'),
            ]
          ),
        )
      )
    );
  }

Widget _buildTextField(String label, TextEditingController controller, TextInputType keyboardType) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
    child: Container(
      height: 50.h,
      color: Colors.blue.shade100,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(12.r),
              color: Colors.blue.shade100,
              child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Container(
                color: Colors.white,
                child: TextFormField(
                  keyboardType: keyboardType, // Use the passed keyboardType
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 4.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
