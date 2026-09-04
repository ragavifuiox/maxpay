import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:maxpay/controllers/dth_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/search_dth_model.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/core/data/model/plan_model.dart';

class DTHRechargePage extends StatefulWidget {
  const DTHRechargePage({super.key});

  @override
  State<DTHRechargePage> createState() => _DTHRechargePageState();
}

class _DTHRechargePageState extends State<DTHRechargePage>
    with SingleTickerProviderStateMixin {
  Data? selectedOperatorObj;
  String customerHint = "Enter Number";
  int? maxCustomerIdLength;
  bool? isPaymentReceived = true;
  bool showCustomerInfo = false;
  bool isPlanListVisible = false;

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

  final DthController dthcontroller = Get.put(
    DthController(
      dthtabUseCase: sl(),
      searchdthusecase: sl(),
      confirmdthUsecase: sl(),
      dthrechargeusecase: sl(),
      customerInfoUsecase: sl(),
    ),
  );

  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  final FocusNode _customerIdFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();
  final GlobalKey _customerIdKey = GlobalKey();
  final GlobalKey _amountKey = GlobalKey();
  final GlobalKey _proceedButtonKey =
      GlobalKey(); // used to scroll the Proceed button into view
  bool showClear = false;

  bool showNextButton = false;

  Map<String, dynamic>? selectedPlanData;

  TabController? _tabController;

  String productId = "";

  @override
  void initState() {
    super.initState();

    AppLogger.debugPrint("Arguments => ${Get.arguments}");

    final args = Get.arguments;
    customerIdController.addListener(() {
      setState(() {
        showClear = customerIdController.text.isNotEmpty;
      });
    });
    productId = args["productId"]?.toString() ?? "";
    final String selectedAmount = args['amount'] ?? '';
    AppLogger.debugPrint("ARGUMENT PRODUCT ID => $productId");
    AppLogger.debugPrint("ProductId => $productId");
    print("Before getPlans");

    print("ProductId = $productId");
    controller.getPlans(productid: productId);

    print("After getPlans");

    dthcontroller.getPlanTabs().then((_) {
      if (dthcontroller.planTabs.isNotEmpty) {
        _tabController = TabController(
          length: dthcontroller.planTabs.length,
          vsync: this,
        );

        dthcontroller.selectedPlanType.value =
            dthcontroller.planTabs.first.planType ?? "";

        setState(() {});
      }
    });

    // Auto-scroll when Customer ID field gets focus
    _customerIdFocusNode.addListener(() {
      if (_customerIdFocusNode.hasFocus) {
        _scrollToField(_customerIdKey);
      }
    });

    // Auto-scroll when Amount field gets focus
    _amountFocusNode.addListener(() {
      if (_amountFocusNode.hasFocus) {
        _scrollToField(_amountKey);
      }
    });
  }

  /// Scrolls the given field into view above the keyboard.
  void _scrollToField(GlobalKey key) {
    Future.delayed(const Duration(milliseconds: 300), () {
      final ctx = key.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      }
    });
  }

  /// Scrolls so the Proceed button row is visible. Used after a
  /// plan card is selected — since the plan list can be long, the
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
          surfaceTintColor: Colors.transparent,
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

  Future<void> _triggerSearch() async {
    if (selectedOperatorObj == null) return;

    final amount = amountController.text.trim();

    if (amount.isEmpty) {
      // FLOW 1: only productId
      await dthcontroller.searchDth(selectedOperatorObj!.id.toString());
    } else {}
  }

  bool _validateCustomerId() {
    final customerId = customerIdController.text.trim();
    if (customerId.isEmpty) {
      CustomToast.error("Please enter Customer ID");
      return false;
    }
    if (maxCustomerIdLength != null &&
        customerId.length != maxCustomerIdLength) {
      CustomToast.error("Please enter $maxCustomerIdLength digit number");
      return false;
    }
    return true;
  }

  Future<void> _onProceed() async {
    Data? op;
    for (final e in controller.plans) {
      if (e.id.toString() == productId) {
        op = e;
        break;
      }
    }
    if (op != null && op.isActive == 0) {
      _showInactiveDialog(context, op);
      return;
    }

    if (!_validateCustomerId()) return;
    if (isPaymentReceived == null) {
      CustomToast.error("Please select Customer Payment status");
      return;
    }
    final amount = amountController.text.trim();

    if (amount.isEmpty) {
      CustomToast.error("Please enter amount");
      return;
    }

    final requiredAmount = double.tryParse(amount) ?? 0.0;

    final currentBalance =
        Get.find<HomePageController>().walletBalance.value?.data?.balance ??
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

    String productDetailId = "";

    if (selectedPlanData != null) {
      productDetailId = selectedPlanData!["plan"].productId.toString();
    } else {
      if (dthcontroller.searchdthList.isNotEmpty) {
        productDetailId = dthcontroller.searchdthList.first.productId
            .toString();
      } else {
        // Fallback to operator ID natively if no plans exist
        productDetailId = productId;
      }
    }

    if (productDetailId.isEmpty) {
      CustomToast.error("Operator or Plan ID not available");
      return;
    }

    print("===== DTH DEBUG =====");
    print("Selected Plan: $selectedPlanData");
    print("Product Detail ID: $productDetailId");
    print("Operator ID: $productId");
    print("Customer ID: ${customerIdController.text}");
    print("Amount: ${amountController.text}");

    final response = await dthcontroller.getconfirmdth(productDetailId);

    Get.toNamed(
      AppRoutes.confirmdth,
      arguments: {
        "type": "dth",
        "customerId": customerIdController.text.trim(),
        "productdetid": productDetailId,
        "amount": amount,
        "paymentStatus": isPaymentReceived! ? "Paid" : "Pending",
        "isFromTranactionPage": true, // to bypass missing confirmData blocks
        "operator": selectedOperatorObj?.name ?? "",
        "logo": selectedOperatorObj?.logo ?? "",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "DTH Recharge"),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              /// 🔹 WALLET BALANCE CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF17AEBF),
                  borderRadius: BorderRadius.circular(14.r),
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
                    SizedBox(height: 6.h),
                    Obx(() {
                      final balance =
                          Get.find<HomePageController>().walletBalance.value;

                      return Text(
                        "₹ ${balance?.data?.balance ?? "0.00"}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              /// 🔹 OPERATOR DROPDOWN
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Container(
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
                      value: selectedOperatorObj,
                      hint: const Text("Select Product "),
                      items: controller.plans.map((Data operator) {
                        return DropdownMenuItem<Data>(
                          value: operator,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  operator.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if ((operator.logo ?? "").isNotEmpty)
                                Container(
                                  width: 45.w,
                                  height: 45.w,
                                  padding: EdgeInsets.all(5.w),
                                  child: Image.network(
                                    operator.logo!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
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

                        setState(() {
                          AppLogger.debugPrint(
                            "🔍 Operator selected => id: ${value.id}, name: ${value.name}",
                          );
                          AppLogger.debugPrint(
                            "🔍 Current productId variable BEFORE update => $productId",
                          );

                          selectedOperatorObj = value;

                          // ✅ Keep productId in sync with the selected operator
                          productId = value.id.toString();

                          customerHint =
                              (value.msgToNumber != null &&
                                  value.msgToNumber!.trim().isNotEmpty)
                              ? value.msgToNumber!
                              : "Enter Customer ID";

                          maxCustomerIdLength = int.tryParse(
                            value.digitsAllowed ?? "",
                          );

                          isPlanListVisible = false;

                          AppLogger.debugPrint(
                            "🔍 productId variable AFTER update => $productId",
                          );
                        });

                        await _triggerSearch();
                      },
                    ),
                  ),
                );
              }),

              SizedBox(height: 15.h),

              /// 🔹 CUSTOMER ID / MOBILE NUMBER INPUT + INFO BUTTON
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      key: _customerIdKey,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkplceholder
                            : AppColors.clrplceholder,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        controller: customerIdController,
                        focusNode: _customerIdFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          if (maxCustomerIdLength != null)
                            LengthLimitingTextInputFormatter(
                              maxCustomerIdLength!,
                            ),
                        ],
                        decoration: InputDecoration(
                          hintText: customerHint,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          suffixIcon: showClear
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 20.sp,
                                  ),
                                  onPressed: () {
                                    customerIdController.clear();
                                    setState(() {
                                      showClear = false;
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  _buildIconActionButton(
                    svgAsset: AssetImages.info,
                    label: "Info",
                    onTap: () async {
                      Data? op;
                      for (final e in controller.plans) {
                        if (e.id.toString() == productId) {
                          op = e;
                          break;
                        }
                      }

                      if (op != null && op.isActive == 0) {
                        _showInactiveDialog(context, op);
                        return;
                      }

                      if (!_validateCustomerId()) return;
                      final customerId = customerIdController.text.trim();

                      setState(() {
                        showCustomerInfo = true;
                      });

                      await dthcontroller.getCustomerInfo(
                        productId,
                        customerId,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              /// 🔹 AMOUNT INPUT + PLAN BUTTON
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      key: _amountKey,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkplceholder
                            : AppColors.clrplceholder,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        controller: amountController,
                        focusNode: _amountFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.done,
                        // NOTE: Amount field NEVER triggers the search API and
                        // NEVER filters the plan list. It only tracks whether
                        // the Proceed button should show, and clears any
                        // previously selected plan card so the user must
                        // re-select if they type a different amount manually.
                        onChanged: (value) {
                          setState(() {
                            selectedPlanData = null;
                            showNextButton = value.trim().isNotEmpty;
                          });

                          // 🚫 Do NOT call _triggerSearch() / dthcontroller.searchDth() here.
                          // 🚫 Do NOT update any Rx value that the plan list listens to —
                          // that would reactively re-filter/re-render plan cards on every keystroke.
                        },
                        onSubmitted: (value) {
                          // Pressing "Enter/Done" just dismisses the keyboard —
                          // it must NOT call the search API.
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: '₹0.00',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  _buildIconActionButton(
                    svgAsset: AssetImages.plan,
                    label: "Plan",
                    onTap: () {
                      if (selectedOperatorObj == null) {
                        CustomToast.error("Please Select a DTH Operator");
                        return;
                      }
                      if (!_validateCustomerId()) return;
                      setState(() {
                        showCustomerInfo = false;
                        isPlanListVisible = true;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              /// 🔹 CUSTOMER PAYMENT RECEIVED / NOT RECEIVED
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff19A7CE), width: 1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "Customer Payment",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff19A7CE),
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
                                onChanged: (value) {
                                  setState(() {
                                    isPaymentReceived = false;
                                  });
                                },
                              ),
                              Text(
                                "Pending",
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
                                onChanged: (value) {
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
              ),
              SizedBox(height: 20.h),

              if (showNextButton) ...[
                /// 🔹 PROCEED BUTTON (only when amount entered)
                Row(
                  key: _proceedButtonKey,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120.w,
                      height: 46.h,
                      child: ElevatedButton(
                        onPressed: _onProceed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.clrPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
              ],

              if (!showCustomerInfo) ...[
                if (!isPlanListVisible)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.orange,
                          size: 23.sp,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          selectedOperatorObj == null
                              ? "Please Select a DTH Operator"
                              : "Click 'Plan' button to view plans",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  /// 🔹 TABS FOR PLANS
                  Obx(() {
                    if (dthcontroller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_tabController == null ||
                        dthcontroller.planTabs.isEmpty ||
                        selectedOperatorObj == null) {
                      return const SizedBox();
                    }

                    return TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: Colors.orange,
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.grey,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      onTap: (index) {
                        final selected =
                            dthcontroller.planTabs[index].planType ?? "";

                        dthcontroller.selectedPlanType.value = selected;
                      },
                      tabs: dthcontroller.planTabs.map((tab) {
                        return Tab(text: tab.planType ?? "");
                      }).toList(),
                    );
                  }),
                  SizedBox(height: 15.h),

                  /// 🔹 PLAN LIST — reacts only to searchdthList / selectedPlanType,
                  /// NOT to the amount field, so typing an amount never
                  /// changes which plan cards are shown.
                  Obx(() {
                    final filteredPlans = dthcontroller.searchdthList.where((
                      plan,
                    ) {
                      return plan.planType ==
                          dthcontroller.selectedPlanType.value;
                    }).toList();

                    final List<Map<String, dynamic>> allPlans = [];

                    for (var plan in filteredPlans) {
                      void addPlan(String? amt, String validity) {
                        if (amt != null && amt.isNotEmpty && amt != "0") {
                          allPlans.add({
                            "amount": amt,
                            "validity": validity,
                            "plan": plan,
                          });
                        }
                      }

                      addPlan(plan.oneMonth, "1 Month");
                      addPlan(plan.threeMonth, "3 Months");
                      addPlan(plan.sixMonth, "6 Months");
                      addPlan(plan.twelveMonth, "12 Months");
                    }

                    if (selectedOperatorObj == null) {
                      return const SizedBox();
                    }

                    if (allPlans.isEmpty) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.orange,
                              size: 23.sp,
                            ),
                            Text(
                              "No Plans Found",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            // Text(
                            //   "No plans are available for the selected operator.",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: Colors.black,
                            //     fontSize: 14.sp,
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allPlans.length,
                      itemBuilder: (context, index) {
                        final item = allPlans[index];

                        final isSelected =
                            selectedPlanData != null &&
                            selectedPlanData!["plan"] == item["plan"] &&
                            selectedPlanData!["amount"] == item["amount"];

                        return _buildPlanCard(
                          isDark,
                          item["plan"],
                          item["amount"],
                          item["validity"],
                          isSelected: isSelected,
                          onBuy: () {
                            // Selecting a card ONLY fills the amount
                            // field. It does NOT navigate anywhere.
                            setState(() {
                              selectedPlanData = item;
                              amountController.text = item["amount"].toString();
                              showNextButton = true;
                            });

                            // if this card is far down a long list,
                            // bring the Proceed button into view so the
                            // user doesn't have to manually scroll back up.
                            _scrollToProceedButton();
                          },
                        );
                      },
                    );
                  }),
                ],
              ] else if (showCustomerInfo) ...[
                _buildCustomerInfoSection(isDark),
              ],

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customerIdFocusNode.dispose();
    _amountFocusNode.dispose();
    _scrollController.dispose();
    customerIdController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Colors.orange,
          decoration: TextDecoration.underline,
          decorationColor: Colors.orange,
          decorationThickness: 2,
        ),
      ),
    );
  }

  /// Small teal square action button used beside the Customer ID field
  /// ("Info") and the Amount field ("Plan"), matching the target design.
  Widget _buildIconActionButton({
    required String svgAsset,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 58.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color(0xFF17AEBF),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgAsset,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              height: 20.h,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.clrSecondary : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: isActive
              ? null
              : Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    bool isDark,
    SearchDthData plan,
    String amount,
    String validity, {
    required VoidCallback onBuy,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF1DA1B8)
              : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// PLAN NAME
          Text(
            plan.planName ?? "",
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),

          SizedBox(height: 15.h),

          /// AMOUNT | VALIDITY | SELECT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// AMOUNT
              Text(
                "₹ $amount",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              /// VALIDITY
              Column(
                children: [
                  Text(
                    validity,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    "Validity",
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 28.h,
                child: ElevatedButton(
                  onPressed: onBuy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? const Color(0xFF14808F)
                        : const Color(0xFF1DA1B8),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    isSelected ? "Selected" : "Select",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Divider(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            thickness: 1,
          ),

          SizedBox(height: 12.h),

          /// DESCRIPTION
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (plan.planDetails ?? '')
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanStat(String value, String subLabel, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              TextSpan(
                text: subLabel,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.clrTextgrey,
                ),
              ),
            ],
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 8.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildCustomerInfoSection(bool isDark) {
    return Obx(() {
      if (dthcontroller.isCustomerInfoLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final records = dthcontroller.customerInfo.value?.data?.records;
      final record = (records != null && records.isNotEmpty)
          ? records.first
          : null;

      if (record == null) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text("No customer info available"),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: const [0.47, 0.47],
                        colors: isDark
                            ? [
                                AppColors.darkplceholder,
                                AppColors.darkplceholder,
                              ]
                            : [
                                const Color(0xFFF2F2F2),
                                const Color(0xFFFFE5EA),
                              ],
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          'Customer Name',
                          record.customername ?? '-',
                          isDark,
                        ),
                        _buildInfoRow(
                          'Current Balance',
                          record.balance ?? '-',
                          isDark,
                        ),
                        _buildInfoRow(
                          'Monthly Transaction',
                          record.monthlyrecharge ?? '-',
                          isDark,
                        ),
                        _buildInfoRow(
                          'Next Transaction',
                          record.nextrechargedate ?? '-',
                          isDark,
                        ),
                        _buildInfoRow(
                          'Plan Name',
                          record.planname ?? '-',
                          isDark,
                          isMultiLine: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildInfoRow(
    String label,
    String value,
    bool isDark, {
    bool isMultiLine = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: isMultiLine
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150.w,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
