import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:maxpay/controllers/dth_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/data/model/search_dth_model.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/string_ext.dart';
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
  String _selectedOperator = "";
  bool _showCustomerInfo = false;
  final PrePaidController controller = Get.put(
    PrePaidController(
      planUseCase: sl(),
      searchPlanUsecase: sl(),
      planDetailUseCase: sl(),
      transConfirmUseCase: sl(),
      mobileRechargeUseCase: sl(),
      plantabusecase: sl(),
      tabdetailusecase: sl(),
    ),
  );
  final DthController dthcontroller = Get.put(
    DthController(
      dthtabUseCase: sl(),
      searchdthusecase: sl(),
      confirmdthUsecase: sl(),
      dthrechargeusecase: sl(),
    ),
  );
  final TextEditingController customerIdController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  bool showNextButton = false;

  TabController? _tabController;

  String productId = "";

  @override
  void initState() {
    super.initState();

    print("Arguments => ${Get.arguments}");

    final args = Get.arguments;

    productId = args["productId"]?.toString() ?? "";
    final String selectedAmount = args['amount'] ?? '';
    print("ARGUMENT PRODUCT ID => $productId"); // ✅ ADD HERE

    print("ProductId => $productId");

    controller.getPlans(productid: productId);

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
  }

  Future<void> _triggerSearch() async {
    if (selectedOperatorObj == null) return;

    final amount = amountController.text.trim();

    if (amount.isEmpty) {
      // FLOW 1: only productId
      await dthcontroller.searchDth(selectedOperatorObj!.id.toString());
    } else {
      // FLOW 2: productId + amount
      await dthcontroller.searchDth(
        selectedOperatorObj!.id.toString(),
        amount: amount,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "DTH Recharge"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              /// 🔹 CUSTOMER ID INPUT
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  controller: customerIdController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Customer ID',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),

                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.red.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                        SizedBox(width: 10.w),
                        // Icon(Icons.person, color: Colors.orange, size: 20.sp),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// 🔹 OPERATOR SELECTION
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

                      hint: const Text("Select Operator"),

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
                                  // decoration: BoxDecoration(
                                  //   color: Colors.white,
                                  //   borderRadius: BorderRadius.circular(8.r),
                                  //   border: Border.all(color: Colors.grey.shade300),
                                  // ),
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

  print("Selected Name: ${value.name}");
  print("Selected ID: ${value.id}");

  setState(() {
    selectedOperatorObj = value;
  });

  await _triggerSearch();
}
                    ),
                  ),
                );
              }),
              SizedBox(height: 15.h),

              /// 🔹 AMOUNT INPUT
              Container(
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
                  onChanged: (value) async {
                    dthcontroller.enteredAmount.value = value;

                    await _triggerSearch();
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// 🔹 TOGGLE BUTTONS (Plan / Customer Info)
              SizedBox(height: 15.h),

            
              if (showNextButton) SizedBox(height: 15.h),

              /// 🔹 TOGGLE BUTTONS (Plan / Customer Info)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildToggleButton('Plan', !_showCustomerInfo, () {
                    setState(() {
                      _showCustomerInfo = false;
                    });
                  }),
                  SizedBox(width: 10.w),
                  _buildToggleButton('Customer Info', _showCustomerInfo, () {
                    setState(() {
                      _showCustomerInfo = true;
                    });
                  }),
                ],
              ),
              SizedBox(height: 20.h),

              if (!_showCustomerInfo) ...[
                /// 🔹 TABS FOR PLANS
                Obx(() {
                  if (dthcontroller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_tabController == null ||
                      dthcontroller.planTabs.isEmpty) {
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

                /// 🔹 PLAN LIST
                Obx(() {
                  final enteredAmount = dthcontroller.enteredAmount.value;

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

                    if (enteredAmount.isEmpty) {
                      addPlan(plan.oneMonth, "1 Month");
                      addPlan(plan.threeMonth, "3 Months");
                      addPlan(plan.sixMonth, "6 Months");
                      addPlan(plan.twelveMonth, "12 Months");
                    } else {
                      if (plan.oneMonth == enteredAmount) {
                        addPlan(plan.oneMonth, "1 Month");
                      }
                      if (plan.threeMonth == enteredAmount) {
                        addPlan(plan.threeMonth, "3 Months");
                      }
                      if (plan.sixMonth == enteredAmount) {
                        addPlan(plan.sixMonth, "6 Months");
                      }
                      if (plan.twelveMonth == enteredAmount) {
                        addPlan(plan.twelveMonth, "12 Months");
                      }
                    }
                  }

                  if (allPlans.isEmpty) {
                    return const Center(child: Text("No matching plans"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allPlans.length,
                    itemBuilder: (context, index) {
                      final item = allPlans[index];

                      return _buildPlanCard(
                        isDark,
                        item["plan"],
                        item["amount"],
                        item["validity"],

                        onBuy: () async {
                          if (customerIdController.text.trim().isEmpty) {
                            Get.snackbar("Error", "Please enter Customer ID");
                            return;
                          }

                          await dthcontroller.getconfirmdth(
                            item["plan"].productId.toString(),
                          );

                          Get.toNamed(
                            AppRoutes.confirmdth,
                            arguments: {
                              "type": "dth",
                              "customerId": customerIdController.text.trim(),
                              "productdetid": item["plan"].productId.toString(),
                              "amount": item["amount"].toString(),
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ] else ...[
                /// 🔹 CUSTOMER INFO SECTION
                _buildCustomerInfoSection(isDark),
              ],

              SizedBox(height: 30.h),
            ],
          ),
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
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
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

          /// AMOUNT | VALIDITY | BUY
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
                    backgroundColor: const Color(0xFF1DA1B8),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Buy",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputLabel('Customer Info'),

        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT SIDE

              /// RIGHT SIDE
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
                              AppColors.darkplceholder, // Left Dark Grey
                              AppColors.darkplceholder, // Right Dark Pink
                            ]
                          : [
                              const Color(0xFFF2F2F2), // Left Grey
                              const Color(0xFFFFE5EA), // Right Pink
                            ],
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow('Customer Name', 'Alagan', isDark),
                      _buildInfoRow('Current Balance', '1.98', isDark),
                      _buildInfoRow('Monthly Transaction', '641', isDark),
                      _buildInfoRow('Next Transaction', '25-Jul-2025', isDark),
                      _buildInfoRow(
                        'Plan Name',
                        'Tamil Basic Package Subscription 3 Months Renewal',
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
  }

  // Widget _buildLeftText(String text) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 18.h),
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         fontSize: 13.sp,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildRightText(String text) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 18.h),
  //     child: Text(
  //       text,
  //       style: TextStyle(
  //         fontSize: 13.sp,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   );
  // }
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
            width: 150.w, // 120 -> 150
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
