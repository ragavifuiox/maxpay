import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/home/widgets/services_section.dart';
import 'package:maxpay/view/nav_page/navbar.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:maxpay/view/report/report_page.dart';
import 'package:maxpay/view/settings/settings_page.dart';
import 'package:maxpay/view/support/supoort_screen.dart';
import 'package:maxpay/view/wallet_request/wallet_request_screen.dart';

class NavPageScreen extends StatefulWidget {
  const NavPageScreen({super.key});

  @override
  State<NavPageScreen> createState() => _ScreenNavBarState();
}

class _ScreenNavBarState extends State<NavPageScreen>
    with WidgetsBindingObserver {
  DateTime? lastBackPressed;
  final NavbarController _navbarController = Get.find<NavbarController>();

 @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addObserver(this);

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (Get.isRegistered<TransReportController>()) {
      final controller = Get.find<TransReportController>();

      await controller.transactionreport(
        search: "",
        status: "",
        productid: "",
        fromdate: controller.fromDate,
        todate: controller.toDate,
      );
    }
  });
}
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  final List<Widget> screens = [
    const HomePageScreen(),
    const ReportPage(),
    WalletRequestScreen(),
     SupportScreen(),
    const SettingsPage(),
  ];

  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) {
      if (didPop) return;

      if (_navbarController.selectedIndex.value != 0) {
        _navbarController.setIndex(0);
      } else {
        final now = DateTime.now();
        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
          lastBackPressed = now;
          // ScaffoldMessenger.of(context).showSnackBar(
            // const SnackBar(
            //   content: Text('Press back again to exit'),
            // ),
          // );
        } else {
          SystemNavigator.pop();
        }
      }
    },
    child: Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Obx(() {
        if (_navbarController.isMenuOpen.value) {
          return MenuScreen();
        }

        return IndexedStack(
          index: _navbarController.selectedIndex.value,
          children: screens,
        );
      }),
    ),
  );
}
}
