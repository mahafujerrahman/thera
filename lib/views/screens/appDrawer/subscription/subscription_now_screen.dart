import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:thera_track_app/controller/clientController/subscription_controller.dart';
import 'package:thera_track_app/controller/payment/payment_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/screens/appDrawer/subscription/innerWidget/subscriptionCard.dart';

class SubscriptionNowScreen extends StatefulWidget {
  const SubscriptionNowScreen({super.key});

  @override
  State<SubscriptionNowScreen> createState() => _SubscriptionNowScreenState();
}

class _SubscriptionNowScreenState extends State<SubscriptionNowScreen> {
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());
  PaymentController paymentController = Get.put(PaymentController());

  late final String subscriptionId;

  @override
  void initState() {
    super.initState();
    // Initialize subscriptionId immediately
    subscriptionId = Get.parameters['subscriptionId'] ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      subscriptionController.getOneSubscriptionDetails(subscriptionID: subscriptionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayData = subscriptionController.getOneSubscriptionList.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription', style: AppStyles.fontSize20(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (subscriptionController.showLoading.value) {
          return Center(
            child: CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor),
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
        final displayData = subscriptionController.getOneSubscriptionList.value;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
          child: SubscriptionCard(
            planName: displayData.duration ?? '',
            price: displayData.price!,
            feature1: displayData.advantage1 ?? '',
            feature2: displayData.advantage2 ?? '',
            feature3: displayData.advantage3 ?? '',
            billingCycle: 'Monthly',
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: CustomButton(
          onTap: () {
            var logger = Logger();
            logger.i('======>> Package ID: ${displayData.id}');
           /* paymentController.paymentSheetInitialization(
              displayData.price.toString(), // amount
              "USD",                        // currency
              context,                      // build context
              displayData.id ?? '',         // subscriptionId (fallback to empty string)
            );*/
          },
          text: 'Subscribe Now',
        ),
      ),
    );
  }
}

