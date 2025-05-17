import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/models/clients/treatMentModel.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_text_field.dart';

class TreatmentScreen extends StatefulWidget {
  @override
  _TreatmentScreenState createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {

  final ProfileController profileController = Get.put(ProfileController());


  List<GetAllTreatMentModel> selectedTreatements=<GetAllTreatMentModel>[];

  @override
  void initState() {
    super.initState();
    profileController.getAllTreatment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Treatment", style: AppStyles.fontSize14()),
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(()=>  Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (profileController.getAllTreatMentList.isNotEmpty)
                Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Treatment Name', style: TextStyle(color: Colors.black)),
                    SizedBox(width: 120.w),
                    Text('Price', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              // Display the list of treatments
              Expanded(
                child: profileController.getAllTreatMentList.isEmpty
                    ? Center(child: Text('No treatments added yet.', style: TextStyle(color: Colors.black)))
                    : Obx(()=> ListView.builder(
                  itemCount: profileController.getAllTreatMentList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 205.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.secondaryColor),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            padding: EdgeInsets.all(8.r),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                profileController.getAllTreatMentList[index].treatmentTitle!,
                                style: TextStyle(color: AppColors.color424242),
                              ),
                            ),
                          ),
                          // Price with Border
                          Container(
                            height: 44.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.secondaryColor),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            padding: EdgeInsets.all(8.r),
                            child: Center(
                              child: Text(
                                profileController.getAllTreatMentList[index].price!.toString(),
                                style: TextStyle(color: AppColors.color424242),
                              ),
                            ),
                          ),
                          // Delete Button (IconButton)
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              Get.dialog(
                                _confirmDialog(
                                  title: "Delete treatment!",
                                  message: "Are you sure you want to delete this treatment?",
                                  onConfirm: () {
                                    profileController.deleteSingelTreatment(treatmentID: '${profileController.getAllTreatMentList[index].id}');
                                    profileController.getAllTreatMentList.removeAt(index);
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.h,
                      child: CustomTextField(
                        controller:profileController.treatmentName,
                        contentPaddingVertical: 5,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 40.h,
                      child: CustomTextField(
                        controller: profileController.treatmentPrice,
                        contentPaddingVertical: 5,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx((){
                    return CustomButton(
                      width: 8.w,
                      height: 45.h,
                      loading: profileController.addTreatmentLoading.value,
                      onTap: (){
                        if (profileController.treatmentName.text.isEmpty) {
                          Get.snackbar('Error', 'Treatment name cannot be empty.');
                          return;
                        }

                        if (profileController.treatmentPrice.text.isEmpty || double.tryParse(profileController.treatmentPrice.text) == null) {
                          Get.snackbar('Error', 'Invalid price format. Please enter a valid number.');
                          return;
                        }
                        profileController.addTreatmentMethod(
                          treatmentTitle: profileController.treatmentName.text.trim(),
                          price:  profileController.treatmentPrice.text.trim(),
                        );
                      },
                      text: 'Add',
                    );
                  }

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//=====================>>> Confirm Dialog <<<==================
Widget _confirmDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  return AlertDialog(
    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel", style: TextStyle(color: Colors.grey)),
      ),
      TextButton(
        onPressed: () {
          Get.back();
          onConfirm();
        },
        child: Text("Yes", style: TextStyle(color: Colors.red)),
      ),
    ],
  );
}
