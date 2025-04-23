import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thera_track_app/controller/payment/payment_controller.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/appDrawer/subscription/subscriptionCard.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  PaymentController paymentController = Get.put(PaymentController());


  final List<Map<String, dynamic>> subscriptionPlans = [
    {
      'planName': '12 Month',
      'price': 99.00,
      'feature': 'Unlimited Chart',
      'billingCycle': 'Monthly',
      'currentPlan': true,
    },
    {
      'planName': '6 Month',
      'price': 49.00,
      'feature': '50 Charts',
      'billingCycle': 'Monthly',
      'currentPlan': false,
    },
    {
      'planName': '1 Month',
      'price': 19.00,
      'feature': '10 Charts',
      'billingCycle': 'Monthly',
      'currentPlan': false,
    },
    // Add more plans here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription',style: AppStyles.fontSize20(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: subscriptionPlans.length,
        itemBuilder: (context, index) {
          var plan = subscriptionPlans[index];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    print('Pay Now  : ${plan['price']}');
                    paymentController.paymentSheetInitialization(
                        plan['price'].toString(),
                      "USD",
                      context
                    );
                  },
                  child: SubscriptionCard(
                    planName: plan['planName'],
                    price: plan['price'],
                    feature: plan['feature'],
                    billingCycle: plan['billingCycle'],
                    isCurrentPlan: plan['currentPlan'],
                  ),
                ),
              ),
              // Current Plan Label

            ],
          );
        },
      ),
    );
  }
}
