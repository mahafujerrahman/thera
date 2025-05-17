import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:thera_track_app/controller/localization_controller.dart';
import 'package:thera_track_app/controller/theme_controller.dart';
import 'package:thera_track_app/firebase_options.dart';
import 'package:thera_track_app/service/firebase_service.dart';
import 'package:thera_track_app/utils/app_constants.dart';
import 'package:thera_track_app/utils/message.dart';

import 'controller/payment/keys.dart';
import 'helpers/di.dart' as di;
import 'helpers/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings();

  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Map<String, Map<String, String>> _languages = await di.init();
  NotificationHelper.getFcmToken();
  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GetMaterialApp(
                title: AppConstants.APP_NAME,
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                // theme: themeController.darkTheme ? dark(): light(),
                 // theme: light(),
                defaultTransition: Transition.topLevel,
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode),
                transitionDuration: const Duration(milliseconds: 500),
                getPages: AppRoutes.page,
                initialRoute: AppRoutes.splashScreen,
              );
            });
      });
    });
  }
}
