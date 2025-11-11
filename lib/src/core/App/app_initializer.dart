// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

/// Contains All The Methods needed to be run before MyApp Compiles
class AppInitializer {
  AppInitializer._();
  // static final LocalNotificationService _localNotificationService = LocalNotificationService();
  static Future<void> initializeApp() async {

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    //   name: AppStrings.appName,
    // );
    await GetStorage.init();
    // await initializeDateFormatting('ar');
    ServicesLocator().init();
    // FCMService.firebaseNotificationConfiguration();
    // _localNotificationService.localNotificationConfiguration();

    // HttpOverrides.global = MyHttpOverrides();
    // Helper.screenShot.secureApp();
    // NetworkService().init();
    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    // }
    // StorageService().init();
    // await AppLayout.fixedOrientation();
    // Start Handle FCM_Service config
    /// * On notification success * ///
    // FCMService.firebaseNotificationConfiguration();
    // End Handle FCM_Service config
    //  GoBuilder().initAppRouter(
    //    config: PlatformConfig(
    //      // android:   CustomPageRouterCreator(parentTransition: TransitionType.fade)
    //    ),
    //  );
  }
}
