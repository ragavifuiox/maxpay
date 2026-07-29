import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  // Data for each series
  static const List<FlSpot> _purchaseSpots = [
    FlSpot(0, .4),
    FlSpot(1, .9),
    FlSpot(2, .6),
    FlSpot(3, 1),
    FlSpot(4, 1.5),
    FlSpot(5, .4),
    FlSpot(6, 0),
    FlSpot(7, .5),
    FlSpot(8, 1.5),
  ];

  static const List<FlSpot> _successSpots = [
    FlSpot(0, .1),
    FlSpot(1, 1.2),
    FlSpot(2, 1.4),
    FlSpot(3, .6),
    FlSpot(4, 2.6),
    FlSpot(5, 3.4),
    FlSpot(6, 2.6),
    FlSpot(7, 3.3),
    FlSpot(8, 1.9),
  ];

  static const List<FlSpot> _failedSpots = [
    FlSpot(0, 1.6),
    FlSpot(1, 2.4),
    FlSpot(2, 1.8),
    FlSpot(3, 2.6),
    FlSpot(4, 3.5),
    FlSpot(5, 1.4),
    FlSpot(6, .5),
    FlSpot(7, 1.7),
    FlSpot(8, 3.4),
  ];

  // The exact x-indices that get a visible dot, on every line —
  // matches the reference screenshot: first point, peak point, last point.
  // static const Set<int> _dottedIndices = {1, 4, 8};

  // bool _isShownDot(FlSpot spot) => _dottedIndices.contains(spot.x.toInt());

  static bool _isTurningPoint(List<FlSpot> spots, double x) {
    final index = spots.indexWhere((s) => s.x == x);
    if (index == -1) return false;

    // Endpoints count as edges (first/last point of the line).
    if (index == 0 || index == spots.length - 1) return true;

    final prevY = spots[index - 1].y;
    final currY = spots[index].y;
    final nextY = spots[index + 1].y;

    final risingBefore = currY > prevY;
    final risingAfter = nextY > currY;

    // Direction changed -> this is a peak (top) or a valley (bottom).
    return risingBefore != risingAfter;
  }

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

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkbgBlack : Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.redAccent, width: 1),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 120.h,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 8,
                minY: 0,
                maxY: 4,

                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: isDark ? AppColors.chart1 : AppColors.chart2,
                    ),
                    top: BorderSide(
                      color: isDark ? AppColors.chart1 : AppColors.chart2,
                    ),
                    left: BorderSide.none,
                    right: BorderSide.none,
                  ),
                ),

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: isDark ? AppColors.chart1 : AppColors.chart2,
                      strokeWidth: 1,
                    );
                  },
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
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final style = TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isDark ? Colors.white : AppColors.chart,
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

                // Tap handling: only react when the tapped point is one of
                // the visible dots (x = 1, 4, or 8) on any of the 3 lines.
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
                          late final List<FlSpot> seriesSpots;
                          late final String seriesName;
                          late final Color color;

                          switch (barSpot.barIndex) {
                            case 0:
                              seriesSpots = _purchaseSpots;
                              seriesName = "Add Wallet";
                              color = Colors.blue;
                              break;
                            case 1:
                              seriesSpots = _successSpots;
                              seriesName = "Transaction";
                              color = Colors.green;
                              break;
                            case 2:
                              seriesSpots = _failedSpots;
                              seriesName = "Balance";
                              color = Colors.red;
                              break;
                            default:
                              continue;
                          }

                          if (!_isTurningPoint(seriesSpots, barSpot.x)) {
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
                  /// PURCHASE (Add Wallet)
                  LineChartBarData(
                    isCurved: false,
                    color: Colors.blue,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    curveSmoothness: 0,
                    belowBarData: BarAreaData(show: false),
                    spots: _purchaseSpots,
                    dotData: FlDotData(
                      checkToShowDot: (spot, barData) =>
                          _isTurningPoint(barData.spots, spot.x),
                      getDotPainter: (spot, a, b, c) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.blue,
                          strokeWidth: 0.1,
                          strokeColor: Colors.blue,
                        );
                      },
                    ),
                  ),

                  LineChartBarData(
                    isCurved: false,
                    color: Colors.green,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    spots: _successSpots,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) =>
                          _isTurningPoint(barData.spots, spot.x),
                      getDotPainter: (spot, a, b, c) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.green,
                          strokeWidth: 0.1,
                          strokeColor: Colors.green,
                        );
                      },
                    ),
                  ),

                  /// FAILED (Balance)
                  LineChartBarData(
                    isCurved: false,
                    color: Colors.red,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    spots: _failedSpots,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) =>
                          _isTurningPoint(barData.spots, spot.x),
                      getDotPainter: (spot, a, b, c) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.red,
                          strokeWidth: 0.1,
                          strokeColor: Colors.red,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 15.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Legend(color: Colors.blue, title: "Add Wallet", isDark: isDark),
              _Legend(
                color: Colors.green,
                title: "Transaction",
                isDark: isDark,
              ),
              _Legend(color: Colors.red, title: "Balance", isDark: isDark),
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.chart,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
