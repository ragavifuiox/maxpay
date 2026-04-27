import 'package:go_router/go_router.dart';
import 'package:maxpay/core/utils/routes_path.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/login/biometrics/biometrics_intro.dart';
import 'package:maxpay/view/login/biometrics/biometrics_scanning.dart';
import 'package:maxpay/view/login/biometrics/pin_code_creation.dart';
import 'package:maxpay/view/login/biometrics/success_screen.dart';
import 'package:maxpay/view/login/otp_verification_screen.dart';
import 'package:maxpay/view/login/login_phone_name.dart';
import 'package:maxpay/view/login/select_sim.dart';
import 'package:maxpay/view/login/welcome_page.dart';
import 'package:maxpay/view/nav_page/nav_page.dart';
import 'package:maxpay/view/splash/intro_page.dart';
import 'package:maxpay/view/splash/main_splash.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.main,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const MainSplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.intro,
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.selectSim,
        builder: (context, state) => const SelectSimPage(),
      ),
      GoRoute(
        path: AppRoutes.loginPhoneName,
        builder: (context, state) => const LoginPhoneNamePage(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) => const ScreenOtpVerification(),
      ),
      GoRoute(
        path: AppRoutes.biometricsIntro,
        builder: (context, state) => const BiometricsIntroPage(),
      ),
      GoRoute(
        path: AppRoutes.biometricsScanning,
        builder: (context, state) => const BiometricsScanningPage(),
      ),
      GoRoute(
        path: AppRoutes.pinCodeCreation,
        builder: (context, state) => const PinCodeCreationPage(),
      ),
      GoRoute(
        path: AppRoutes.successScreen,
        builder: (context, state) => const SuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePageScreen(),
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => const NavPageScreen(),
      ),
    ],
  );
}
