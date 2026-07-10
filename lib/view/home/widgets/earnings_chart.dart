// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:maxpay/core/constants/colors.dart';

// class EarningsChart extends StatelessWidget {
//   const EarningsChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(22.r),
//         border: Border.all(
//           color: Colors.redAccent,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 120.h,
//             child: LineChart(
//               LineChartData(
//                 minX: 0,
//                 maxX: 8,
//                 minY: 0,
//                 maxY: 4,

//                 borderData: FlBorderData(show: false),

//                 gridData: FlGridData(
//                   show: true,
//                   drawVerticalLine: false,
//                   horizontalInterval: 1,
//                   getDrawingHorizontalLine: (value) {
//                     return FlLine(
//                       color: Colors.orange.withOpacity(.25),
//                       strokeWidth: 1,
//                     );
//                   },
//                 ),

//                 titlesData: FlTitlesData(
//                   topTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   rightTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   bottomTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       reservedSize: 32,
//                       interval: 1,
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         switch (value.toInt()) {
//                           case 0:
//                             return const Text("0",style: TextStyle(fontSize: 12,fontWeight:FontWeight.w400,color: AppColors.chart),);
//                           case 1:
//                             return const Text("1k",style: TextStyle(fontSize: 12,fontWeight:FontWeight.w400,color: AppColors.chart),);
//                           case 2:
//                             return const Text("2k",style: TextStyle(fontSize: 12,fontWeight:FontWeight.w400,color: AppColors.chart),);
//                           case 3:
//                             return const Text("3k",style: TextStyle(fontSize: 12,fontWeight:FontWeight.w400,color: AppColors.chart),);
//                           case 4:
//                             return const Text("4k",style: TextStyle(fontSize: 12,fontWeight:FontWeight.w400,color: AppColors.chart),);
//                         }

//                         return const SizedBox();
//                       },
//                     ),
//                   ),
//                 ),

//                 lineBarsData: [

//                   /// PURCHASE
//                   LineChartBarData(
//                     isCurved: false,
//                     color: Colors.blue,
//                     barWidth: 2.5,
//                     isStrokeCapRound: true,
//                     belowBarData: BarAreaData(show: false),

//                     spots: const [
//                       FlSpot(0, .4),
//                       FlSpot(1, .9),
//                       FlSpot(2, .6),
//                       FlSpot(3, 1),
//                       FlSpot(4, 1.5),
//                       FlSpot(5, .4),
//                       FlSpot(6, 0),
//                       FlSpot(7, .5),
//                       FlSpot(8, 1.5),
//                     ],

//                     dotData: FlDotData(
//                       show: true,
//                       getDotPainter: (spot, p1, p2, p3) {
//                         return FlDotCirclePainter(
//                           radius: 4,
//                           color: Colors.white,
//                           strokeWidth: 1,
//                           strokeColor: Colors.blue,
//                         );
//                       },
//                     ),
//                   ),

//                   /// SUCCESS
//                   LineChartBarData(
//                     isCurved: false,
//                     color: Colors.green,
//                     barWidth: 2.5,
//                     isStrokeCapRound: true,
//                     belowBarData: BarAreaData(show: false),

//                     spots: const [
//                       FlSpot(0, .1),
//                       FlSpot(1, 1.2),
//                       FlSpot(2, 1.4),
//                       FlSpot(3, .6),
//                       FlSpot(4, 2.6),
//                       FlSpot(5, 3.4),
//                       FlSpot(6, 2.6),
//                       FlSpot(7, 3.3),
//                       FlSpot(8, 1.9),
//                     ],

//                     dotData: FlDotData(
//                       show: true,
//                       getDotPainter: (spot, p1, p2, p3) {
//                         return FlDotCirclePainter(
//                           radius: 4,
//                           color: Colors.white,
//                           strokeWidth: 1,
//                           strokeColor: Colors.green,
//                         );
//                       },
//                     ),
//                   ),

//                   /// FAILED
//                   LineChartBarData(
//                     isCurved: false,
//                     color: Colors.red,
//                     barWidth: 2.5,
//                     isStrokeCapRound: true,
//                     belowBarData: BarAreaData(show: false),

//                     spots: const [
//                       FlSpot(0, 1.6),
//                       FlSpot(1, 2.4),
//                       FlSpot(2, 1.8),
//                       FlSpot(3, 2.6),
//                       FlSpot(4, 3.5),
//                       FlSpot(5, 1.4),
//                       FlSpot(6, .5),
//                       FlSpot(7, 1.7),
//                       FlSpot(8, 3.4),
//                     ],

//                     dotData: FlDotData(
//                       show: true,
//                       getDotPainter: (spot, p1, p2, p3) {
//                         return FlDotCirclePainter(
//                           radius: 4,
//                           color: Colors.white,
//                           strokeWidth: 1,
//                           strokeColor: Colors.red,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           SizedBox(height: 15.h),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: const [
//               _Legend(
//                 color: Colors.blue,
//                 title: "Purchase",
//               ),
//               _Legend(
//                 color: Colors.green,
//                 title: "Success",
//               ),
//               _Legend(
//                 color: Colors.red,
//                 title: "Failed",
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class _Legend extends StatelessWidget {
//   final Color color;
//   final String title;

//   const _Legend({
//     required this.color,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//           ),
//         ),
//         const SizedBox(width: 6),
//         Text(
//           title,
//           style: TextStyle(
//             color:AppColors.chart,
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkFilterBorder : Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.redAccent, width: 1),
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
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
                      color: isDark
                          ? Colors.white.withValues(alpha: .20)
                          : Colors.orange.withValues(alpha: .25),
                    ),
                    top: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: .20)
                          : Colors.orange.withValues(alpha: .25),
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
                      color: isDark
                          ? Colors.white.withValues(alpha: .20)
                          : Colors.orange.withValues(alpha: .25),
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

                lineBarsData: [
                  /// PURCHASE
                  LineChartBarData(
                    isCurved: false,
                    color: Colors.blue,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    curveSmoothness: 0,
                    belowBarData: BarAreaData(show: false),
                    spots: const [
                      FlSpot(0, .4),
                      FlSpot(1, .9),
                      FlSpot(2, .6),
                      FlSpot(3, 1),
                      FlSpot(4, 1.5),
                      FlSpot(5, .4),
                      FlSpot(6, 0),
                      FlSpot(7, .5),
                      FlSpot(8, 1.5),
                    ],
                    // dotData: FlDotData(
                    //   show: true,
                    //   checkToShowDot: (spot, barData) {
                    //     final sortedSpots = List<FlSpot>.from(barData.spots);
                    //     sortedSpots.sort((a, b) => b.y.compareTo(a.y));
                    //     final topSpots = sortedSpots.take(2).toList();
                    //     return topSpots.any(
                    //       (s) => s.x == spot.x && s.y == spot.y,
                    //     );
                    //   },
                    //   getDotPainter: (spot, a, b, c) {
                    //     return FlDotCirclePainter(
                    //       radius: 2,
                    //       color: isDark
                    //           ? AppColors.darkFilterBorder
                    //           : Colors.white,
                    //       strokeWidth: 1.5,
                    //       strokeColor: Colors.blue,
                    //     );
                    //   },
                    // ),

                    dotData: FlDotData(
  show: true,
  checkToShowDot: (spot, barData) {
    final sortedSpots = List<FlSpot>.from(barData.spots);
    sortedSpots.sort((a, b) => b.y.compareTo(a.y));

    final topSpots = sortedSpots.take(2).toList();

    return topSpots.any(
      (s) => s.x == spot.x && s.y == spot.y,
    );
  },
  getDotPainter: (spot, a, b, c) {
    return FlDotCirclePainter(
      radius: 2,
      color: Colors.blue,
      strokeWidth: 1.5,
      strokeColor: Colors.blue,
    );
  },
),
                  ),

                  /// SUCCESS
                  LineChartBarData(
                    isCurved: false,
                    color: Colors.green,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    spots: const [
                      FlSpot(0, .1),
                      FlSpot(1, 1.2),
                      FlSpot(2, 1.4),
                      FlSpot(3, .6),
                      FlSpot(4, 2.6),
                      FlSpot(5, 3.4),
                      FlSpot(6, 2.6),
                      FlSpot(7, 3.3),
                      FlSpot(8, 1.9),
                    ],
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) {
                        final sortedSpots = List<FlSpot>.from(barData.spots);
                        sortedSpots.sort((a, b) => b.y.compareTo(a.y));
                        final topSpots = sortedSpots.take(3).toList();
                        return topSpots.any(
                          (s) => s.x == spot.x && s.y == spot.y,
                        );
                      },
                      getDotPainter: (spot, a, b, c) {



                        
                        return FlDotCirclePainter(
      radius: 2,
      color: Colors.green,
      strokeWidth: 1.5,
      strokeColor: Colors.green,
    );
                      },
                    ),
                  ),

                  /// FAILED
                  LineChartBarData(
                    isCurved: false,
                    color: Colors.red,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                    spots: const [
                      FlSpot(0, 1.6),
                      FlSpot(1, 2.4),
                      FlSpot(2, 1.8),
                      FlSpot(3, 2.6),
                      FlSpot(4, 3.5),
                      FlSpot(5, 1.4),
                      FlSpot(6, .5),
                      FlSpot(7, 1.7),
                      FlSpot(8, 3.4),
                    ],
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, barData) {
                        final sortedSpots = List<FlSpot>.from(barData.spots);
                        sortedSpots.sort((a, b) => b.y.compareTo(a.y));
                        final topSpots = sortedSpots.take(3).toList();
                        return topSpots.any(
                          (s) => s.x == spot.x && s.y == spot.y,
                        );
                      },
                      getDotPainter: (spot, a, b, c) {
                         return FlDotCirclePainter(
      radius: 2,
      color: Colors.red,
      strokeWidth: 1.5,
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
              _Legend(color: Colors.green, title: "Transaction", isDark: isDark),
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
