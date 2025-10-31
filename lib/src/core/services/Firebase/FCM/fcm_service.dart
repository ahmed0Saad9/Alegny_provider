// import 'package:Alegny_provider/src/core/constants/app_assets.dart';
// import 'package:Alegny_provider/src/core/services/Firebase/FCM/local_notification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
//
//
// class FCMService {
//   static late final FirebaseMessaging _messaging;
//   static Future<String?> get deviceToken  async {
//     final FirebaseMessaging fcm = FirebaseMessaging.instance;
//     String? deviceToken = '';
//     try {
//       deviceToken = await fcm.getToken();
//     } catch (e) {
//       if (kDebugMode) {
//         printDM('an error occur in fetch token');
//       }
//     }
//     if (kDebugMode) {
//       printDM("device Token is => $deviceToken");
//     }
//     return deviceToken;
//   }
//
//   static void firebaseNotificationConfiguration({VoidCallback ? onNotificationSent}) async {
//     _messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         if (kDebugMode) {
//           printDM("notification message.notification1 is >>> ${message.data}");
//         }
//         LocalNotificationService.launchNotification(message: message);
//         // onNotificationSent!();
//         /// on success
//         // final NotificationBadgeController numbersController = Get.find();
//         // numbersController.increaseCounts();
//
//         /// ----------
//
//       });
//     } else {
//       if (kDebugMode) {
//         printDM("permission declined by user");
//       }
//     }
//   }
// }
