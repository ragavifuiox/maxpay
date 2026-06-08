import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class DTHRechargePage extends StatefulWidget {
  const DTHRechargePage({super.key});

  @override
  State<DTHRechargePage> createState() => _DTHRechargePageState();
}

class _DTHRechargePageState extends State<DTHRechargePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedOperator = 'Airtel TV';
  Color _selectedOperatorColor = Colors.red;
  bool _showCustomerInfo = false;

  final List<Map<String, dynamic>> _operators = [
    {'name': 'Airtel TV', 'color': Colors.red},
    {'name': 'Dish TV', 'color': Colors.orange},
    {'name': 'Tata Play', 'color': Colors.blue},
    {'name': 'Sun Direct', 'color': Colors.yellow},
    {'name': 'Videocon d2h', 'color': Colors.green},
  ];

  final TextEditingController amountController =
    TextEditingController();

bool showNextButton = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _showOperatorSelector(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDark ? AppColors.darkbgBlack : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(20.r),
            width: 300.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Operator',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.orange,
                        size: 20.sp,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.withValues(alpha: 0.1)),
                ..._operators.map(
                  (op) => ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    leading: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: op['color'],
                      child: Text(
                        op['name'][0],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      op['name'],
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedOperator = op['name'];
                        _selectedOperatorColor = op['color'];
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar:CommonAppBar(title: "DTH Recharge"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 WALLET BALANCE CARD
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
                        fontSize: 20.sp,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Customer ID',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
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
                        Icon(Icons.person, color: Colors.orange, size: 20.sp),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// 🔹 OPERATOR SELECTION
              GestureDetector(
                onTap: () => _showOperatorSelector(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkplceholder
                        : AppColors.clrplceholder,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        backgroundColor: _selectedOperatorColor,
                        child: Text(
                          _selectedOperator[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        _selectedOperator,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
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
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
    ],
    onChanged: (value) {
      setState(() {
        showNextButton = value.trim().isNotEmpty;
      });
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





if (showNextButton) ...[
  SizedBox(height: 10.h),

  Align(
    alignment: Alignment.centerRight,
    child: SizedBox(
      height: 38.h,
      width: 90.w,
      child: ElevatedButton(
        onPressed: () {
          AppLogger.debugPrint(amountController.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.clrPrimary,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          "Next",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),

  SizedBox(height: 15.h),
],
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
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.grey,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  tabs: const [
                    Tab(text: 'Entertainment Plan'),
                    Tab(text: 'Combo'),
                  ],
                ),
                SizedBox(height: 15.h),

                /// 🔹 PLAN LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildPlanCard(isDark);
                  },
                ),
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

  Widget _buildPlanCard(bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkplceholder.withValues(alpha: 0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '₹ ',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "365",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Row(children: [_buildPlanStat("28", ' days', 'validity')]),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ConfirmTransactionPage(
                  //       // productName: _selectedOperator,
                  //       // operatorInitial: _selectedOperator[0],
                  //       // operatorColor: _selectedOperatorColor,

                  //       // amount: "365",
                        
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'buy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            '• 12am-12pm Unlimited Data\n• Unlimited Calls\n• Weekend Data Rollover',
            style: TextStyle(fontSize: 11.sp, color: Colors.grey, height: 1.5),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT SIDE
            
            

            /// RIGHT SIDE
            Expanded(
              flex: 5,
              child:
               Container(
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
)
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
