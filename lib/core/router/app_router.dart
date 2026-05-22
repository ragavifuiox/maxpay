import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/add_wallet/add_wallet_screen.dart';
import 'package:maxpay/view/balance/wallet.dart';
import 'package:maxpay/view/cashback/cash_back_screen.dart';
import 'package:maxpay/view/dth_recharge/dth_recharge_page.dart';
import 'package:maxpay/view/favorite/favorite.dart';
import 'package:maxpay/view/grade/grade_screen.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/home/widgets/services_section.dart';
import 'package:maxpay/view/kyc/kyc_screen.dart';
import 'package:maxpay/view/login/biometrics/biometrics_intro.dart';
import 'package:maxpay/view/login/biometrics/biometrics_scanning.dart';
import 'package:maxpay/view/login/biometrics/pin_code_creation.dart';
import 'package:maxpay/view/login/biometrics/success_screen.dart';
import 'package:maxpay/view/login/otp_verification_screen.dart';
import 'package:maxpay/view/login/login_phone_name.dart';
import 'package:maxpay/view/login/select_sim.dart';
import 'package:maxpay/view/login/welcome_page.dart';
import 'package:maxpay/view/login_history/login_history_screen.dart';
import 'package:maxpay/view/mobile_recharge/mobile_recharge_page.dart';
import 'package:maxpay/view/my_earning/my_earning_screen.dart';
import 'package:maxpay/view/nav_page/nav_page.dart';
import 'package:maxpay/view/profile/profile_screen.dart';
import 'package:maxpay/view/refund/refund_screen.dart';
import 'package:maxpay/view/settings/settings_page.dart';

import 'package:maxpay/view/splash/intro_page.dart';
import 'package:maxpay/view/splash/main_splash.dart';
import 'package:maxpay/view/statement/read_more.dart';
import 'package:maxpay/view/statement/statement.dart';
import 'package:maxpay/view/support/supoort_screen.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/view/transaction_screens/view.dart';
import 'package:maxpay/view/update_pin/update_pin_screen.dart';
import 'package:maxpay/view/update_pin/verify_pin_screen.dart';
import 'package:maxpay/view/wallet-credit/wallet_credit_screen.dart';
import 'package:maxpay/view/web_login/web_login_otp_screen.dart';
import 'package:maxpay/view/web_login/web_login_screen.dart';
import 'package:maxpay/view/web_login/web_login_success_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const MainSplashScreen()),
    GetPage(name: AppRoutes.intro, page: () => const IntroPage()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.selectSim, page: () => const SelectSimPage()),
    GetPage(
      name: AppRoutes.loginPhoneName,
      page: () => const LoginPhoneNamePage(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const ScreenOtpVerification(),
    ),
    GetPage(
      name: AppRoutes.biometricsIntro,
      page: () => const BiometricsIntroPage(),
    ),
    GetPage(
      name: AppRoutes.biometricsScanning,
      page: () => const BiometricsScanningPage(),
    ),
    GetPage(
      name: AppRoutes.pinCodeCreation,
      page: () => const PinCodeCreationPage(),
    ),
    GetPage(name: AppRoutes.successScreen, page: () => const SuccessScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomePageScreen()),
    GetPage(name: AppRoutes.main, page: () => const NavPageScreen()),
    GetPage(name: AppRoutes.myearning, page: () => const MyEarningsScreen()),
    GetPage(
      name: AppRoutes.withdrawrequest,
      page: () => const WalletCreditScreen(),
    ),
    GetPage(name: AppRoutes.refund, page: () => const RefundScreen()),
    GetPage(name: AppRoutes.cashback, page: () => const CashbackScreen()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.support, page: () => const SupportScreen()),
    GetPage(name: AppRoutes.kyc, page: () => const KycScreen()),
    GetPage(
      name: AppRoutes.loginhistory,
      page: () => const LoginHistoryScreen(),
    ),
    GetPage(name: AppRoutes.weblogin, page: () => const WebLoginScreen()),
    GetPage(name: AppRoutes.webotp, page: () => const WebOtpScreen()),
    GetPage(
      name: AppRoutes.websuccess,
      page: () => const WebLoginSuccessScreen(),
    ),
    GetPage(name: AppRoutes.setting, page: () => const SettingsPage()),
    GetPage(name: AppRoutes.grade, page: () => const GradeScreen()),
    GetPage(name: AppRoutes.prepaid, page: () => const MobileRechargePage()),
    GetPage(name: AppRoutes.menu, page: () => const MenuScreen()),
    GetPage(name: AppRoutes.dth, page: () => const DTHRechargePage()),
    GetPage(name: AppRoutes.addwallet, page: () => const AddWalletScreen()),
    GetPage(name: AppRoutes.veirfypin, page: () => const VerifyPinPage()),
    GetPage(
      name: AppRoutes.transaction,
      page: () {
        final status = Get.arguments as TransactionStatus?;

        return TransactionScreen(status: status ?? TransactionStatus.success);
      },
    ),
    GetPage(name: AppRoutes.statement, page: () => const StatementScreen()),
    GetPage(
      name: AppRoutes.statementReadMore,
      page: () {
        final arguments = Get.arguments;
        final details = arguments is Map
            ? arguments.map((key, value) => MapEntry('$key', '$value'))
            : null;

        return StatementReadMoreScreen(details: details);
      },
    ),
    GetPage(name: AppRoutes.view, page: () => const ViewDetailsScreen()),
    GetPage(name: AppRoutes.favorite, page: () => const FavoriteScreen()),
    GetPage(
      name: AppRoutes.walletBalance,
      page: () => const WalletBalanceScreen(),
    ),
    GetPage(name: AppRoutes.update, page: () => const UpdatePinPage()),
  ];
}
