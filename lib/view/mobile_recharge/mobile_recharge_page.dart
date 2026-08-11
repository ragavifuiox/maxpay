import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/mobile_recharge/contact_list_page.dart';
import 'package:maxpay/view/mobile_recharge/webview.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class MobileRechargePage extends StatefulWidget {
  final String productId;
  final String productName;

  const MobileRechargePage({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  State<MobileRechargePage> createState() => _MobileRechargePageState();
}

class _MobileRechargePageState extends State<MobileRechargePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String selectedProductId = '';
  String selectedOperator = '';
  String selectedTabId = "";
  Data? selectedOperatorObj;
  final PrePaidController controller = Get.find<PrePaidController>();
  final TextEditingController customerPaymentController =
      TextEditingController();
  Color selectedOperatorColor = Colors.orange;

  bool isPlanSelected = true;
  bool showNextButton = false;
  final TextEditingController mobileController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  // Controls the outer page scroll so we can jump back to the top
  // whenever the user selects a different plan tab.
  final ScrollController _scrollController = ScrollController();

  // 🔹 NEW: marks the "TABBAR BUTTONS" row (Plan/Offer + Proceed) so we can
  // scroll it into view after a plan/offer card is selected far down the list.
  final GlobalKey _proceedButtonKey = GlobalKey();

  Timer? _debounce;
  bool isPlanLoaded = false;
  bool? isPaymentReceived;
  bool showOperatorDropdown = true;
  @override
  void initState() {
    super.initState();

    selectedOperator = widget.productName;
    selectedProductId = widget.productId;
    controller.productId.value = widget.productId;
    try {
      loadTabs();
    } catch (e) {
      AppLogger.logError(e.toString());
    }
    controller.getPlans(productid: widget.productId);
  }

  Future<void> loadTabs() async {
    await controller.getPlanTabs();

    if (controller.planTabs.isEmpty) return;

    _tabController = TabController(
      length: controller.planTabs.length,
      vsync: this,
    );

    selectedTabId = controller.planTabs.first.id.toString();

    controller.selectedTabId = selectedTabId; // FIX

    controller.applyTabFilter();
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) return;

      final tab = controller.planTabs[_tabController!.index];

      selectedTabId = tab.id.toString();

      controller.selectedTabId = selectedTabId;

      controller.applyTabFilter();

    
      _scrollToTop();
    });

    setState(() {});
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 🔹 NEW: Scrolls so the Proceed button row is visible. Used after a
  /// plan/offer card is selected — since the list can be long, the
  /// selected card (and therefore the Proceed button, which sits above
  /// the list) may be far off-screen from the user's current scroll
  /// position.
  void _scrollToProceedButton() {
    // Wait a frame so the button has actually been built/shown
    // (showNextButton just flipped to true inside setState).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        final ctx = _proceedButtonKey.currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            alignment: 0.5, // center it so it's clearly visible
          );
        }
      });
    });
  }

  void _showInactiveDialog(BuildContext context, Data operator) {
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: isDark ? AppColors.darkplceholder : Colors.white,
          surfaceTintColor: Colors.transparent, // prevents material 3 tint
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Operator Logo
                    if ((operator.logo ?? "").isNotEmpty)
                      Image.network(
                        operator.logo!,
                        width: 60.w,
                        height: 60.w,
                        fit: BoxFit.contain,
                      )
                    else
                      SizedBox(width: 60.w, height: 60.w),

                    SizedBox(width: 16.w),

                    // Text Details
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            operator.name ?? "Prepaid",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            operator.inactiveMessage ?? "Temporary Down",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Warning Icon
                    Icon(
                      Icons.warning_rounded,
                      color: const Color(0xffEF4444),
                      size: 45.w,
                    ),
                  ],
                ),
              ),

              // Close button
              Positioned(
                top: 8.h,
                right: 8.w,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.close,
                      color: const Color(0xffEF4444),
                      size: 20.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController?.dispose();
    mobileController.dispose();
    amountController.dispose();
    searchController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(title: 'Mobile Prepaid Recharge'),

      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// WALLET CARD
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

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    if (controller.operatorWebsite.value.isEmpty) {
                      return const SizedBox();
                    }

                    return InkWell(
                      onTap: () {
                        String url = controller.operatorWebsite.value.trim();

                        if (!url.startsWith("http")) {
                          url = "https://$url";
                        }

                        Get.to(
                          () => WebsiteView(
                            title: controller.operatorName.value,
                            url: url,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.language, color: Colors.blue),
                      ),
                    );
                  }),

                  const SizedBox(width: 8),
                  // Terms Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      showTermsDialog(context);
                    },
                    child: const Text(
                      "Terms",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),

              /// MOBILE NUMBER
              _buildInputLabel('Mobile Number'),

              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (String value) async {
                    setState(() {
                      showOperatorDropdown = value.isEmpty;
                    });

                    if (value.length == 10) {
                      await controller.checkOperator(value);

                      final matched = controller.selectedPlan.value;

                      if (matched != null) {
                        if (matched.isActive == 0) {
                          controller.selectedPlan.value = null;
                          _showInactiveDialog(context, matched);
                          return;
                        }

                        selectedOperator = matched.name ?? "";
                        selectedProductId = matched.id.toString();

                        await controller.searchPlans(selectedProductId, "");
                        controller.applyTabFilter();

                        setState(() {
                          isPlanLoaded = true;
                        });
                      }
                    } else {
                      controller.operatorName.value = "";
                      controller.operatorWebsite.value = "";

                      // Clear operator selection
                      controller.selectedPlan.value = null;
                      selectedOperator = "";
                      selectedProductId = "";
                      isPlanLoaded = false;
                      controller.filteredSearchPlans.clear();
                    }
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: 'Enter Mobile No',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.sp,
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    suffixIcon: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: mobileController,
                      builder: (context, value, child) {
                        final hasText = value.text.isNotEmpty;

                        return SizedBox(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (hasText)
                                InkWell(
                                  // onTap: () {
                                  //   mobileController.clear();
                                  //   setState(() {
                                  //     showOperatorDropdown =
                                  //         true; // back to dropdown when cleared
                                  //   });
                                  //   controller.operatorName.value = "";
                                  //   controller.operatorWebsite.value = "";
                                  // },
                                  onTap: () {
                                    mobileController.clear();

                                    controller.selectedPlan.value =
                                        null; // Clear selected operator
                                    selectedOperator = "";
                                    selectedProductId = "";
                                    isPlanLoaded = false;

                                    controller.operatorName.value = "";
                                    controller.operatorWebsite.value = "";

                                    // Clear plan list if needed
                                    controller.filteredSearchPlans.clear();

                                    setState(() {
                                      showOperatorDropdown = true;
                                    });
                                  },
                                  child: Icon(Icons.cancel, color: Colors.red),
                                ),
                              SizedBox(width: 8),
                              SizedBox(width: 8),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Loading indicator
                    if (controller.isLoading.value)
                      Padding(
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
                              "Detecting operator...",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Dropdown always active, even while loading
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkplceholder
                            : AppColors.clrplceholder,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Data>(
                          isExpanded: true,
                          value: controller.selectedPlan.value,
                          hint: const Text("Select Operator"),
                          items: controller.plans.map((Data operator) {
                            return DropdownMenuItem<Data>(
                              value: operator,
                              child: Row(
                                children: [
                                  if ((operator.logo ?? "").isNotEmpty)
                                    Image.network(
                                      operator.logo!,
                                      width: 40,
                                      height: 40,
                                    ),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(operator.name ?? "")),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (Data? value) async {
                            if (value == null) return;

                            if (value.isActive == 0) {
                              _showInactiveDialog(context, value);
                              return;
                            }

                            controller.selectedPlan.value = value;
                            selectedOperator = value.name ?? "";
                            selectedProductId = value.id.toString();

                            controller.operatorName.value = value.name ?? "";
                            controller.operatorWebsite.value =
                                value.description ?? "";

                            await controller.searchPlans(selectedProductId, "");
                            controller.applyTabFilter();

                            setState(() {
                              isPlanLoaded = true;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20.h),

              /// SEARCH / AMOUNT FIELD
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkplceholder
                        : AppColors.clrplceholder,
                    width: 1,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkplceholder
                        : AppColors.clrplceholder,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {
                        showNextButton = value.trim().isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 20.w,
                        right: 16.w,
                        top: 12.h,
                        bottom: 12.h,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              SizedBox(height: 15.h),

              SizedBox(height: 15.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff19A7CE), width: 1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Customer Payment",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff19A7CE),
                            decoration: TextDecoration.underline,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Not Received
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPaymentReceived = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isPaymentReceived == false,
                                    activeColor: Colors.red,
                                    onChanged: (_) {
                                      setState(() {
                                        isPaymentReceived = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Pending    ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Received
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPaymentReceived = true;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isPaymentReceived == true,
                                    activeColor: Colors.green,
                                    onChanged: (_) {
                                      setState(() {
                                        isPaymentReceived = true;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Paid",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// TABBAR BUTTONS
              Row(
                key:
                    _proceedButtonKey, // 🔹 NEW: target for auto-scroll after plan/offer selection
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Side
                  Row(
                    children: [
                      _buildSmallButton(
                        'Plan',
                        isSelected: isPlanSelected,
                        onTap: () {
                          setState(() {
                            isPlanSelected = true;
                          });
                        },
                      ),

                      SizedBox(width: 5.w),

                      _buildSmallButton(
                        'Offer',
                        isSelected: !isPlanSelected,
                        onTap: () async {
                          print("========== OFFER BUTTON CLICK ==========");

                          setState(() {
                            isPlanSelected = false;
                          });

                          final mobile = mobileController.text.trim();

                          print("Mobile Number : $mobile");

                          if (mobile.length != 10) {
                            print("Invalid Mobile Number");
                            CustomToast.error(
                              "Please enter valid mobile number",
                            );
                            return;
                          }

                          print("Calling getOffers API...");

                          await controller.getOffers(mobile);

                          print("API Completed");
                          print("Offer Count : ${controller.offerList.length}");

                          if (controller.offerList.isNotEmpty) {
                            for (final offer in controller.offerList) {
                              print("Amount : ${offer.rs}");
                              print("Description : ${offer.desc}");
                            }
                          }

                          print("========== END ==========");
                        },
                      ),
                    ],
                  ),

                  // Right Side
                  if (showNextButton)
                    GestureDetector(
                      onTap: () async {
                        String mobile = mobileController.text.trim();
                        String amount = amountController.text.trim();

                        AppLogger.debugPrint(
                          "========== Recharge Validation ==========",
                        );
                        AppLogger.debugPrint("Mobile Number      : $mobile");
                        AppLogger.debugPrint("Amount             : $amount");
                        AppLogger.debugPrint(
                          "Selected ProductID : $selectedProductId",
                        );
                        AppLogger.debugPrint(
                          "Selected Operator  : $selectedOperator",
                        );
                        AppLogger.debugPrint(
                          "Selected Plan      : ${controller.selectedPlan.value}",
                        );
                        AppLogger.debugPrint(
                          "Payment Received   : $isPaymentReceived",
                        );
                        AppLogger.debugPrint(
                          "=========================================",
                        );

                        // Mobile validation
                        if (mobile.isEmpty) {
                          CustomToast.error("Please enter mobile number");
                          return;
                        }

                        // Product ID validation
                        if (selectedProductId.isEmpty) {
                          CustomToast.error(
                            "Product ID not found. Please select operator again.",
                          );
                          return;
                        }

                        // Amount validation
                        if (amount.isEmpty) {
                          CustomToast.error("Please enter amount");
                          return;
                        }
                        if (isPaymentReceived == null) {
                          CustomToast.error("Please select payment status");
                          return;
                        }

                        print(
                          "Calling confirmtrans() with Product ID: $selectedProductId",
                        );
                        final requiredAmount = double.tryParse(amount) ?? 0.0;

                        final currentBalance =
                            Get.find<HomePageController>()
                                .walletBalance
                                .value
                                ?.data
                                ?.balance ??
                            0.0;

                        if (requiredAmount > currentBalance) {
                          Get.toNamed(
                            AppRoutes.insufficientBalance,
                            arguments: {
                              'currentBalance': currentBalance,
                              'requiredAmount': requiredAmount,
                            },
                          );
                          return;
                        }
                        await controller.confirmtrans(selectedProductId);

                        Get.toNamed(
                          AppRoutes.transconfirm,
                          arguments: {
                            "mobileNumber": mobile,
                            "productdetid": selectedProductId,
                            "amount": amount,
                            "paymentStatus": isPaymentReceived == true
                                ? "Paid"
                                : "Pending",
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 39.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.clrPrimary,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 20.h),

              /// TABBAR
              if (isPlanSelected)
                (_tabController == null ||
                        controller.planTabs.isEmpty ||
                        _tabController!.length != controller.planTabs.length)
                    ? (controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox.shrink())
                    : TabBar(
                        controller: _tabController!,
                        isScrollable: true,
                        indicatorColor: isDark
                            ? Colors.orange
                            : AppColors.clrSecondary,
                        labelColor: isDark
                            ? Colors.orange
                            : AppColors.clrSecondary,
                        unselectedLabelColor: Colors.grey,
                        dividerColor: Colors.transparent,
                        tabAlignment: TabAlignment.start,
                        // Fires immediately on tap (even if the same tab is
                        // tapped again), which is more reliable than relying
                        // solely on the TabController listener.
                        onTap: (index) {
                          // Let the scroll animation start after the current
                          // frame so the tab-switch rebuild doesn't cancel it.
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollToTop();
                          });
                        },
                        tabs: controller.planTabs
                            .map((tab) => Tab(text: tab.planType ?? ""))
                            .toList(),
                      ),

              SizedBox(height: 15.h),

              Obx(() {
                /// OFFER TAB
                if (!isPlanSelected) {
                  if (controller.isOfferLoading.value) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (controller.offerList.isEmpty) {
                    return const Center(child: Text("No Offers Found"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.offerList.length,
                    itemBuilder: (context, index) {
                      final offer = controller.offerList[index];
                      return _buildOfferCardCommon(
                        amount: offer.rs ?? "",
                        details: offer.desc ?? "",
                        onSelect: () {
                          amountController.text = offer.rs ?? "";

                          setState(() {
                            showNextButton = true;
                          });

                          // 🔹 NEW: bring the Proceed button into view in
                          // case this offer card was far down the list.
                          _scrollToProceedButton();
                        },
                      );
                    },
                  );
                }

                /// PLAN TAB (existing logic continues unchanged below)

                final isSearching = searchController.text.trim().isNotEmpty;

                print("isSearching : $isSearching");
                print("search text : ${searchController.text}");
                print(
                  "filtered count : ${controller.filteredSearchPlans.length}",
                );

                if (isSearching) {
                  final list = controller.filteredSearchPlans;

                  print("UI LIST COUNT : ${list.length}");

                  if (list.isEmpty) {
                    return const Center(child: Text("No Search Plans Found"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      print("Building Item : $index");

                      final plan = list[index];

                      return _buildPlanCardCommon(
                        amount: plan.amount?.toString() ?? "",
                        validity: plan.validity?.toString() ?? "",
                        details: plan.planDetails ?? "",
                        onBuy: () {
                          amountController.text = plan.amount.toString();

                          setState(() {
                            showNextButton = true;
                          });

                          // 🔹 NEW: bring the Proceed button into view in
                          // case this plan card was far down the list.
                          _scrollToProceedButton();
                        },
                      );
                    },
                  );
                }
                final list = controller.filteredSearchPlans;

                if (!isPlanLoaded) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    padding: EdgeInsets.all(20.r),
                    child: Center(
                      child: Text(
                        "Please Select Plan",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }

                if (list.isEmpty) {
                  return const Center(child: Text("No Plans Found"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final plan = list[index];

                    return _buildPlanCardCommon(
                      amount: plan.amount?.toString() ?? "",
                      validity: plan.validity?.toString() ?? "",
                      details: plan.planDetails ?? "",
                      onBuy: () {
                        amountController.text = plan.amount.toString();

                        setState(() {
                          showNextButton = true;
                        });

                        // 🔹 NEW: bring the Proceed button into view in
                        // case this plan card was far down the list.
                        _scrollToProceedButton();
                        // Recharge API call / Navigate
                      },
                    );
                  },
                );
              }),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCardCommon({
    required String amount,
    required String validity,
    required String details,
    required VoidCallback onBuy,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2F3349)
            : AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          if (Theme.of(context).brightness != Brightness.dark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP SECTION
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Amount
              Expanded(
                flex: 3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    amount.currencyIndian,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 32),

              /// Validity
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: validity,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: validity == "1" ? " day" : " days",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "validity",
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              /// Buy Button
              SizedBox(
                height: 28.h,
                child: ElevatedButton(
                  onPressed: onBuy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1DA1B8),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Select",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Divider(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black12
                : Colors.white24,
          ),

          SizedBox(height: 10.h),

          /// DETAILS
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details
                  .split('\n')
                  .where((e) => e.trim().isNotEmpty)
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text(
                        item.bulletText,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickContact() async {
    final status = await ph.Permission.contacts.request();

    if (!status.isGranted) return;

    final contacts = await FlutterContacts.getAll(
      properties: {ContactProperty.phone},
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContactListPage(
          mobileController: mobileController,
          contacts: contacts,
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildOfferCardCommon({
    required String amount,
    required String details,
    required VoidCallback onSelect,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3349) : AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  amount.currencyIndian,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              SizedBox(
                height: 28.h,
                child: ElevatedButton(
                  onPressed: onSelect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1DA1B8),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Select",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Divider(color: isDark ? Colors.white24 : Colors.black12),

          SizedBox(height: 10.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details
                  .split('\n')
                  .where((e) => e.trim().isNotEmpty)
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text(
                        item.bulletText,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton(
    String label, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.clrSecondary : AppColors.totalborde2,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.clrTextgrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Terms",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

• Please verify the mobile number before proceeding.

• Recharge once completed cannot be cancelled or refunded.

• Ensure customer payment has been received before processing the recharge.

• The operator is responsible for service activation and validity.

• Network delays may occur during peak hours.

• For any issues, please contact customer support.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            ''', style: TextStyle(fontSize: 14, height: 1.5)),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff19A7CE),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
