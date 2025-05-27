import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:thera_track_app/controller/clientController/subscription_controller.dart';
import 'package:thera_track_app/controller/payment/payment_controller.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/appDrawer/subscription/innerWidget/subscriptionCard.dart';

class SubscriptionNowScreen extends StatefulWidget {
  const SubscriptionNowScreen({super.key});

  @override
  State<SubscriptionNowScreen> createState() => _SubscriptionNowScreenState();
}

class _SubscriptionNowScreenState extends State<SubscriptionNowScreen> {


  final SubscriptionController subscriptionController = Get.put(SubscriptionController());
  late final String subscriptionId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      subscriptionId = Get.parameters['subscriptionId'] ?? '';
      subscriptionController.getOneSubscriptionDetails(
          subscriptionID: subscriptionId );
      });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription',style: AppStyles.fontSize20(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (subscriptionController.isLoading.value) {
          return Center(
              child: CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor)
          );
        }
        if (subscriptionController.subscriptionPlanList.isEmpty) {
          return Center(
            child: Text(
              'No Subscription Plan at this moment.',
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
          );
        }
        final displayData = subscriptionController.getAnimalData.value;
        return SubscriptionCard(
          planName: displayData.duration,
          price: displayData.price,
          feature1:displayData.advantage1,
          feature2:displayData.advantage2,
          feature3:displayData.advantage3,
          billingCycle: 'Monthly',
          isCurrentPlan: displayData.currentPlan,
        ),
      },
      ),
    );
  }
}
