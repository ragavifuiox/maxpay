import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/view/recharge/confirm_transaction_page.dart';

class MobileRechargePage extends StatefulWidget {
  final String productId;
  final String productName;

  const MobileRechargePage({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  State<MobileRechargePage> createState() =>
      _MobileRechargePageState();
}

class _MobileRechargePageState
    extends State<MobileRechargePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final PrePaidController controller =
      Get.find<PrePaidController>();

  String selectedOperator = '';

  Color selectedOperatorColor =
      Colors.orange;

  bool isPlanSelected = true;

  final TextEditingController mobileController =
      TextEditingController();

  final TextEditingController amountController =
      TextEditingController();

  final TextEditingController searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: 4, vsync: this);

    selectedOperator =
        widget.productName;

    controller.getPlans(
      planId: widget.productId,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    mobileController.dispose();
    amountController.dispose();
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark =
        theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                isDark
                    ? Colors.white
                    : Colors.black,
            size: 18.sp,
          ),

          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Mobile Recharge',

          style: TextStyle(
            color:
                isDark
                    ? Colors.white
                    : Colors.black,

            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// WALLET CARD
              Container(
                width: double.infinity,

                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                ),

                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,

                  borderRadius:
                      BorderRadius.circular(
                        12.r,
                      ),
                ),

                child: Column(
                  children: [
                    Text(
                      'Wallet Balance',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Text(
                      '₹ 245005.23',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// MOBILE NUMBER
              _buildInputLabel(
                'Mobile Number',
              ),

              Container(
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? AppColors
                              .darkplceholder
                          : AppColors
                              .clrplceholder,

                  borderRadius:
                      BorderRadius.circular(
                        10.r,
                      ),
                ),

                child: TextField(
                  controller:
                      mobileController,

                  keyboardType:
                      TextInputType.phone,

                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly,
                  ],

                  style: TextStyle(
                    fontSize: 14.sp,

                    color:
                        isDark
                            ? Colors.white
                            : Colors.black,
                  ),

                  decoration: InputDecoration(
                    hintText: '9876543210',

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),

                    border: InputBorder.none,

                    contentPadding:
                        EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              /// DROPDOWN FROM BACKEND
              _buildInputLabel(
                'Select Operator',
              ),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),

                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors
                                .darkplceholder
                            : AppColors
                                .clrplceholder,

                    borderRadius:
                        BorderRadius.circular(
                          10.r,
                        ),
                  ),

                  child:
                      DropdownButtonHideUnderline(
                        child:
                            DropdownButton<Data>(
                              isExpanded: true,

                              dropdownColor:
                                  isDark
                                      ? AppColors
                                          .darkbgBlack
                                      : Colors
                                          .white,

                              value:
                                  controller
                                          .plans
                                          .any(
                                            (e) =>
                                                e.name ==
                                                selectedOperator,
                                          )
                                      ? controller
                                          .plans
                                          .firstWhere(
                                            (e) =>
                                                e.name ==
                                                selectedOperator,
                                          )
                                      : null,

                              hint: Text(
                                "Select Operator",

                                style:
                                    TextStyle(
                                      color:
                                          Colors
                                              .grey,

                                      fontSize:
                                          14.sp,
                                    ),
                              ),

                              icon: Icon(
                                Icons
                                    .arrow_drop_down,

                                color:
                                    isDark
                                        ? Colors
                                            .white
                                        : Colors
                                            .black,
                              ),

                              items:
                                  controller
                                      .plans
                                      .map(
                                        (
                                          Data operator,
                                        ) {
                                          return DropdownMenuItem<
                                            Data
                                          >(
                                            value:
                                                operator,

                                            child: Row(
                                              children: [
                                    Container(
  width: 28.w,
  height: 28.w,

  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white,
    border: Border.all(
      color: Colors.grey.shade300,
    ),
  ),

  child: ClipOval(
    child: Image.network(
      operator.logo ?? "",

      fit: BoxFit.cover,

      errorBuilder:
          (context, error, stackTrace) {
        return Center(
          child: Text(
            (operator.name ?? "O")[0]
                .toUpperCase(),

            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },

      loadingBuilder:
          (
            context,
            child,
            loadingProgress,
          ) {
        if (loadingProgress == null) {
          return child;
        }

        return const Center(
          child: SizedBox(
            width: 12,
            height: 12,
            child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
          ),
        );
      },
    ),
  ),
),

                                                SizedBox(
                                                  width:
                                                      10.w,
                                                ),

                                                Text(
                                                  operator.name ??
                                                      "",

                                                  style:
                                                      TextStyle(
                                                        fontSize:
                                                            14.sp,

                                                        color:
                                                            isDark
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                      .toList(),

                              onChanged: (
                                Data? value,
                              ) {
                                setState(() {
                                  selectedOperator =
                                      value?.name ??
                                      "";
                                });
                              },
                            ),
                      ),
                );
              }),

              SizedBox(height: 15.h),

              /// AMOUNT
              _buildInputLabel(
                'Amount',
              ),

              Container(
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? AppColors
                              .darkplceholder
                          : AppColors
                              .clrplceholder,

                  borderRadius:
                      BorderRadius.circular(
                        10.r,
                      ),
                ),

                child: TextField(
                  controller:
                      amountController,

                  keyboardType:
                      TextInputType.number,

                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly,
                  ],

                  style: TextStyle(
                    fontSize: 14.sp,

                    color:
                        isDark
                            ? Colors.white
                            : Colors.black,
                  ),

                  decoration: InputDecoration(
                    hintText:
                        'Enter Amount',

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),

                    border: InputBorder.none,

                    contentPadding:
                        EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Divider(
                color: Colors.grey.withValues(
                  alpha: 0.1,
                ),
              ),

              SizedBox(height: 20.h),

              /// SEARCH
              Container(
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? AppColors
                              .darkplceholder
                          : AppColors
                              .clrplceholder,

                  borderRadius:
                      BorderRadius.circular(
                        10.r,
                      ),
                ),

                child: TextField(
                  controller:
                      searchController,

                  decoration: InputDecoration(
                    hintText:
                        'Search for plans',

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),

                    border: InputBorder.none,

                    contentPadding:
                        EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
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
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: [
                  _buildSmallButton(
                    'Plan',

                    isSelected:
                        isPlanSelected,

                    onTap:
                        () => setState(() {
                          isPlanSelected =
                              true;
                        }),
                  ),

                  SizedBox(width: 5.w),

                  _buildSmallButton(
                    'Offer',

                    isSelected:
                        !isPlanSelected,

                    onTap:
                        () => setState(() {
                          isPlanSelected =
                              false;
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

                      activeColor:
                          AppColors.clrPrimary,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  Text(
                    'Payment Received',

                    style: TextStyle(
                      fontSize: 13.sp,

                      fontWeight:
                          FontWeight.w500,

                      color:
                          isDark
                              ? Colors.white70
                              : Colors.black87,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// TABBAR
              TabBar(
                controller: _tabController,

                isScrollable: true,

                indicatorColor:
                    Colors.orange,

                labelColor:
                    Colors.orange,

                unselectedLabelColor:
                    Colors.grey,

                tabAlignment:
                    TabAlignment.start,

                dividerColor:
                    Colors.transparent,

                tabs: const [
                  Tab(
                    text:
                        'Entertainment Plan',
                  ),

                  Tab(
                    text: 'Unlimited',
                  ),

                  Tab(
                    text: 'Combo',
                  ),

                  Tab(
                    text: 'Data',
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              /// PLAN LIST
              ListView.builder(
                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                itemCount: 3,

                itemBuilder: (
                  context,
                  index,
                ) {
                  return _buildPlanCard(
                    index,
                  );
                },
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(
    String label,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 8.h,
      ),

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
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 6.h,
        ),

        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.clrSecondary
                  : AppColors.totalborde2,

          borderRadius:
              BorderRadius.circular(6.r),
        ),

        child: Text(
          label,

          style: TextStyle(
            color:
                isSelected
                    ? Colors.white
                    : AppColors.clrTextgrey,

            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    int index,
  ) {
    final amounts = [
      '365',
      '459',
      '760',
    ];

    final data = [
      '2',
      '2.5',
      '2',
    ];

    final validity = [
      '28',
      '28',
      '56',
    ];

    return Container(
      margin: EdgeInsets.only(
        bottom: 15.h,
      ),

      padding: EdgeInsets.all(16.r),

      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness ==
                    Brightness.dark
                ? AppColors.darkplceholder
                    .withValues(alpha: 0.5)
                : AppColors.border,

        borderRadius:
            BorderRadius.circular(12.r),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [

              /// PRICE
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '₹ ',

                      style: TextStyle(
                        fontSize: 18.sp,

                        fontWeight:
                            FontWeight.w300,

                        color:
                            Theme.of(context)
                                        .brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),

                    TextSpan(
                      text: amounts[index],

                      style: TextStyle(
                        fontSize: 18.sp,

                        fontWeight:
                            FontWeight.w600,

                        color:
                            Theme.of(context)
                                        .brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              /// DATA & VALIDITY
              Row(
                children: [
                  _buildPlanStat(
                    data[index],
                    ' GB/day',
                    'data',
                  ),

                  SizedBox(width: 15.w),

                  _buildPlanStat(
                    validity[index],
                    ' days',
                    'validity',
                  ),
                ],
              ),

              /// BUY BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ConfirmTransactionPage(
                                productName:
                                    selectedOperator,

                                operatorInitial:
                                    selectedOperator
                                        .isNotEmpty
                                    ? selectedOperator[0]
                                    : "J",

                                operatorColor:
                                    selectedOperatorColor,
                              ),
                    ),
                  );
                },

                child: Container(
                  padding:
                      EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),

                  decoration: BoxDecoration(
                    color:
                        AppColors.clrPrimary,

                    borderRadius:
                        BorderRadius.circular(
                          6.r,
                        ),
                  ),

                  child: Text(
                    'buy',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          Padding(
            padding: EdgeInsets.only(
              left: 100.w,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                _buildPlanBullet(
                  '12am-12pm Unlimited Data',
                ),

                _buildPlanBullet(
                  'Unlimited Calls',
                ),

                _buildPlanBullet(
                  'Weekend Data Rollover',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanBullet(
    String text,
  ) {
    return Text(
      "• $text",

      style: TextStyle(
        fontSize: 11.sp,
        color: Colors.grey,
        height: 1.5,
      ),
    );
  }

  Widget _buildPlanStat(
    String value,
    String subLabel,
    String label,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,

                style: TextStyle(
                  fontSize: 12.sp,

                  fontWeight:
                      FontWeight.w500,

                  color:
                      Theme.of(context)
                                  .brightness ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),

              TextSpan(
                text: subLabel,

                style: TextStyle(
                  fontSize: 8.sp,

                  color:
                      Theme.of(context)
                                  .brightness ==
                              Brightness.dark
                          ? Colors.white
                          : AppColors
                              .clrTextgrey,
                ),
              ),
            ],
          ),
        ),

        Text(
          label,

          style: TextStyle(
            fontSize: 8.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}