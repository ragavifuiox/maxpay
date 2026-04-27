import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/routes_path.dart';

class SelectSimPage extends StatelessWidget {
  const SelectSimPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface, size: 20.sp),
        ),
        title: Text(
          'Select Sim',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? 24.sp : 18.sp,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isTablet ? 600 : double.infinity),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: isTablet 
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SimSelectionCard(
                          simNumber: '1',
                          simName: 'SIM 1',
                          phoneNumber: '+91 98877342',
                          backgroundColor: const Color(0xFFE0F7FA),
                          textColor: const Color(0xFF0097A7),
                          onTap: () => context.push(AppRoutes.loginPhoneName),
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Expanded(
                        child: SimSelectionCard(
                          simNumber: '2',
                          simName: 'SIM 2',
                          phoneNumber: '+91 98877342',
                          backgroundColor: const Color(0xFFE8F5E9),
                          textColor: const Color(0xFF43A047),
                          onTap: () => context.push(AppRoutes.loginPhoneName),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimSelectionCard(
                        simNumber: '1',
                        simName: 'SIM 1',
                        phoneNumber: '+91 98877342',
                        backgroundColor: const Color(0xFFE0F7FA),
                        textColor: const Color(0xFF0097A7),
                        onTap: () => context.push(AppRoutes.loginPhoneName),
                      ),
                      SizedBox(height: 24.h),
                      SimSelectionCard(
                        simNumber: '2',
                        simName: 'SIM 2',
                        phoneNumber: '+91 98877342',
                        backgroundColor: const Color(0xFFE8F5E9),
                        textColor: const Color(0xFF43A047),
                        onTap: () => context.push(AppRoutes.loginPhoneName),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class SimSelectionCard extends StatelessWidget {
  final String simNumber;
  final String simName;
  final String phoneNumber;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const SimSelectionCard({
    super.key,
    required this.simNumber,
    required this.simName,
    required this.phoneNumber,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isTablet ? null : 220.w,
        height: isTablet ? 180.h : 140.h,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(isTablet ? 4.r : 2.r),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    simNumber,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 14.sp : 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  simName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 32.sp : 24.sp,
                    color: textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              phoneNumber,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: isTablet ? 22.sp : 18.sp,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
