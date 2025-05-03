import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/innerWidget/customHeaderWithSearch_widget.dart';

class CreateNewChartStepOneScreen extends StatefulWidget {
  @override
  _CreateNewChartStepOneScreenState createState() => _CreateNewChartStepOneScreenState();
}

class _CreateNewChartStepOneScreenState extends State<CreateNewChartStepOneScreen> {
  TextEditingController searchController = TextEditingController();

  final ClientController clientController = Get.put(ClientController());

  @override
  void initState() {
    super.initState();
    clientController.getAllClientInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step 1',style: AppStyles.fontSize16(),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.w),
          onPressed: () {
            Get.toNamed(AppRoutes.homeScreen);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomHeaderWithSearch(
                titleText: 'Clients',
                actionChild: InkWell(
                    onTap: (){
                    Get.toNamed(AppRoutes.createNewChartStepTwoScreen);
                    },
                    child: Text('Add Client',style: AppStyles.fontSize14(color: AppColors.primaryColor,fontWeight: FontWeight.w500))),
                searchController: searchController),
              // Recent Clients section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50.h,
                    color: AppColors.secondaryColor,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Recent Clients',
                          style: AppStyles.fontSize16(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx((){
                    if (clientController.getClientInfoModel.value.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'No Client Available at this time.',
                                style: AppStyles.fontSize16(color: AppColors.greyColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: clientController.getClientInfoModel.length,
                      itemBuilder: (context, index) {
                        final clientData = clientController.getClientInfoModel[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(clientData.name ?? 'N/A',style: AppStyles.fontSize16(color: AppColors.blackColor)),
                              trailing: SvgPicture.asset(AppIcons.rightArrow),
                              onTap: () {
                                if(clientData.humanClient == true){
                                  Get.toNamed(AppRoutes.humanStepTwo);
                                }
                                if(clientData.humanClient == false){
                                  Get.toNamed(AppRoutes.horseDetailsScreen,parameters: {
                                    "clientID": '${clientData.id}'
                                  }); //animal
                                }
                              },
                            ),
                            Divider(color: AppColors.secondaryColor),
                          ],
                        );

                      },
                    );
                  }
                  ),
                ],
              ),
              SizedBox(height: 20),

              // ==========================>. All Clients section

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50.h,
                    color: AppColors.secondaryColor,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'All Clients',
                          style: AppStyles.fontSize16(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx((){
                    if (clientController.getClientInfoModel.value.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'No Client Available at this time.',
                                style: AppStyles.fontSize16(color: AppColors.greyColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: clientController.getClientInfoModel.length,
                      itemBuilder: (context, index) {
                        final clientData = clientController.getClientInfoModel[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(clientData.name ?? 'N/A',style: AppStyles.fontSize16(color: AppColors.blackColor)),
                              trailing: SvgPicture.asset(AppIcons.rightArrow),
                              onTap: () {
                                if(clientData.humanClient == true){
                                  Get.toNamed(AppRoutes.humanStepTwo); //human
                                }
                                if(clientData.humanClient == false){
                                  Get.toNamed(AppRoutes.createNewChartStepThreeScreen,parameters: {
                                    "clientID": '${clientData.id}'
                                  }); //animal
                                }

                              },
                            ),
                            Divider(color: AppColors.secondaryColor),
                          ],
                        );

                      },
                    );
                  }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
