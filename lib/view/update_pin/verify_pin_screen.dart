import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/update_pin/update_pin_screen.dart';
import 'package:maxpay/view/update_pin/widget/pin_box_widget.dart';

class VerifyPinPage extends StatefulWidget {
  const VerifyPinPage({super.key});

  @override
  State<VerifyPinPage> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  final TextEditingController pinController = TextEditingController();

  final AuthController authController = Get.put(AuthController(loginUseCase: sl(), otpUsecase: sl(), createPinUsecase: sl(), fingerPrintUsecase: sl(), verifyPinUsecase: sl()));

  @override
  Widget build(BuildContext context) {
    String pin = pinController.text;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar(title: ""),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            Text(
              "Verify Pin",
              style: TextHelper.max13(context),
            ),

            SizedBox(height: 40.h),

            Row(
              children: List.generate(
                4,
                (index) => PinBoxWidget(
                  number: index < pin.length ? pin[index] : "",
                ),
              ),
            ),

            Opacity(
              opacity: 0,
              child: TextField(
                controller: pinController,
                autofocus: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),

            const Spacer(),

            Obx(
              () => Center(
                child: CommonButton(
                  title: authController.isLoading.value
                      ? "Verifying..."
                      : "Continue",
                 onTap: () async {
                  if (pin.length != 4) return;
                
                  bool success = await authController.verifyPin(pin);
                
                  if (success) {
                    Get.to(() =>  UpdatePinPage());
                  } else {
                    pinController.clear();
                
                    setState(() {});
                  }
                },
                ),
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}