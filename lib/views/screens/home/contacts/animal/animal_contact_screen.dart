import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';

class AnimalContactsScreen extends StatefulWidget {
  @override
  State<AnimalContactsScreen> createState() => _AnimalContactsScreenState();
}

class _AnimalContactsScreenState extends State<AnimalContactsScreen> {

ClientController _clientController=Get.put(ClientController());

  @override
  void initState() {

WidgetsBinding.instance.addPostFrameCallback((_){
  _clientController.clientAnimalList();
 // _clientController.getClientWithAnimal('Cat');
});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Contacts',style: AppStyles.fontSize16()),
        centerTitle: true,
      ),
      body:Obx(() {
        return _clientController.animalList.isEmpty
            ? Center(
          child: Text(
            "No animals added yet",
            style: AppStyles.fontSize16().copyWith(color: Colors.grey),
          ),
        )
            :  ListView.builder(
          itemCount: _clientController.animalList.length,
          itemBuilder: (context, index) {
            var animalName = _clientController.animalList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () async  {
                    await PrefsHelper.setString(AppConstants.uniqueAnimal, animalName);
                      Get.toNamed(AppRoutes.contactSearchScreen,
                        parameters: {
                          "animalName": "$animalName",
                        }
                      );
                    //_clientController.getClientWithAnimal('$animalName');
                    },
                    leading: Icon(Icons.account_circle_outlined),
                    title: Text(animalName,style: AppStyles.fontSize16()),

                  ),
                  Divider(color: AppColors.secondaryColor),
                ],
              ),
            );
          },
        );
      })
    );
  }
}