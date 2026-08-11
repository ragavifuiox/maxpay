import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class WebLoginSuccessPage extends StatelessWidget {
  const WebLoginSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const Spacer(),

              // Success Icon
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(
                  color: Color(0xff4CD964),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 50),
              ),

              const SizedBox(height: 25),

              const Text(
                "Web Login Successful !!!",
                style: TextStyle(
                  color: Color(0xff32CD32),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (Get.isRegistered<NavbarController>()) {
                      Get.find<NavbarController>().setIndex(4);
                    }
                    Get.offAllNamed(AppRoutes.main);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1FA7C4),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
