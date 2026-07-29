import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_staff_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WalletTransferScreen extends StatelessWidget {
  WalletTransferScreen({super.key});

  final AddStaffController controller = Get.find<AddStaffController>();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final staff = Get.arguments;
final theme = Theme.of(context);

final Color fieldColor = theme.brightness == Brightness.dark
    ? const Color(0xFF3C3F52) // Dark mode
    : const Color(0xFFF8F9FA); // Light mode
    return Scaffold(
        backgroundColor:
          theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "Wallet Transfer"),

      // ✅ SAFE LAYOUT
      body: SafeArea(
      
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ================= WALLET BALANCE =================
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    decoration: BoxDecoration(
                      color: AppColors.clrPrimary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Wallet Balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h),

                        Obx(() {
                          final balance =
                              Get.find<HomePageController>().walletBalance.value;

                          return Text(
                            "₹ ${balance?.data?.balance ?? "0.00"}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// ================= NAME =================
                  const Text(
                    "Name",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
TextFormField(
  initialValue: staff.name ?? "",
  readOnly: true,
  decoration: InputDecoration(
    filled: true,
    fillColor: fieldColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  ),
),
                  const SizedBox(height: 20),

                  /// ================= TRANSACTION TYPE =================
                  const Text(
                    "Transaction Type",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),

                 Obx(
  () => DropdownButtonFormField<String>(
    initialValue: controller.selectedPaymentType.value,
    decoration: InputDecoration(
      filled: true,
       fillColor: isDark
      ? AppColors.darkFilterBorder // Dark mode
      : const Color(0xFFF4F4F4),  // Light mode
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    items: controller.walletTypes.map((type) {
      return DropdownMenuItem(
        value: type,
        child: Text(type),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        controller.selectedPaymentType.value = value;
      }
    },
  ),
),

                  const SizedBox(height: 20),

                  /// ================= AMOUNT =================
                  const Text(
                    "Amount",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),

                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                      filled: true,
                      fillColor: isDark
      ? AppColors.darkFilterBorder // Dark mode
      : const Color(0xFFF4F4F4),  // Light mode
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 190),

                  /// ================= BUTTON =================
                  Center(
                    child: CommonButton(
                      title: "Submit",
                      onTap: () async {
                        if (amountController.text.trim().isEmpty) {
                         
 CustomToast.error( "Please enter amount");
                         
                          return;
                        }

                        await controller.walletTransfer(
                          staffid: staff.userId.toString(),
                          amount: amountController.text.trim(),
                         paymenttype: controller.selectedPaymentType.value,
                        );

                        amountController.clear();
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}