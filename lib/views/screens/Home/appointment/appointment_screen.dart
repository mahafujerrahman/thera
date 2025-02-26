import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/clientController/appointmentController.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/helpers/time_formate.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/Home/chartArchive/innerWidget/chartArchive_card.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final AppointmentController appointmentController = Get.put(AppointmentController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appointmentController.getAllAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Appointments',
            style: AppStyles.fontSize16(),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (appointmentController.getAllAppointmentModel.isEmpty) {
            return Center(
                child: Text('No appointment added yet.', style: AppStyles.fontSize14(color: AppColors.greyColor)));
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
              itemCount:appointmentController.getAllAppointmentModel.length,
              itemBuilder: (context, index) {
                final displayData = appointmentController.getAllAppointmentModel[index];
                final String shortId = displayData.id != null && displayData.id!.length >= 6
                    ? displayData.id!.substring(0, 8)
                    : (displayData.id ?? 'N/A');

                return InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.appointmentDetailsScreen,
                        parameters: {
                      "screenType": "appointmentScreen",
                      "appointmentID" : displayData.id!
                    });

                  },
                  child: ChartCard(
                    id: shortId,
                    date: TimeFormatHelper.formatDate(DateTime.parse(displayData.createdAt.toString())),
                    name: displayData.clientId!.name!,
                  ),
                );
              },
            ),
          );
        }));
  }
}
