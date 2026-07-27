import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/app_router.dart';
import 'package:maxpay/core/constants/routes_path.dart';

import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/initial_binding.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:maxpay/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await di.init();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize GetX Controllers
  Get.put(ThemeController(sharedPreferences));
  Get.put(NavbarController());

  // Restrict to portrait
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
          title: 'MaxPay',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          initialBinding: InitialBinding(),
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: SafeArea(
                  top: false,
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
