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

class AnimalStepThreeScreen extends StatefulWidget {
  @override
  _AnimalStepThreeScreenState createState() => _AnimalStepThreeScreenState();
}

class _AnimalStepThreeScreenState extends State<AnimalStepThreeScreen> {
  TextEditingController searchController = TextEditingController();
  final ClientController clientController = Get.put(ClientController());
  var parameter = Get.parameters;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      clientController.getAnimalUnderOneClient('${parameter['clientID']}');
      print('================>> client id ${parameter['clientID']}');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step 3',style: AppStyles.fontSize16(),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            children: [
              CustomHeaderWithSearch(
                titleText: 'Animal',
                actionChild: InkWell(
                    onTap: (){
                    Get.toNamed(AppRoutes.horseDetailsScreen);
                    },
                    child: Row(
                      children: [
                        Text('Add Animal'),
                        SizedBox(width: 4.w),
                        Icon(Icons.add,size: 15.sp),
                      ]

                    )),
                searchController: searchController),

              // Recent Clients section
              SizedBox(height: 10.h),
              Obx((){
               return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: clientController.getAnimalUnderOneClientModel.length,
                  itemBuilder: (context, index) {
                    var displayData =  clientController.getAnimalUnderOneClientModel[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(displayData.name),
                              SizedBox(width: 8.w),

                              Row(
                                children: [
                                  Text('Previous Chart :',style: AppStyles.fontSize12()),
                                  Text('15 Jan,2025',style: AppStyles.fontSize12(color: AppColors.redColor)),
                                ],
                              ),

                            ],
                          ),
                          trailing: SvgPicture.asset(AppIcons.rightArrow),
                          onTap: () {
                            // Get.toNamed(AppRoutes.horseDetailsScreen);
                             Get.toNamed(AppRoutes.createNewChartStepFourScreen);
                          },
                        ),
                        Divider(color: AppColors.secondaryColor),
                      ],
                    );
                  },
                );
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}
