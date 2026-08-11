import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  // Data for each series
  static const List<FlSpot> _purchaseSpots = [
    FlSpot(0, .4),
    FlSpot(1, .76),
    FlSpot(2, .5),
    FlSpot(3, .89),
    FlSpot(4, 1.45),
    FlSpot(5, .3),
    FlSpot(6, 0),
    FlSpot(7, .5),
    FlSpot(8, 1.45),
  ];

  static const List<FlSpot> _successSpots = [
    FlSpot(0, .1),
    FlSpot(1, 1.05),
    FlSpot(2, 1.3),
    FlSpot(3, .55),
    FlSpot(4, 2.9),
    FlSpot(5, 1.79),
    FlSpot(6, 1.25),
    FlSpot(7, 2.45),
    FlSpot(8, 1.8),
  ];

  static const List<FlSpot> _failedSpots = [
    FlSpot(0, 1.5),
    FlSpot(1, 2.35),
    FlSpot(2, 1.75),
    FlSpot(3, 2.5),
    FlSpot(4, 3.5),
    FlSpot(5, 1.4),
    FlSpot(6, .45),
    FlSpot(7, 1.6),
    FlSpot(8, 3.4),
  ];

  void _showDummyDataDialog(
    BuildContext context, {
    required String seriesName,
    required Color color,
    required FlSpot spot,
    required bool isDark,
  }) {
    // Replace this with a real data lookup keyed by spot.x if you have one.
    final dummyDate = "Day ${spot.x.toInt() + 1}";
    final dummyValue = "${(spot.y * 1000).toStringAsFixed(0)} pts";
    final dummyCount = "${(spot.y * 12).round()} txns";

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkbgBlack : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 8.w),
              Text(
                seriesName,
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.chart,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogRow("Date", dummyDate, isDark),
              _dialogRow("Value", dummyValue, isDark),
              _dialogRow("Transactions", dummyCount, isDark),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogRow(String label, String value, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 13.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.chart,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color clrAddWallet = const Color(0xFF0088FF); // Blue
    final Color clrTransaction = const Color(0xFFFF8D28); // Orange
    final Color clrWallet = const Color(0xFF17A2B8); // Teal
    final Color clrGrid = const Color(0xFF4cd964); // Dashed Green

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkbgBlack : Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFFF6B6B), width: 1.2),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          SizedBox(
            height: 120.h,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 8,
                minY: 0,
                maxY: 4,
                clipData: FlClipData.none(),
                borderData: FlBorderData(show: false),

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: clrGrid,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    );
                  },
                ),

                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: 0,
                      color: clrGrid,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),
                    HorizontalLine(
                      y: 4,
                      color: clrGrid,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),
                  ],
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final style = TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF6C6C80),
                        );

                        switch (value.toInt()) {
                          case 0:
                            return Text("0", style: style);
                          case 1:
                            return Text("1k", style: style);
                          case 2:
                            return Text("2k", style: style);
                          case 3:
                            return Text("3k", style: style);
                          case 4:
                            return Text("4k", style: style);
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                ),

                // Tap handling: every point on every line now has a visible
                // dot, so every point responds to taps.
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (_) => [],
                  ),
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? response) {
                        if (event is! FlTapUpEvent) return;
                        if (response == null || response.lineBarSpots == null) {
                          return;
                        }

                        for (final barSpot in response.lineBarSpots!) {
                          late final String seriesName;
                          late final Color color;

                          switch (barSpot.barIndex) {
                            case 0:
                              seriesName = "Add Wallet";
                              color = clrAddWallet;
                              break;
                            case 1:
                              seriesName = "Transaction";
                              color = clrTransaction;
                              break;
                            case 2:
                              seriesName = "Wallet";
                              color = clrWallet;
                              break;
                            default:
                              continue;
                          }

                          _showDummyDataDialog(
                            context,
                            seriesName: seriesName,
                            color: color,
                            spot: FlSpot(barSpot.x, barSpot.y),
                            isDark: isDark,
                          );
                          break;
                        }
                      },
                ),

                lineBarsData: [
                  /// Blue (Add Wallet)
                  LineChartBarData(
                    isCurved: false,
                    color: clrAddWallet,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    spots: _purchaseSpots,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, a, b, c) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: clrAddWallet,
                          strokeWidth: 0,
                          strokeColor: Colors.transparent,
                        );
                      },
                    ),
                  ),

                  /// Orange (Transaction)
                  LineChartBarData(
                    isCurved: false,
                    color: clrTransaction,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    spots: _successSpots,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, a, b, c) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: clrTransaction,
                          strokeWidth: 0,
                          strokeColor: Colors.transparent,
                        );
                      },
                    ),
                  ),

                  /// Teal (Wallet)
                  LineChartBarData(
                    isCurved: false,
                    color: clrWallet,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    spots: _failedSpots,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) => spot.x != 3,
                      getDotPainter: (spot, a, b, c) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: clrWallet,
                          strokeWidth: 0,
                          strokeColor: Colors.transparent,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Legend(color: clrAddWallet, title: "Add Wallet", isDark: isDark),
              _Legend(
                color: clrTransaction,
                title: "Transaction",
                isDark: isDark,
              ),
              _Legend(color: clrWallet, title: "Wallet", isDark: isDark),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String title;
  final bool isDark;

  const _Legend({
    required this.color,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white70 : const Color(0xFF555566),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
