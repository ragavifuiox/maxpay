import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class QrSuccessScreen extends StatelessWidget {
const QrSuccessScreen({super.key});

@override
     Widget build(BuildContext context) {
        return Scaffold(
          body: Center(
           child: Padding(
              padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                        color: Colors.green,
                         size: 100,
                        ),
                   const SizedBox(height: 20),
                      const Text(
                        "QR Scanned Successfully",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                     const SizedBox(height: 10),
                  const Text(
                      "You can now proceed with web login.",
                        textAlign: TextAlign.center,
                      ),
                     const SizedBox(height: 30),

                     CommonButton(title: "Continue", onTap: (){
                      Get.toNamed(AppRoutes.setting);
                     })
                           
],
),),
),
);
}
}
