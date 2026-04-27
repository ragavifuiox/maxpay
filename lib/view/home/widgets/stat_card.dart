import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String? value;
  final Widget imageWidget;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;

  const StatCard({
    super.key,
    required this.title,
    this.value,
    required this.imageWidget,
    this.bgColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: bgColor ?? (isDark ? theme.colorScheme.surface : Colors.white),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              borderColor ?? theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 🔹 CUSTOM IMAGE / ICON WIDGET
          imageWidget,

          SizedBox(height: 10.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
              fontSize: 10.sp,
              color: textColor ?? theme.colorScheme.onSurface,
            ),
          ),
          if (value != null) ...[
            SizedBox(height: 2.h),
            Text(
              value!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,

                fontSize: 11.sp,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
