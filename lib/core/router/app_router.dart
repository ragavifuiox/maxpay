import 'package:get/get.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/controllers/add_wallet_controller.dart';
import 'package:maxpay/controllers/cash_back_controller.dart';
// import 'package:maxpay/controllers/credit_controller.dart';
import 'package:maxpay/controllers/dispute_controller.dart';
import 'package:maxpay/controllers/dth_controller.dart';
import 'package:maxpay/controllers/earning_controller.dart';
import 'package:maxpay/controllers/grade_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/login_history_controller.dart';
import 'package:maxpay/controllers/menu_controlller.dart';
import 'package:maxpay/controllers/payment_status_controller.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';

import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/controllers/refund_controller.dart';
import 'package:maxpay/controllers/statement_controller.dart';
import 'package:maxpay/controllers/support_controller.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/controllers/wallet_credit_controller.dart';
import 'package:maxpay/controllers/wallet_request_controller.dart';
import 'package:maxpay/controllers/web_login_controller.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/global_widget/insufficient_balance_page.dart';
import 'package:maxpay/view/add_wallet/add_wallet_screen.dart';
import 'package:maxpay/view/cabletv/cable_tv_page.dart';
import 'package:maxpay/view/cashback/cash_back_screen.dart';
import 'package:maxpay/view/dispute/dispute_screen.dart';
import 'package:maxpay/view/dth_recharge/confirm_dth_page.dart';
import 'package:maxpay/view/dth_recharge/customer_dth_page.dart';
import 'package:maxpay/view/dth_recharge/dth_recharge_page.dart';
import 'package:maxpay/view/dth_refresh/dth_refresh_page.dart';
import 'package:maxpay/view/electricity_bill/electricity_bill_page.dart';
import 'package:maxpay/view/gas_bill/gas_bill_page.dart';
import 'package:maxpay/view/grade/grade_screen.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/home/widgets/services_section.dart';
import 'package:maxpay/view/kyc/kyc_screen.dart';
import 'package:maxpay/view/landline/landline_bill_page.dart';
import 'package:maxpay/view/login/biometrics/biometrics_intro.dart';
import 'package:maxpay/view/login/biometrics/biometrics_scanning.dart';
import 'package:maxpay/view/login/biometrics/enter_pin_screen.dart';
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
import 'package:maxpay/view/statement/statement_screen.dart';
import 'package:maxpay/view/support/supoort_screen.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_detail_page.dart';
import 'package:maxpay/view/transfer_detail/transfer_detial.dart';
import 'package:maxpay/view/update_pin/verify_pin_screen.dart';
import 'package:maxpay/view/wallet%20balance/wallet_balance.dart';
import 'package:maxpay/view/wallet-credit/wallet_credit_screen.dart';
import 'package:maxpay/view/wallet_request/wallet_request_screen.dart';
import 'package:maxpay/view/water/watter_bill.dart';
import 'package:maxpay/view/web_sign_up/web_signup_otp_screen.dart';
import 'package:maxpay/view/web_sign_up/web_signup_screen.dart';
import 'package:maxpay/view/web_sign_up/web_signup_success_screen.dart';
import 'package:maxpay/view/weblogin/web_login_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const MainSplashScreen()),
    GetPage(name: AppRoutes.intro, page: () => const IntroPage()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.transferdetail, page: () => const TransferDetial()),
    GetPage(
      name: AppRoutes.electricity,
      page: () => const ElectricityBillPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: AppRoutes.loginPhoneName,
      page: () => const LoginPhoneNamePage(),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.dthcustomer,

      page: () => CustomerDthPage(),

      binding: BindingsBuilder(() {
        Get.lazyPut<DthController>(
          () => DthController(
            dthtabUseCase: sl(),
            searchdthusecase: sl(),
            confirmdthUsecase: sl(),
            dthrechargeusecase: sl(),
            customerInfoUsecase: sl(),
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
            downloadusecase: sl(),
            checkOperatorUsecase: sl(),
            offerRechargeUsecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(
      transition: Transition.fade,
      name: AppRoutes.pinCodeCreation,
      page: () => PinCodeCreationPage(),
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
            refundCountUsecase: sl(),
            todaycreditusecase: sl(),
            graphUsecase: sl(),
            faqUsecase: sl(),
            faqreplyusecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomePageScreen()),
    GetPage(name: AppRoutes.verify, page: () => const VerifyPinPage()),
    GetPage(name: AppRoutes.enterPin, page: () => PinCodeEnterPage()),
    GetPage(name: AppRoutes.water, page: () => WatterBill()),
    GetPage(name: AppRoutes.gas, page: () => GasBillPage()),
    GetPage(name: AppRoutes.landline, page: () => LandlineBillPage()),
    GetPage(name: AppRoutes.dthrefresh, page: () => DthRefreshScreen()),
    GetPage(name: AppRoutes.cabletv, page: () => CableTvPage()),

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
            getCreditUseCase: sl(),
            walletcredittypeusecase: sl(),
            walletcreditsearchsecase: sl(),
          ),

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
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.cashback,

      page: () => const CashbackScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<CashbackController>(
          () => CashbackController(allPlanUsecase: sl(), cashbackUsecase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.walletrequest,

      page: () => WalletRequestScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<GetBankController>(
          () => GetBankController(
            bankusecase: sl(),
            walletRequestUsecase: sl(),
            dueAmountUsecase: sl(),
          ),

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
          () => ProfileController(
            getProfileUseCase: sl(),
            profileUpdateUseCase: sl(),
            updateprofileotpusecase: sl(),
          ),
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
            customerInfoUsecase: sl(),
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
            downloadusecase: sl(),
            checkOperatorUsecase: sl(),
            offerRechargeUsecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),
    GetPage(name: AppRoutes.kyc, page: () => const KycScreen()),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.loginhistory,

      page: () => LoginHistoryScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<LoginHistoryController>(
          () => LoginHistoryController(loginHistoryUsecase: sl()),

          fenix: true,
        );
      }),
    ),

    GetPage(
      name: AppRoutes.transactionDetails,
      page: () => const TransactionDetailsPage(),
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
            downloadusecase: sl(),
            checkOperatorUsecase: sl(),
            offerRechargeUsecase: sl(),
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
            staffTrnsTeportListUseCase: sl(),
            searchStaffUsecase: sl(),
            walletTransferUsecase: sl(),
            walletReportUsecase: sl(),
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
          () => ServiceController(
            productTypeUseCase: sl(),
            todayTrnsactionUsecase: sl(),
          ),

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
            staffTrnsTeportListUseCase: sl(),
            searchStaffUsecase: sl(),
            walletTransferUsecase: sl(),
            walletReportUsecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.walletbal,

      page: () => WalletBalanceScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<AddWalletController>(
          () => AddWalletController(createQrUsecase: sl()),

          fenix: true,
        );
      }),
    ),
    //
    GetPage(
      name: AppRoutes.insufficientBalance,
      page: () => const InsufficientBalancePage(),
    ),
    GetPage(name: AppRoutes.dth, page: () => const DTHRechargePage()),
    GetPage(
      name: AppRoutes.addwallet,
      page: () => const AddWalletScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => AddWalletController(createQrUsecase: sl()),
          fenix: true,
        ),
      ),
    ),
    GetPage(name: AppRoutes.veirfypin, page: () => PinCodeEnterPage()),
    GetPage(name: AppRoutes.wallettrnsfer, page: () => WalletTransferScreen()),
    GetPage(
      name: AppRoutes.statementReadMore,
      page: () => const StatementReadMoreScreen(),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.webloginqr,

      page: () => WebLoginScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<WebLoginController>(
          () =>
              WebLoginController(webloginusecase: sl(), webLogoutUsecase: sl()),

          fenix: true,
        );
      }),
    ),

    // GetPage(name: AppRoutes.webloginqr, page: () => const WebLoginScreen()),
    GetPage(
      transition: Transition.fade,

      name: AppRoutes.paymentstatus,

      page: () => PaymentStatusScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<PaymentStatusController>(
          () => PaymentStatusController(
            paymentStatusUsecase: sl(),
            paymentStatusTypeUsecase: sl(),
            updatePaymentStatusUsecase: sl(),
          ),
          fenix: true,
        );
      }),
    ),

    GetPage(
      transition: Transition.fade,

      name: AppRoutes.statement,

      page: () => StatementScreen(),

      binding: BindingsBuilder(() {
        Get.lazyPut<StatementController>(
          () => StatementController(statementUsecase: sl()),

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
            staffTrnsTeportListUseCase: sl(),
            searchStaffUsecase: sl(),
            walletTransferUsecase: sl(),
            walletReportUsecase: sl(),
          ),

          fenix: true,
        );
      }),
    ),

    GetPage(
      name: AppRoutes.transaction,
      transition: Transition.fade,

      page: () {
        final status = Get.arguments as TransactionStatus?;

        return TransactionScreen(status: status ?? TransactionStatus.success);
      },

      binding: BindingsBuilder(() {
        Get.lazyPut<TransReportController>(
          () => TransReportController(
            transreportUsecase: sl(),
            producttypeUseCase: sl(),
            submitDisputeUsecase: sl(),
            cashbackTypeUsecase: sl(),
          ),
          fenix: true,
        );
      }),
    ),
  ];
}
