import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/style.dart';

class HumanContactsScreen extends StatefulWidget {
  @override
  State<HumanContactsScreen> createState() => _HumanContactsScreenState();
}

class _HumanContactsScreenState extends State<HumanContactsScreen> {

  ClientController _clientController = Get.put(ClientController());

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_){
     // _clientController.getAllClientInfo();
    // _clientController.getClientWithAnimal('Cat');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Human Contacts',style: AppStyles.fontSize16()),
          centerTitle: true,
        ),
        body: ListTile(
          onTap: () {
            Get.toNamed(AppRoutes.contactSearchScreen);
            //  _clientController.getClientWithAnimal('$animalName');
          },
          leading: Icon(Icons.account_circle_outlined),
          title: Text('Clients',style: AppStyles.fontSize16()),
        ),
    );
  }
}