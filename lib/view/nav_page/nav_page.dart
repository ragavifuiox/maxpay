import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/nav_page/navbar.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:maxpay/view/report/report_page.dart';
import 'package:maxpay/view/settings/settings_page.dart';

class NavPageScreen extends ConsumerStatefulWidget {
  const NavPageScreen({super.key});

  @override
  ConsumerState<NavPageScreen> createState() => _ScreenNavBarState();
}

class _ScreenNavBarState extends ConsumerState<NavPageScreen>
    with WidgetsBindingObserver {
  DateTime? lastBackPressed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navbarProvider);

    final List<Widget> screens = [
      const HomePageScreen(),
      const ReportPage(),
      const Scaffold(body: Center(child: Text("Request Screen"))),
      const Scaffold(body: Center(child: Text("My QR Screen"))),
      const SettingsPage(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        if (selectedIndex != 0) {
          ref.read(navbarProvider.notifier).setIndex(0);
        } else {
          final now = DateTime.now();
          if (lastBackPressed == null ||
              now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
            lastBackPressed = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              IndexedStack(
                index: selectedIndex,
                children: screens,
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomBottomNavBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
