import 'package:get/get.dart';
import 'package:maxpay/controllers/add_kyc_controller.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/controllers/credit_controller.dart';
import 'package:maxpay/controllers/dispute_controller.dart';
import 'package:maxpay/controllers/dth_controller.dart';
import 'package:maxpay/controllers/earning_controller.dart';
import 'package:maxpay/controllers/grade_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/menu_controlller.dart';
import 'package:maxpay/controllers/payment_status_controller.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';

import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/controllers/refund_controller.dart';
import 'package:maxpay/controllers/support_controller.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/controllers/wallet_credit_controller.dart';
import 'package:maxpay/controllers/wallet_request_controller.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/view/add_wallet/add_wallet_screen.dart';
import 'package:maxpay/view/cashback/cash_back_screen.dart';
import 'package:maxpay/view/dispute/dispute_screen.dart';
import 'package:maxpay/view/dth_recharge/confirm_dth_page.dart';
import 'package:maxpay/view/dth_recharge/dth_recharge_page.dart';
import 'package:maxpay/view/grade/grade_screen.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/home/widgets/services_section.dart';
import 'package:maxpay/view/kyc/kyc_screen.dart';
import 'package:maxpay/view/login/biometrics/biometrics_intro.dart';
import 'package:maxpay/view/login/biometrics/biometrics_scanning.dart';
import 'package:maxpay/view/login/biometrics/enter_pin%20screen.dart';
import 'package:maxpay/view/login/biometrics/pin_code_creation.dart';
import 'package:maxpay/view/login/biometrics/success_screen.dart';
import 'package:maxpay/view/login/otp_verification_screen.dart';
import 'package:maxpay/view/login/login_phone_name.dart';

import 'package:maxpay/view/login/welcome_page.dart';
import 'package:maxpay/view/login_history/login_history_screen.dart';
import 'package:maxpay/view/mobile_recharge/mobile_recharge_page.dart';
import 'package:maxpay/view/my_earning/my_earning_screen.dart';
import 'package:maxpay/view/nav_page/nav_page.dart';
import 'package:maxpay/view/paymentstatus/payment_status.dart';
import 'package:maxpay/view/profile/profile_screen.dart';
import 'package:maxpay/view/recharge/confirm_transaction_page.dart';
import 'package:maxpay/view/recharge/customer_trnas_confirmation.dart';
import 'package:maxpay/view/refund/refund_screen.dart';
import 'package:maxpay/view/settings/settings_page.dart';
import 'package:maxpay/view/splash/intro_page.dart';
import 'package:maxpay/view/splash/main_splash.dart';
import 'package:maxpay/view/staff/add_staff.dart';
import 'package:maxpay/view/staff/staff_list_screen.dart';
import 'package:maxpay/view/staff/wallet_report_screen.dart';
import 'package:maxpay/view/staff/wallet_transfer.dart';
import 'package:maxpay/view/statement/state_readmore.dart';
import 'package:maxpay/view/support/supoort_screen.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/view/update_pin/verify_pin_screen.dart';
import 'package:maxpay/view/wallet%20balance/wallet_balance.dart';
import 'package:maxpay/view/wallet-credit/wallet_credit_screen.dart';
import 'package:maxpay/view/wallet_request/wallet_request_screen.dart';
import 'package:maxpay/view/web_sign_up/web_signup_otp_screen.dart';
import 'package:maxpay/view/web_sign_up/web_signup_screen.dart';
import 'package:maxpay/view/web_sign_up/web_signup_success_screen.dart';
import 'package:maxpay/view/weblogin/web_login_screen.dart';
import 'package:maxpay/global_widget/insufficient_balance_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const MainSplashScreen()),
    GetPage(name: AppRoutes.intro, page: () => const IntroPage()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.loginPhoneName,

      page: () => const LoginPhoneNamePage(),

      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(
          () => AuthController(
            loginUseCase: sl(),
            otpUsecase: sl(),
            createPinUsecase: sl(),
            fingerPrintUsecase: sl(),
            verifyPinUsecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.customertrans,

      page: () => CustomerTransConfirmationScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<PrePaidController>(
          () => PrePaidController(
            planUseCase: sl(),
            searchPlanUsecase: sl(),
            planDetailUseCase: sl(),
            transConfirmUseCase: sl(),
            mobileRechargeUseCase: sl(),
            plantabusecase: sl(),
            tabdetailusecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.pinCodeCreation,

      page: () => PinCodeCreationPage(),

      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(
          () => AuthController(
            loginUseCase: sl(),
            otpUsecase: sl(),
            createPinUsecase: sl(),
            fingerPrintUsecase: sl(),
            verifyPinUsecase: sl(),
          ),

          fenix: true,
        );
      }),
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

    GetPage(name: AppRoutes.successScreen, page: () => const SuccessScreen()),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.main,

      page: () => const NavPageScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<HomePageController>(
          () => HomePageController(
            getNewsUseCase: sl(),
            getWalletBalanceUseCase: sl(),
            transSucFailUsecase: sl(),
            complaintsUseCase: sl(),
            getPopupMessageUseCase: sl(),
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomePageScreen()),
    GetPage(name: AppRoutes.verify, page: () => const VerifyPinPage()),
    GetPage(name: AppRoutes.enterPin, page: () =>  PinCodeEnterPage()),

    // GetPage(name: AppRoutes.main, page: () => const NavPageScreen()),
    // GetPage(name: AppRoutes.myearning, page: () => const MyEarningsScreen()),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.myearning,

      page: () => const MyEarningsScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<EarningController>(
          () => EarningController(
            getEarningsUseCase: sl(),
            searchEarningsUseCase: sl(),
          ),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.walletcredit,

      page: () => const WalletCreditScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<WalletCreditController>(
          () => WalletCreditController(
            getCreditUseCase: sl(), walletcredittypeusecase: sl(), walletcreditsearchsecase: sl(),),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.refund,

      page: () => const RefundScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<RefundController>(
          () => RefundController(refundUsecase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(name: AppRoutes.cashback, page: () => const CashbackScreen()),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.walletrequest,

      page: () => WalletRequestScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<GetBankController>(
          () =>
              GetBankController(bankusecase: sl(), walletRequestUsecase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.profile,

      page: () => ProfileScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(
          () => ProfileController(getProfileUseCase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.support,

      page: () => SupportScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<SupportController>(
          () => SupportController(supportUseCase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.confirmdth,

      page: () => ConfirmDthPage(),

      binding: BindingsBuilder(() {
        Get.lazyPut<DthController>(
          () => DthController(
            dthtabUseCase: sl(),
            searchdthusecase: sl(),
            confirmdthUsecase: sl(),
            dthrechargeusecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.transconfirm,

      page: () => ConfirmTransactionPage(),

      binding: BindingsBuilder(() {
        Get.lazyPut<PrePaidController>(
          () => PrePaidController(
            transConfirmUseCase: sl(),
            planUseCase: sl(),
            searchPlanUsecase: sl(),
            planDetailUseCase: sl(),
            mobileRechargeUseCase: sl(),
            plantabusecase: sl(),
            tabdetailusecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.kyc,
      page: () => const KycScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => AddKycController(addKycUsecase: sl(), getkycUsecase: sl()),
        ),
      ),
    ),
    GetPage(
      name: AppRoutes.loginhistory,
      page: () => const LoginHistoryScreen(),
    ),
    GetPage(name: AppRoutes.weblogin, page: () => const WebSignupScreen()),
    GetPage(name: AppRoutes.webotp, page: () => const WebOtpScreen()),
    GetPage(
      name: AppRoutes.websuccess,
      page: () => const WebSignupSuccessScreen(),
    ),
    GetPage(name: AppRoutes.setting, page: () => const SettingsPage()),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.grade,

      page: () => GradeScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<GradeController>(
          () => GradeController(gradeusecase: sl()),

          fenix: true,
        );
      }),
    ),
    // GetPage(name: AppRoutes.grade, page: () => const GradeScreen()),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.prepaid,

      page: () {
        final args = Get.arguments ?? {};

        return MobileRechargePage(
          productId: args['productId'] ?? '',
          productName: args['productName'] ?? '',
        );
      },

      binding: BindingsBuilder(() {
        Get.lazyPut<PrePaidController>(
          () => PrePaidController(
            planDetailUseCase: sl(),
            planUseCase: sl(),
            searchPlanUsecase: sl(),
            transConfirmUseCase: sl(),
            mobileRechargeUseCase: sl(),
            plantabusecase: sl(),
            tabdetailusecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),




    GetPage(
      transition: Transition.fade,

      name: AppRoutes.walletreport,

      page: () => WalletReportScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<AddStaffController>(
          () => AddStaffController(
            addStaffUsecase: sl(),
            staffListUseCase: sl(),
            searchStaffUsecase: sl(),
            walletTransferUsecase: sl(),
            walletReportUsecase: sl()
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.menu,

      page: () => MenuScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<ServiceController>(
          () => ServiceController(productTypeUseCase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.addstaff,

      page: () => AddStaffPage(),

      binding: BindingsBuilder(() {
        Get.lazyPut<AddStaffController>(
          () => AddStaffController(
            addStaffUsecase: sl(),
            staffListUseCase: sl(),
            searchStaffUsecase: sl(),
            walletTransferUsecase: sl(),
            walletReportUsecase: sl()
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(name: AppRoutes.walletbal, page: () => const WalletBalanceScreen()),
    GetPage(name: AppRoutes.dth, page: () => const DTHRechargePage()),
    GetPage(name: AppRoutes.addwallet, page: () => const AddWalletScreen()),
    GetPage(name: AppRoutes.veirfypin, page: () =>  PinCodeEnterPage()),
    GetPage(name: AppRoutes.wallettrnsfer, page: () =>  WalletTransferScreen()),
    GetPage(
      name: AppRoutes.statementReadMore,
      page: () => const StatementReadMoreScreen(),
    ),
    GetPage(name: AppRoutes.webloginqr, page: () => const WebLoginScreen()),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.paymentstatus,

      page: () => PaymentStatusScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<PaymentStatusController>(
          () => PaymentStatusController(paymentStatusUsecase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,
      name: AppRoutes.dispute,

      page: () => DisputeReportScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<DisputeController>(
          () => DisputeController(disputeusecase: sl()),

          fenix: true,
        );
      }),
    ),
    GetPage(
      transition: Transition.fade,
      name: AppRoutes.stafflist,

      page: () => StaffListPage(),

      binding: BindingsBuilder(() {
        Get.lazyPut<AddStaffController>(
          () => AddStaffController(
            staffListUseCase: sl(),
            addStaffUsecase: sl(),
            searchStaffUsecase: sl(),
            walletTransferUsecase: sl(),
            walletReportUsecase: sl()
          ),

          fenix: true,
        );
      }),
    ),



   GetPage(
  name: AppRoutes.transaction,
  transition: Transition.fade,

  page: () {
    final status =
        Get.arguments as TransactionStatus?;

    return TransactionScreen(
      status:
          status ?? TransactionStatus.success,
    );
  },

  binding: BindingsBuilder(() {
    Get.lazyPut<TransReportController>(
      () => TransReportController(
        transreportUsecase: sl(),
        allPlanUsecase: sl(),
        submitDisputeUsecase: sl()
      ),
      fenix: true,
    );
  }),
),
    
  ];
}
