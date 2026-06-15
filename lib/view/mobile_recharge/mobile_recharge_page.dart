import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/view/mobile_recharge/contact_list_page.dart';
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
  late TabController _tabController;
  String selectedProductId = '';
  String selectedOperator = '';
  String selectedTabId = "";
  Data? selectedOperatorObj;
  final PrePaidController controller = Get.find<PrePaidController>();

  Color selectedOperatorColor = Colors.orange;

  bool isPlanSelected = true;

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  bool isPlanLoaded = false;

  @override
  void initState() {
    super.initState();

    selectedOperator = widget.productName;
    selectedProductId = widget.productId;

    loadTabs();
    controller.getPlans(productid: widget.productId);
    controller.getPlanTabs();

  searchController.addListener(() {
  if (_debounce?.isActive ?? false) {
    _debounce!.cancel();
  }

  _debounce = Timer(
    const Duration(milliseconds: 500),
    () {
      final text = searchController.text.trim();

      controller.searchPlans(
        selectedProductId,
        text, // empty irundhaalum call aagum
      );
    },
  );
});
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

  _tabController.addListener(() {
    if (_tabController.indexIsChanging) return;

    final tab = controller.planTabs[_tabController.index];

    selectedTabId = tab.id.toString();

    controller.selectedTabId = selectedTabId;

    controller.applyTabFilter();
  });

  setState(() {});
}
  @override
  void dispose() {
    _debounce?.cancel();

    _tabController.dispose();
    mobileController.dispose();
    amountController.dispose();
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
            size: 18.sp,
          ),

          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Mobile Recharge',

          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,

            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile No',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
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
                                  onTap: () {
                                    mobileController.clear(); // number remove
                                    setState(() {});
                                  },
                                  child: Icon(Icons.cancel, color: Colors.red),
                                ),

                              SizedBox(width: 8),

                              InkWell(
                                onTap: pickContact,
                                child: SvgPicture.asset(
                                  'assets/images/contact.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ),

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

              /// DROPDOWN FROM BACKEND
              _buildInputLabel('Select Operator'),

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

                      value:
                          controller.plans.any(
                            (e) => e.name == selectedOperator,
                          )
                          ? controller.plans.firstWhere(
                              (e) => e.name == selectedOperator,
                            )
                          : null,

                      hint: Text(
                        "Select",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),

                      icon: const Icon(Icons.arrow_drop_down),

                      selectedItemBuilder: (context) {
                        return controller.plans.map((operator) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  operator.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),

                              Container(
                                width: 30.w,
                                height: 30.w,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.r),
                                ),
                                child: Image.network(
                                  operator.logo ?? "",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      alignment: Alignment.center,
                                      child: Text(
                                        (operator.name ?? "O")[0].toUpperCase(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList();
                      },

                      items: controller.plans.map((Data operator) {
                        return DropdownMenuItem<Data>(
                          value: operator,

                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  operator.name ?? "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),

                              Container(
                                width: 30.w,
                                height: 30.w,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.r),
                                ),
                                child: Image.network(
                                  operator.logo ?? "",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      alignment: Alignment.center,
                                      child: Text(
                                        (operator.name ?? "O")[0].toUpperCase(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),

onChanged: (Data? value) async {
  if (value == null) return;

  setState(() {
    selectedOperator = value.name ?? "";
    selectedProductId = value.id?.toString() ?? "";
    isPlanLoaded = true;
  });

  searchController.clear();

  await controller.searchPlans(
    selectedProductId,
    "",
  );

  controller.applyTabFilter(); // add this
}
                    ),
                  ),
                );
              }),

              SizedBox(height: 15.h),

              SizedBox(height: 20.h),

              Divider(color: Colors.grey.withValues(alpha: 0.1)),

              SizedBox(height: 4.h),

              /// SEARCH
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkplceholder : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search for plans',

                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),

                    border: InputBorder.none,

                    contentPadding: EdgeInsets.only(
                      left: 20.w, // increase this
                      right: 16.w,
                      top: 12.h,
                      bottom: 12.h,
                    ),

                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.orange,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              /// BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  _buildSmallButton(
                    'Plan',

                    isSelected: isPlanSelected,

                    onTap: () => setState(() {
                      isPlanSelected = true;
                    }),
                  ),

                  SizedBox(width: 5.w),

                  _buildSmallButton(
                    'Offer',

                    isSelected: !isPlanSelected,

                    onTap: () => setState(() {
                      isPlanSelected = false;
                    }),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              /// CHECKBOX
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,

                    child: Checkbox(
                      value: true,
                      onChanged: (v) {},

                      activeColor: AppColors.clrPrimary,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  Text(
                    'Payment Received',

                    style: TextStyle(
                      fontSize: 13.sp,

                      fontWeight: FontWeight.w500,

                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// TABBAR
              Obx(() {
                if (controller.planTabs.isEmpty ||
                    _tabController.length != controller.planTabs.length) {
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
                  tabs: controller.planTabs.map((tab) {
                    return Tab(text: tab.planType ?? "");
                  }).toList(),
                );
              }),

              SizedBox(height: 15.h),

              /// PLAN LIST
             Obx(() {
  final isSearching = searchController.text.trim().isNotEmpty;

  print("isSearching : $isSearching");
  print("search text : ${searchController.text}");
  print("filtered count : ${controller.filteredSearchPlans.length}");

  if (isSearching) {
    final list = controller.filteredSearchPlans;

    print("UI LIST COUNT : ${list.length}");

    if (list.isEmpty) {
      return const Center(
        child: Text("No Search Plans Found"),
      );
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
        onBuy: () async {
          String mobile = mobileController.text.trim();

          mobile = mobile.replaceAll(RegExp(r'[^0-9]'), '');

          if (mobile.startsWith('91') && mobile.length == 12) {
            mobile = mobile.substring(2);
          }

          if (mobile.isEmpty) {
            CustomToast.error("Please enter phone number");
            return;
          }

          if (mobile.length != 10) {
            CustomToast.error(
              "Please enter valid 10 digit phone number",
            );
            return;
          }

          await controller.confirmtrans(
            plan.productId.toString(),
          );

          Get.toNamed(
            AppRoutes.transconfirm,
            arguments: {
              "type": "mobile",
              "mobileNumber": mobile,
              "productdetid": plan.productId.toString(),
            },
          );
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
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(18.r),
                    //   border: Border.all(color: Colors.grey.shade300),
                    // ),
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
  return const Center(
    child: Text("No Plans Found"),
  );
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

                      onBuy: () async {
                        String mobile = mobileController.text.trim();
                        AppLogger.logError("👉 PLAN ID RAW: ${plan.productId}");
                        AppLogger.logError(
                          "👉 PLAN ID STRING: ${plan.productId?.toString()}",
                        );

                        // Remove spaces, +, -, etc.
                        mobile = mobile.replaceAll(RegExp(r'[^0-9]'), '');

                        // Remove India country code if present
                        if (mobile.startsWith('91') && mobile.length == 12) {
                          mobile = mobile.substring(2);
                        }

                        if (mobile.isEmpty) {
                          CustomToast.error("Please enter phone number");
                          return;
                        }

                        if (mobile.length != 10) {
                          CustomToast.error(
                            "Please enter valid 10 digit phone number",
                          );
                          return;
                        }

                        AppLogger.logError("Validated Mobile: $mobile");

                        await controller.confirmtrans(
                          plan.productId.toString(),
                        );

                        Get.toNamed(
                          AppRoutes.transconfirm,
                          arguments: {
                            "mobileNumber": mobile,
                            "productdetid": plan.productId
                                .toString(), // ✅ FIXED // ✅ ADD THIS
                          },
                        );
                      },

                      // Recharge API call / Navigate
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
            ? AppColors.darkplceholder.withValues(alpha: 0.5)
            : AppColors.background,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.shade300),
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
                flex: 2,
                child: Text(
                  "₹$amount",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),

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
                    "Buy",
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

          Divider(color: Colors.grey.shade300, thickness: 1),

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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• ",
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
                          Expanded(
                            child: Text(
                              item.trim(),
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
                          ),
                        ],
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

  //   Widget _buildPlanCard(PlanData plan) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 15.h),
  //     padding: EdgeInsets.all(16.r),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).brightness == Brightness.dark
  //           ? AppColors.darkplceholder.withValues(alpha: 0.5)
  //           : AppColors.border,
  //       borderRadius: BorderRadius.circular(12.r),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "₹ ${plan.amount ?? ''}",
  //               style: TextStyle(
  //                 fontSize: 16.sp,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),

  //             Row(
  //               children: [
  //                 _buildPlanStat(
  //                   plan.talkTime?.toString() ?? "0",
  //                   " GB/day",
  //                   "data",
  //                 ),
  //                 SizedBox(width: 15.w),
  //                 _buildPlanStat(
  //                   plan.validity?.toString() ?? "0",
  //                   " days",
  //                   "validity",
  //                 ),
  //               ],
  //             ),

  //             GestureDetector(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (_) => ConfirmTransactionPage(
  //                       productName: selectedOperator,
  //                       operatorInitial:
  //                           selectedOperator.isNotEmpty
  //                               ? selectedOperator[0]
  //                               : "J",
  //                       operatorColor: selectedOperatorColor,
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: 16.w,
  //                   vertical: 6.h,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.clrPrimary,
  //                   borderRadius: BorderRadius.circular(6.r),
  //                 ),
  //                 child: const Text(
  //                   "buy",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),

  //         SizedBox(height: 15.h),

  //         Text(
  //           plan.planDetails ?? "",
  //           style: TextStyle(fontSize: 11.sp, color: Colors.grey),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPlanBullet(String text) {
  //   return Text(
  //     "• $text",

  //     style: TextStyle(
  //       fontSize: 11.sp,
  //       color: Colors.grey,
  //       height: 1.5,
  //       fontFamily: 'Poppins',
  //     ),
  //   );
  // }

  // Widget _buildPlanStat(String value, String subLabel, String label) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,

  //     children: [
  //       RichText(
  //         text: TextSpan(
  //           children: [
  //             TextSpan(
  //               text: value,

  //               style: TextStyle(
  //                 fontSize: 12.sp,

  //                 fontWeight: FontWeight.w500,

  //                 color: Theme.of(context).brightness == Brightness.dark
  //                     ? Colors.white
  //                     : Colors.black,
  //               ),
  //             ),

  //             TextSpan(
  //               text: subLabel,

  //               style: TextStyle(
  //                 fontSize: 8.sp,
  //                 fontFamily: 'Poppins',
  //                 color: Theme.of(context).brightness == Brightness.dark
  //                     ? Colors.white
  //                     : AppColors.clrTextgrey,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),

  //       Text(
  //         label,

  //         style: TextStyle(
  //           fontSize: 8.sp,
  //           fontFamily: 'Poppins',
  //           color: Colors.grey,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
