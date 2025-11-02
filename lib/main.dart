import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/UI/screens/home_screen.dart';
import 'package:Alegny_provider/src/Features/SplachAndOnbordingFeature/ui/splash_screen.dart';
import 'src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'src/GeneralWidget/Widgets/Loading/loading_dialog.dart';
import 'src/core/App/app_initializer.dart';
import 'src/core/ThemeData/theme_constant.dart';
import 'src/core/constants/app_strings.dart';
import 'src/core/constants/color_constants.dart';
import 'src/core/services/Lang/localization_services.dart';
import 'src/core/services/Network/network_services.dart';

int kNumOfNav = 0;

/// start background
@pragma('vm:entry-point')
void main() async {
  initializeDateFormatting('ar', null); // Initialize Arabic locale
  await AppInitializer.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.spinningCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..toastPosition = EasyLoadingToastPosition.center
      ..boxShadow = <BoxShadow>[]
      ..indicatorWidget = const EasyLoader()
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = 0.0
      ..radius = 12
      ..progressColor = AppColors.main
      ..backgroundColor = Colors.white
      ..indicatorColor = AppColors.main
      ..textColor = Colors.white
      ..maskColor = Colors.black12.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(NetworkService());

    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(414, 896),
      builder: (context, child) => GetMaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.native,
        transitionDuration: const Duration(milliseconds: 200),
        translations: LocalizationServices(),
        locale: LocalizationServices().getCurrentLocale(),
        title: AppStrings.appName,
        theme: mainTheme(AppColors.main),
        routingCallback: (Routing? route) => route == null ||
                route.isBlank! ||
                route.isBottomSheet! ||
                route.isDialog!
            ? kNumOfNav
            : route.isBack!
                ? kNumOfNav--
                : kNumOfNav++,
        // home: const SplashScreen(),
        home: const BaseBNBScreen(),
      ),
    );
  }
}
