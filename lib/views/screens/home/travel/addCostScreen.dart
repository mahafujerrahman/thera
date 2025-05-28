import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/travel/travel_controller.dart';
import 'package:thera_track_app/helpers/imageHelper.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/dotted_border_container.dart';

class CostAddScreen extends StatefulWidget {
  CostAddScreen({Key? key}) : super(key: key);

  @override
  State<CostAddScreen> createState() => _CostAddScreenState();
}

class _CostAddScreenState extends State<CostAddScreen> {
  final TravelController travelController = Get.put(TravelController());

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
              _buildTextField('Departure', travelController.departureCRTL, TextInputType.text),
              _buildTextField('Destination', travelController.destinationCRTL, TextInputType.text),
              _buildTextField('Distance', travelController.distanceCRTL, TextInputType.number),
              _buildTextField('Food', travelController.foodCRTL, TextInputType.number),
              _buildTextField('Gas', travelController.gasCRTL, TextInputType.number),
              _buildTextField('Other', travelController.otherCRTL, TextInputType.number),
              SizedBox(height: 20.h),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _image != null
                      ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
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
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
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
                          alignment: Alignment.center,
                          child: Text(
                            'Click to browse or \ndrag and drop your files',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onTap: () {
                  if (selectedImage == null) {
                    Get.snackbar('Error', 'Please select a receipt image.');
                    return;
                  }

                  int? distance = int.tryParse(travelController.distanceCRTL.text.trim());
                  int? food = int.tryParse(travelController.foodCRTL.text.trim());
                  int? gas = int.tryParse(travelController.gasCRTL.text.trim());
                  int? other = int.tryParse(travelController.otherCRTL.text.trim());

                  travelController.addTravelExpenses(
                    departure: travelController.departureCRTL.text.trim(),
                    destination: travelController.destinationCRTL.text.trim(),
                    distance: distance,
                    food: food,
                    gas: gas,
                    other: other,
                    receiptImages: selectedImage!,
                  );
                },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
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
                child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    keyboardType: keyboardType,
                    controller: controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
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
