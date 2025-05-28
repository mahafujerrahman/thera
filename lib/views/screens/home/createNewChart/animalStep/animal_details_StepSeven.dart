import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/controller/clientController/inventoryController.dart';
import 'package:thera_track_app/controller/clientController/service_controller.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_images.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_list_tile.dart';
import 'package:thera_track_app/views/base/custom_row.dart';
import 'package:thera_track_app/views/base/dotted_border_container.dart';
import 'package:thera_track_app/views/base/price_details_row.dart';
import 'package:thera_track_app/views/screens/Home/chartArchive/innerWidget/addpoint_textBox.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/innerWidget/detailsRow_widget.dart';

class AnimalServiceDetailsScreen extends StatefulWidget {
  const AnimalServiceDetailsScreen({super.key});

  @override
  State<AnimalServiceDetailsScreen> createState() =>
      _AnimalServiceDetailsScreenState();
}

class _AnimalServiceDetailsScreenState extends State<AnimalServiceDetailsScreen> {
  final TextEditingController fullNameCTRl = TextEditingController();
  final TextEditingController emailCTRl = TextEditingController();
  final TextEditingController addressCTRl = TextEditingController();

  final ClientController clientController = Get.put(ClientController());
  final ServiceController serviceController = Get.put(ServiceController());
  final InventoryController inventoryController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var clientID = await PrefsHelper.getString(AppConstants.createdServiceClientId);
      clientController.clientDetailsByID(clientID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double treatmentsCost = serviceController.selectedList.fold(0, (sum, item) {
      return sum + (item.price ?? 0);
    });
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      //=============================> AppBar Section <=======================
      appBar: AppBar(
        title: Text(
          'Animal - New Create Details',
          style: AppStyles.fontSize16(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.w),
          child: Obx(() {
            var clientInfo = clientController.getClientInfoByIdModel.value;

            // If clientInfo is null, display a loading spinner or placeholder
            if (clientInfo == null) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Center(
                  child: Image.asset(
                    height: 100.h,
                    AppImages.appLogo,
                    fit: BoxFit.cover,
                  ),
                ),
                CustomRow(title: 'Name', displayData: clientInfo.name ?? 'N/A'),
                CustomRow(title: 'Email', displayData: clientInfo.email ?? 'N/A'),
                CustomRow(title: 'Mobile', displayData: clientInfo.phoneNumber ?? 'N/A'),
                CustomRow(title: 'Address', displayData: clientInfo.city ?? 'N/A'),
                SizedBox(height: 10.h),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.h),
                  child: Text('Animal Details :',style: AppStyles.fontSize20(fontWeight: FontWeight.w600)),
                ),
                CustomRow(title: 'Animal Name', displayData:serviceController.name.text.trim()),
                CustomRow(title: 'Age', displayData: serviceController.age.text.trim()),
                CustomRow(title: 'Breed', displayData: serviceController.breed.text.trim()),
                CustomRow(title: 'Gender', displayData: serviceController.gender.text.trim()),
                CustomRow(title: 'Height', displayData: serviceController.height.text.trim()),
                CustomRow(title: 'Color', displayData: serviceController.color.text.trim()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 12.w),
                  child: DottedBorderContainer(
                    child: Container(
                      height: 200.h,
                      width: double.infinity,
                      child: Center(
                        child: serviceController.selectedImage != null
                            ? Image.file(
                          serviceController.selectedImage!,
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                            : Image.asset('assets/images/image_placeHolder.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.w),
                        child: Text('Description', style: AppStyles.fontSize18(color: AppColors.color575757)),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(serviceController.descriptionTextController.text.trim()),
                      ),
                    ],
                  ),
                ),
                // Recent Clients section
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.w),
                        child: Text('Added Point ', style: AppStyles.fontSize18(color: AppColors.color575757)),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < serviceController.pointList.length; i++)
                              Text('${i + 1}. ${serviceController.pointList[i]}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),
                Text(
                  "Treatments",
                  style: AppStyles.fontSize16(fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PriceDetailWidget(
                      title: serviceController.selectedList[index].treatmentTitle,
                      price: serviceController.selectedList[index].price.toString(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  itemCount: serviceController.selectedList.length,
                ),
                Divider(color: AppColors.blackColor.withOpacity(0.3)),
               // PriceDetailWidget(title: 'Treatments Subtotal', price: '$treatmentsCost'),

                // Equipment Section
                Text("Equipment", style: AppStyles.fontSize16(fontWeight: FontWeight.w600, color: AppColors.primaryColor),),
                SizedBox(height: 8.h),
                Obx(() {
                  double equipmentTotal = 0;
                  List<Widget> equipmentWidgets = [];

                  // Loop through all inventory items to find ones with quantity > 0
                  for (var item in inventoryController.allInventoryList) {
                    String itemId = item.id ?? '0';
                    int quantity = serviceController.getItemQuantity(itemId).value;
                    num price = item.pricePerOne ?? 0;

                    if (quantity > 0) {
                      num itemTotal = quantity * price;
                      equipmentTotal += itemTotal;

                      equipmentWidgets.add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "${item.productName ?? 'Unknown'} (${quantity}x ${price}\$)",
                                style: AppStyles.fontSize16(color: AppColors.color424242), overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text("${itemTotal.toStringAsFixed(2)} \$",
                              style: AppStyles.fontSize16(color: AppColors.color424242),
                            ),
                          ],
                        ),
                      );

                      equipmentWidgets.add(SizedBox(height: 8.h));
                    }
                  }

                  if (equipmentWidgets.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Text(
                        "No equipment selected",
                        style: AppStyles.fontSize16(color: AppColors.colorB1B1B1),
                      ),
                    );
                  }

                  // Calculate the full cost (treatments + equipment)
               /*   double fullCost = treatmentsCost + equipmentTotal;

                  // Set full cost in controller
                  serviceController.fullCost.value = fullCost;
                  serviceController.calculateFinalCost();*/

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...equipmentWidgets,
                      Divider(color: AppColors.blackColor.withOpacity(0.3)),
                     // PriceDetailWidget(title: 'Equipment Subtotal', price: equipmentTotal.toStringAsFixed(2)),
                      SizedBox(height: 16.h),
                      PriceDetailWidget(title: 'Full Cost', price: serviceController.fullCost.toStringAsFixed(2)),
                    ],
                  );
                }),

                PriceDetailWidget(title: 'Discount ', price: serviceController.discount.value.toString()),
                Divider(),
                PriceDetailWidget(title: 'Final Cost',  price: serviceController.finalCost.value.toString()),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              Get.toNamed(AppRoutes.appoinmentCalenderScreen);
                            },
                            prefixIcon: Icon(Icons.calendar_month),
                            text: 'Make Appointment',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),
                        SizedBox(width: 10.w),
                      /*  Expanded(
                          child: CustomButton(
                            onTap: () {},
                            prefixIcon: Icon(Icons.send),
                            text: 'Sent',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),*/
                      ],
                    ),
                    SizedBox(height: 12.h),
                 /*   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            prefixIcon: Icon(Icons.save),
                            text: 'Save',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            prefixIcon: Icon(Icons.print),
                            text: 'Print',
                            textStyle: AppStyles.fontSize12(color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    ),*/
                    // Paid/unpaid
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Paid Container
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  serviceController.isPaid.value  = true;
                                });
                              },
                              child: Container(
                                height: 50.h,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.primaryColor),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.scale(
                                      scale: 1.2,
                                      child: Checkbox(
                                        value: serviceController.isPaid.value,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            serviceController.isPaid.value = value ?? false;
                                          });
                                        },
                                        activeColor: AppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      'Paid',
                                      style: TextStyle(color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          // Unpaid Container
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  serviceController.isPaid.value = false;
                                });
                              },
                              child: Container(
                                height: 50.h,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.redColor),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.scale(
                                      scale: 1.2,
                                      child: Checkbox(
                                          value: !serviceController.isPaid.value,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              serviceController.isPaid.value = !(value ?? false);
                                            });
                                          },
                                          activeColor: AppColors.redColor),
                                    ),
                                    Text(
                                      'Unpaid',
                                      style: TextStyle(color: AppColors.redColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                /*     Obx((){
                  return CustomButton(
                    //  loading: serviceController.createServiceLoading.value,
                      onTap: () {
                        serviceController.createServiceClient();
                      },
                      text: 'Finished');
                }*/
                CustomButton(
                    onTap: () {
                      serviceController.createServiceClient();
                    },
                    text: 'Finished'),
                SizedBox(height: 10.h),
              ],
            );
          }),
        ),
      ),
    );
  }
}
