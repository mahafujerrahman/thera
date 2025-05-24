import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:thera_track_app/controller/payment/keys.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/views/base/custom_button.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? internetPaymentData;

  // Show Payment Sheet
  Future<void> showPaymentSheet(BuildContext context, String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) {
        internetPaymentData = null;

        // Log the successful payment response
        var logger = Logger();
        logger.w('======>> Payment Successful Response: ${internetPaymentData.toString()}');



        // Show success message in AlertDialog instead of SnackBar
        showAlertDialog(context, amount);
      }).onError((error, stackTrace) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Failed!")),
        );
      });
    } on StripeException catch (error) {
      print("Stripe Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Stripe Error: $error")),
      );
    } catch (error) {
      print("General Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred!")),
      );
    }
  }

  // Make Internet Payment Request
  Future<Map<String, dynamic>?> makeInternetForPayment(
      String amountToBeCharge, String currency) async {
    double amount = double.parse(amountToBeCharge);
    try {
      Map<String, dynamic> paymentInfo = {
        //'amount': (int.parse(amountToBeCharge) * 100).toString(),
        'amount': (amount * 100).toInt().toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var responseFromStripe = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print('Response from Stripe: ${responseFromStripe.body}');
      return jsonDecode(responseFromStripe.body);
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

  // Initialize Payment Sheet
  Future<void> paymentSheetInitialization(
      String amountToBeCharge, String currency, BuildContext context) async {
    try {
      internetPaymentData =
      await makeInternetForPayment(amountToBeCharge, currency);

      if (internetPaymentData != null) {
        // Initialize payment sheet with the correct client_secret
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: internetPaymentData!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Mahafujer Rahman",
          ),
        ).then((val) {
          print("Payment sheet initialized: $val");
        }).catchError((error) {
          print("Error initializing payment sheet: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error initializing payment sheet: $error")),
          );
        });

        // Show the payment sheet after initialization
        showPaymentSheet(context, amountToBeCharge);
      } else {
        print("Failed to get payment data.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to initialize payment sheet")),
        );
      }
    } catch (error) {
      print("Error during payment sheet initialization: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initializing payment sheet")),
      );
    }
  }

  //================== Show AlertDialog
  showAlertDialog(BuildContext context, String amount) {
    return showDialog(
      context: context,
      builder: (c) => AlertDialog(
        backgroundColor: AppColors.whiteColor,
        title: Text("Congratulation.", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
        content: Text("Return to the Home page \nto explore More Event. \n\nPayment Successful!", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),

        actions: [
          CustomButton(onTap: (){
            Get.toNamed(AppRoutes.homeScreen);
          }, text: 'Back to Home')
        ],
      ),
    );
  }
}
