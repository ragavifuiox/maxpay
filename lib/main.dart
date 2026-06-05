import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/initial_bindings.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/router/app_router.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// IMPORTANT
  await initDependencies();

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // GetX Controllers
  Get.put(ThemeController(sharedPreferences));
  Get.put(NavbarController());

  // Portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, child) {

        return GetMaterialApp(

          title: 'PayLink',
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          themeMode: themeController.themeMode,

          initialBinding: InitialBinding(),

          initialRoute: AppRoutes.splash,

          getPages: AppPages.pages,
        );
      },
    );
  }
}