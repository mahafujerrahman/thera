import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/utils/style.dart';

class AnimalListScreen extends StatefulWidget {
  const AnimalListScreen({super.key});

  @override
  State<AnimalListScreen> createState() => _AnimalListScreenState();
}

class _AnimalListScreenState extends State<AnimalListScreen> {
  TextEditingController searchController = TextEditingController();

  ClientController _clientController = Get.put(ClientController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clientController.getAnimalUnderOneClient("${parameter['clientId']}");
       _clientController.getClientWithAnimal("${parameter['animalName']}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal List', style: AppStyles.fontSize16()),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_clientController.getOneClientAnimalList.isEmpty) {
          return Center(child:Text('No Data found!'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _clientController.getOneClientAnimalList.length,
              itemBuilder: (context, index) {
                var displayData = _clientController.getOneClientAnimalList[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(displayData.name ?? 'N/A'),
                      trailing: SvgPicture.asset(AppIcons.rightArrow),
                      onTap: () {
                        Get.toNamed(AppRoutes.animalContactDetailsScreen);
                      },
                    ),
                    Divider(color: AppColors.secondaryColor),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
