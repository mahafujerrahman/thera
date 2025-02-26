import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/chartArchive_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/helpers/time_formate.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/Home/chartArchive/innerWidget/chartArchive_card.dart';

class ChartArchiveScreen extends StatefulWidget {
  const ChartArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ChartArchiveScreen> createState() => _ChartArchiveScreenState();
}

class _ChartArchiveScreenState extends State<ChartArchiveScreen> {
  final ChartArchiveController chartArchiveController = Get.put(ChartArchiveController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chartArchiveController.getAllChartArchive();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chart Archive',
          style: AppStyles.fontSize16(),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (chartArchiveController.getAllChartArchiveModel.isEmpty) {
          return  Center(child: Text('No Chart Archive added yet.',style: AppStyles.fontSize14(color: AppColors.greyColor)));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.5,
            ),
            itemCount: chartArchiveController.getAllChartArchiveModel.length,
            itemBuilder: (context, index) {
              final displayData = chartArchiveController.getAllChartArchiveModel[index];
              final String shortId = displayData.id != null && displayData.id!.length >= 6
                  ? displayData.id!.substring(0, 8)
                  : (displayData.id ?? 'N/A');

              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chartArchiveDetailsScreen,
                    parameters: {
                      "screenType": "chartArchiveScreen",
                      "serviceID" : displayData.id!
                    },
                  );
                },

                child: ChartCard(
                  id: shortId,
                  date: TimeFormatHelper.formatDate(DateTime.parse(displayData.createdAt.toString())),
                  name: displayData.name ?? 'N/A',
                  price: displayData.finalCost,
                  paidStatus: displayData.isPaid ?? false,
                ),
              );
            },

          ),
        );
      }),
    );
  }
}
