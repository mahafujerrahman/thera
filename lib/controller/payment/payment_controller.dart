import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:thera_track_app/controller/payment/keys.dart';
import 'package:thera_track_app/helpers/route.dart';
import 'package:thera_track_app/service/api_checker.dart';
import 'package:thera_track_app/service/api_client.dart';
import 'package:thera_track_app/service/api_constants.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? internetPaymentData;
  String? currentSubscriptionId;

  var loading = false.obs;

  // Show Payment Sheet and handle success/failure
  Future<void> showPaymentSheet(BuildContext context, String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) async {
        var logger = Logger();

        logger.i('======>> Payment Successful Response: ${internetPaymentData.toString()}');

        final paymentIntentId = internetPaymentData?['id'] ?? '';

        if (currentSubscriptionId != null && paymentIntentId.isNotEmpty) {
          logger.w("joy bangla");

          return;
          // Call backend API to confirm payment success
          await subcriptionPaymentSuccess(currentSubscriptionId!, paymentIntentId, 'USD');
        } else {
          logger.w('subscriptionId or paymentIntentId is missing');
        }
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

  // Create Payment Intent on Stripe server
  Future<Map<String, dynamic>?> makeInternetForPayment(String amountToBeCharge, String currency) async {
    double amount = double.parse(amountToBeCharge);
    try {
      Map<String, dynamic> paymentInfo = {
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
      final jsonResponse = jsonDecode(responseFromStripe.body);
      internetPaymentData = jsonResponse;
      return jsonResponse;
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

  // Initialize Payment Sheet and show it
  Future<void> paymentSheetInitialization(
      String amountToBeCharge, String currency, BuildContext context, String subscriptionId) async {
    try {
      currentSubscriptionId = subscriptionId;
      internetPaymentData = await makeInternetForPayment(amountToBeCharge, currency);

      if (internetPaymentData != null) {
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

  // Call backend API to confirm payment success
  Future<void> subcriptionPaymentSuccess(String subscriptionId, String stripePaymentId, String currency) async {
    loading(true);
    try {
      var body = {
        "subscriptionId": subscriptionId,
        "stripPaymentId": stripePaymentId,
        "currency": currency
      };
      var headers = {'Content-Type': 'application/json'};
      var response = await ApiClient.postData(ApiConstants.createPaymentEndPoint,
          jsonEncode(body), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.toNamed(AppRoutes.paymentSuccessfulScreen);
        print('Payment success confirmed on backend');
        Get.snackbar('Success', response.body['message']);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print("Error calling payment success API: $e");
      Get.snackbar('Error', 'Failed to confirm payment success');
    } finally {
      loading(false);
    }
  }
}
