import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:thera_track_app/Utils/app_constants.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';

class NotificationHelper {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> getFcmToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      PrefsHelper.setString(AppConstants.fcmToken, fcmToken);
    }
    print('FCM Token: $fcmToken');
  }
}
