import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/controller/clientController/clientController.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
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

  final ClientController _clientController = Get.put(ClientController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var animalName = await PrefsHelper.getString(AppConstants.uniqueAnimal);
      _clientController.animalNameUnderClient(
        animalName: animalName,
          clientID: "${parameter['clientId']}"
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Name List', style: AppStyles.fontSize16()),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_clientController.showLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (_clientController.getAnimalNameList.isEmpty) {
          return Center(child:Text('No Data found!'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _clientController.getAnimalNameList.length,
              itemBuilder: (context, index) {
                var displayData = _clientController.getAnimalNameList[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(displayData.name),
                      trailing: SvgPicture.asset(AppIcons.rightArrow),
                      onTap: () {
                        Get.toNamed(AppRoutes.animalContactDetailsScreen,
                            parameters: {
                              "id": displayData.id,
                            }
                        );
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
