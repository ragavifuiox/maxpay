import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/broadband/broadband_confirm_page.dart';
import 'package:maxpay/view/fastag_recharge/confirm_fastag_page.dart';

class _BillColors {
  // static const fieldGrey = Color(0xFFF3F4F6);
  static const fieldGreyDark = Color(0xFF2A2E33);
}

class FastagRechargePage extends StatefulWidget {
  const FastagRechargePage({super.key});

  @override
  State<FastagRechargePage> createState() => _FastagPageState();
}

class _FastagPageState extends State<FastagRechargePage> {
  bool _isBillFetched = false;
  bool _isReceived = true;

  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController(
    text: '9876543213',
  );
  final TextEditingController _amountController = TextEditingController(
    text: '500.00',
  );

  final PrePaidController controller = Get.put(
    PrePaidController(
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
      termusecase: sl(),
    ),
  );

  Data? selectedBoardObj;
  String productId = "";

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args['productId'] != null) {
      productId = args['productId'];
      controller.getPlans(productid: productId);
    }
  }

  @override
  void dispose() {
    _customerIdController.dispose();
    _mobileController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDetailDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (context) {
        return Dialog(
          backgroundColor: isDark ? AppColors.darkbgBlack : Colors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.w, 14.h, 14.w, 18.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // close icon
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Icon(Icons.close, size: 12.sp, color: Colors.red),
                  ),
                ),
                SizedBox(height: 4.h),
                _detailRow(context, 'Customer Name', 'John'),
                _detailRow(context, 'Bill Number', '#10011887'),
                _detailRow(context, 'Bill Date', '11/12/2024'),
                _detailRow(context, 'Bill Due Date', '11/12/2025'),
                // SizedBox(height: 16.h),
                // SizedBox(
                //   width: double.infinity,
                //   height: 42.h,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Get.to(ConfirmFastagPage());
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.clrPrimary,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //       elevation: 0,
                //     ),
                //     child: Text(
                //       'Next',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fieldColor = isDark
        ? AppColors.darkFilterBorder
        : AppColors.background;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "FASTag Recharge"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    /// 🔹 WALLET BALANCE CARD
                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.symmetric(vertical: 15.h),

                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,

                        borderRadius: BorderRadius.circular(12.r),
                      ),

                      child: Column(
                        children: [
                          Text(
                            'Wallet Balance',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 5.h),

                          Obx(() {
                            final balance = Get.find<HomePageController>()
                                .walletBalance
                                .value;

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
                    SizedBox(height: 20.h),

                    /// 🔹 BOARD SELECTION
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.clrPrimary,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Loading operations...",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Data>(
                            isExpanded: true,
                            value: controller.selectedPlan.value,
                            hint: Text(
                              "Select",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            items: controller.plans.map((Data operator) {
                              return DropdownMenuItem<Data>(
                                value: operator,
                                child: Row(
                                  children: [
                                    if ((operator.logo ?? "").isNotEmpty)
                                      Image.network(
                                        operator.logo!,
                                        width: 25.w,
                                        height: 25.w,
                                      ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        operator.name ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (Data? value) {
                              if (value == null) return;
                              setState(() {
                                selectedBoardObj = value;
                              });
                              controller.selectedPlan.value = value;
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 15.h),

                    /// 🔹 CUSTOMER ID INPUT
                    Container(
                      decoration: BoxDecoration(
                        color: fieldColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        controller: _customerIdController,
                        enabled: !_isBillFetched,
                        onChanged: (_) {
                          setState(() {}); // Refresh to show/hide X icon
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Customer Id',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 15.h,
                          ),
                          suffixIcon: _customerIdController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 20.sp,
                                  ),
                                  onPressed: () {
                                    _customerIdController.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),

                    if (_isBillFetched) ...[
                      SizedBox(height: 12.h),

                      /// 🔹 DETAIL BUTTON
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _showDetailDialog(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 22.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'Detail',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      /// 🔹 MOBILE / CUSTOMER NUMBER (editable, shows pencil icon)
                      Container(
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: TextField(
                          controller: _mobileController,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 15.h,
                            ),
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 18.sp,
                              color: AppColors.clrPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      /// 🔹 AMOUNT FIELD
                      Container(
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixText: '₹',
                            prefixStyle: TextStyle(
                              fontSize: 14.sp,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 15.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// 🔹 CUSTOMER PAYMENT STATUS
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.clrPrimary.withValues(alpha: 0.6),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Customer Payment',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.clrPrimary,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _paymentOption(
                                  label: 'Not Received',
                                  color: Colors.red,
                                  selected: !_isReceived,
                                  onTap: () =>
                                      setState(() => _isReceived = false),
                                ),
                                _paymentOption(
                                  label: 'Received',
                                  color: Colors.green,
                                  selected: _isReceived,
                                  onTap: () =>
                                      setState(() => _isReceived = true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

            /// 🔹 BOTTOM BUTTON
            Padding(
              padding: EdgeInsets.all(20.r),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_isBillFetched) {
                      if (_customerIdController.text.trim().isEmpty) return;
                      setState(() => _isBillFetched = true);
                    } else {
                      Get.to(BroadbandConfirmPage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.clrPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Lufga',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Payment option (checkbox + label)
  // ------------------------------------------------------------------
  Widget _paymentOption({
    required String label,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: color, width: 1.4),
              color: selected ? color : Colors.transparent,
            ),
            child: selected
                ? Icon(Icons.check, size: 13.sp, color: Colors.white)
                : null,
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
