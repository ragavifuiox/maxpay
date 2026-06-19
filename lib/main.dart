import 'dart:math' as math;

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
  // debugPaintSizeEnabled = true;

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

          builder: (context, child) {
            // return child!;
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: AnimatedTheme(
                data: Theme.of(context),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}

//100.98.153.235

class CircularRevealClipper extends CustomClipper<Path> {
  final Offset center;
  final double fraction; // Goes from 0.0 to 1.0

  CircularRevealClipper({required this.center, required this.fraction});

  @override
  Path getClip(Size size) {
    // 1. Calculate the distance from center to the furthest screen corner (hypotenuse)
    final double maxRadius = _calcMaxRadius(size, center);
    final double currentRadius = maxRadius * fraction;

    // 2. Draw a circular path
    return Path()
      ..addOval(Rect.fromCircle(center: center, radius: currentRadius));
  }

  double _calcMaxRadius(Size size, Offset center) {
    // Find distances to all 4 corners and pick the maximum
    final double dx1 = center.dx;
    final double dx2 = size.width - center.dx;
    final double dy1 = center.dy;
    final double dy2 = size.height - center.dy;

    // Using Pythagoras theorem to find the diagonal length
    return [
      math.sqrt(dx1 * dx1 + dy1 * dy1),
      math.sqrt(dx2 * dx2 + dy1 * dy1),
      math.sqrt(dx1 * dx1 + dy2 * dy2),
      math.sqrt(dx2 * dx2 + dy2 * dy2),
    ].reduce(math.max);
  }

  @override
  bool shouldReclip(covariant CircularRevealClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.center != center;
  }
}
