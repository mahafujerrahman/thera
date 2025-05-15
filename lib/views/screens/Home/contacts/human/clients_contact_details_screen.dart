import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/app_strings.dart';
import 'package:thera_track_app/utils/style.dart';


import 'package:thera_track_app/views/base/custom_list_tile.dart';

class ClientsContactDetailsScreen extends StatefulWidget {
  const ClientsContactDetailsScreen({super.key});

  @override
  State<ClientsContactDetailsScreen> createState() => _ClientsContactDetailsScreenState();
}

class _ClientsContactDetailsScreenState extends State<ClientsContactDetailsScreen> {
  final TextEditingController fullNameCTRl = TextEditingController();
  final TextEditingController emailCTRl = TextEditingController();
  final TextEditingController addressCTRl = TextEditingController();

  ClientController _clientController=Get.put(ClientController());

  var parameter = Get.parameters;

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_){
      _clientController.clientDetailsByID("${parameter['clientId']}");
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      //=============================> AppBar Section <=======================
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Obx(() {
          final clientInfo = _clientController.getClientInfoByIdModel.value;
          return Text(
            clientInfo.name ?? "Client Details",
            style: AppStyles.fontSize16(fontWeight: FontWeight.w500),
          );
        }),

        centerTitle: true,
        actions: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.h),
            child: InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.editContactDetailsScreen);
                },
                child: SvgPicture.asset(AppIcons.editIcon,color:AppColors.blackColor)),
          ),
        ],
      ),
        //=======================================>> Body Section <<===============================
      body:Obx ((){
        var clientInfo = _clientController.getClientInfoByIdModel.value;
        return SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.h,vertical: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                //Full Name
                Text(AppStrings.nameText,style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                SizedBox(height: 8.h),
                CustomListTile(title: '${clientInfo.name}'),
                //Address
                Text('City',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242),),
                SizedBox(height: 8.h),
                CustomListTile(title: '${clientInfo.city}'),
                //State
                Text('Zip Code', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: '${clientInfo.zip}'),
                // Mobile
                SizedBox(height: 8.h),
                Text('Mobile', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: '${clientInfo.phoneNumber}'),
                // Email
                SizedBox(height: 8.h),
                Text('Email',style: AppStyles.fontSize16(fontWeight:FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: '${clientInfo.email}'),
                //Other
                Text('Other', style: AppStyles.fontSize16(fontWeight: FontWeight.w400,color: AppColors.color424242)),
                SizedBox(height: 8.h),
                CustomListTile(title: '${clientInfo.other}'),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      })
    );
  }

}
