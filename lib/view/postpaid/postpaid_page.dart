import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/postpaid/postpaid_confirm_transaction_page.dart';
import 'package:maxpay/view/recharge/confirm_transaction_page.dart';

class PostpaidPage extends StatefulWidget {
  const PostpaidPage({super.key});

  @override
  State<PostpaidPage> createState() => _PostPaidPageState();
}

class _PostPaidPageState extends State<PostpaidPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedOperator = 'Jio';
  Color _selectedOperatorColor = Colors.red;
  bool _isPlanSelected = true;
  bool _isPaymentReceived = false;
bool _isReceived = true;
  final List<Map<String, dynamic>> _operators = [
    {'name': 'Jio', 'color': Colors.red},
    {'name': 'Airtel', 'color': Colors.orange},
    {'name': 'VI', 'color': Colors.redAccent},
    {'name': 'BSNL', 'color': Colors.blue},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      appBar: const CommonAppBar(title: "Mobile Transaction"),
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
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '₹ 245005.23',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              /// 🔹 MOBILE NUMBER INPUT
              _buildInputLabel('Mobile Number'),
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder
                      : AppColors.clrplceholder,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: '9876543210',
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Divider(color: Colors.grey.withValues(alpha: 0.1)),
              SizedBox(height: 20.h),

              /// 🔹 SEARCH FOR PLANS
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkplceholder
                            : AppColors.clrplceholder,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for plans',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
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
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildSmallButton(
                    'Plan',
                    isSelected: _isPlanSelected,
                    onTap: () => setState(() => _isPlanSelected = true),
                  ),
                  SizedBox(width: 5.w),
                  _buildSmallButton(
                    'Offer',
                    isSelected: !_isPlanSelected,
                    onTap: () => setState(() => _isPlanSelected = false),
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              /// 🔹 PAYMENT RECEIVED CHECKBOX
            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _paymentOption(
                                  label: 'Not Received',
                                  color: Colors.red,
                                  selected: !_isReceived,
                                  onTap: () => setState(() => _isReceived = false),
                                ),
                                _paymentOption(
                                  label: 'Received',
                                  color: Colors.green,
                                  selected: _isReceived,
                                  onTap: () => setState(() => _isReceived = true),
                                ),
                              ],
                            ),
              SizedBox(height: 20.h),

              /// 🔹 TABS
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                tabAlignment: TabAlignment.start,
                labelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
                dividerColor: Colors.transparent,
                // tabAlignment: .start,
                tabs: const [
                  Tab(text: 'Entertainment Plan'),
                  Tab(text: 'Unlimited'),
                  Tab(text: 'Combo'),
                  Tab(text: 'Data'),
                ],
              ),
              SizedBox(height: 15.h),

              /// 🔹 PLAN LIST
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildPlanCard(index);
                },
              ),
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
          color: isSelected ? AppColors.clrSecondary : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
          border: !isSelected
              ? Border.all(color: Colors.grey.withValues(alpha: 0.5))
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(int index) {
    final amounts = ['365', '459', '760'];
    final data = ['2', '2.5', '2'];
    final validity = ['28', '28', '56'];

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkplceholder.withValues(alpha: 0.5)
            : AppColors.background,
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
                      text: amounts[index],
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
              Row(
                children: [
                  _buildPlanStat(data[index], ' GB/day', 'data'),
                  SizedBox(width: 15.w),
                  _buildPlanStat(validity[index], ' days', 'validity'),
                ],
              ),
              GestureDetector(
               
                  onTap: () {
  _showBillDetailsPopup(context);
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
          Padding(
            padding: EdgeInsets.only(left: 100.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPlanBullet('12am-12pm Unlimited Data'),
                _buildPlanBullet('Unlimited Calls'),
                _buildPlanBullet('Weekend Data Rollover'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanBullet(String text) {
    return Text(
      "• $text",
      style: TextStyle(fontSize: 11.sp, color: Colors.grey, height: 1.5),
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
  void _showBillDetailsPopup(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkbgBlack : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _billRow("Customer Name", "John"),
                  SizedBox(height: 10.h),
                  _billRow("Customer ID", "#10011887"),
                  SizedBox(height: 10.h),
                  _billRow("Bill Number", "#10011887"),
                  SizedBox(height: 10.h),
                  _billRow("Bill Date", "11/12/2024"),
                  SizedBox(height: 10.h),
                  _billRow("Bill Due Date", "11/12/2025"),
                  SizedBox(height: 10.h),
                  _billRow("Amount", "₹ 10,000"),

                  SizedBox(height: 20.h),

                  SizedBox(
                    width: 130.w,
                    height: 42.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.clrPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                       Get.to(PostpaidConfirmTransactionPage());

                       
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: -8,
              right: -8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.orange,
                    size: 20,
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
Widget _billRow(String title, String value) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    ],
  );
}
}