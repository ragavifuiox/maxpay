import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 150.h,
      width: MediaQuery.of(context).size.width.w,

      decoration: BoxDecoration(
        color: !isDark
            ? AppColors.clrBg
            : AppColors.clrBg.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return const FlLine(color: Colors.transparent, strokeWidth: 0);
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.21)
                    : AppColors.clrTextgrey.withValues(alpha: 0.2),
                strokeWidth: .8,
                dashArray: [5, 5],
              );
            },
          ),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 4),
                FlSpot(2, 3.2),
                FlSpot(3, 4.2),
                FlSpot(4, 4),
                FlSpot(5, 5),
                FlSpot(6, 2),
                FlSpot(7, 2.5),
                FlSpot(8, 3.5),
                FlSpot(9, 2.8),
                FlSpot(10, 2),
              ],
              isCurved: true,
              color: isDark ? AppColors.redClr : AppColors.blueColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    isDark
                        ? AppColors.redClr.withValues(alpha: 0.3)
                        : AppColors.blueColor.withValues(alpha: 0.3),
                    isDark
                        ? AppColors.redClr.withValues(alpha: 0.01)
                        : AppColors.blueColor.withValues(alpha: 0.01),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
