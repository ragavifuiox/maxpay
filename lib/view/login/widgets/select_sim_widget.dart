// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SimCardWidget extends StatelessWidget {
//   final String number;
//   final String simText;
//   final Color cardColor;
//   final VoidCallback onTap;

//   const SimCardWidget({
//     super.key,
//     required this.number,
//     required this.simText,
//     required this.cardColor,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 150.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: cardColor,
//           borderRadius: BorderRadius.circular(28.r),
//           boxShadow: [
//             BoxShadow(
//               color: cardColor.withOpacity(.30),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         clipBehavior: Clip.hardEdge,
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: CustomPaint(
//                 painter: WavePainter(),
//               ),
//             ),

//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 20.w,
//                 vertical: 18.h,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         number,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 2,
//                         ),
//                       ),

//                       Text(
//                         simText,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const Spacer(),

//                   const SimChip(),

//                   SizedBox(height: 10.h),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class SimChip extends StatelessWidget {
//   const SimChip({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 100.w,
//       height: 65.h,
//       child: CustomPaint(
//         painter: SimChipPainter(),
//       ),
//     );
//   }
// }

// class SimChipPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;

//     /// WHITE FRAME
//     final borderPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;

//     final path = Path()
//       ..moveTo(12, 0)
//       ..lineTo(w - 6, 0)
//       ..lineTo(w - 6, h - 18)
//       ..lineTo(w - 22, h)
//       ..lineTo(0, h)
//       ..lineTo(0, 12)
//       ..quadraticBezierTo(0, 0, 12, 0);

//     canvas.drawPath(path, borderPaint);

//     /// GOLD CHIP BODY
//     final chipRect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(14, 16, 78, 58),
//       const Radius.circular(10),
//     );

//     final chipPaint = Paint()
//       ..color = const Color(0xFFD7B24A);

//     canvas.drawRRect(chipRect, chipPaint);

//     /// CHIP BORDER
//     canvas.drawRRect(
//       chipRect,
//       Paint()
//         ..color = const Color(0xFF8C6417)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2,
//     );

//     /// INNER LINES
//     final linePaint = Paint()
//       ..color = const Color(0xFF9B701D)
//       ..strokeWidth = 2;

//     /// Horizontal
//     canvas.drawLine(
//       Offset(14, 32),
//       Offset(92, 32),
//       linePaint,
//     );

//     canvas.drawLine(
//       Offset(14, 58),
//       Offset(92, 58),
//       linePaint,
//     );

//     /// Vertical
//     canvas.drawLine(
//       Offset(30, 16),
//       Offset(30, 74),
//       linePaint,
//     );

//     canvas.drawLine(
//       Offset(76, 16),
//       Offset(76, 74),
//       linePaint,
//     );

//     /// CIRCLES
//     final circlePaint = Paint()
//       ..color = const Color(0xFFD7B24A)
//       ..style = PaintingStyle.fill;

//     final circleBorder = Paint()
//       ..color = const Color(0xFF9B701D)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     /// Top circle
//     canvas.drawCircle(
//       const Offset(53, 28),
//       12,
//       circlePaint,
//     );

//     canvas.drawCircle(
//       const Offset(53, 28),
//       12,
//       circleBorder,
//     );

//     /// Bottom circle
//     canvas.drawCircle(
//       const Offset(53, 45),
//       14,
//       circlePaint,
//     );

//     canvas.drawCircle(
//       const Offset(53, 45),
//       14,
//       circleBorder,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class WavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint1 = Paint()
//       ..color = Colors.white.withOpacity(0.12)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;

//     /// WAVES
//     for (int i = 0; i < 13; i++) {
//       final path = Path();

//       double startY = 35 + (i * 12);

//       path.moveTo(-20, startY);

//       path.cubicTo(
//         size.width * .20,
//         startY - 18,
//         size.width * .60,
//         startY + 20,
//         size.width + 20,
//         startY - 10,
//       );

//       canvas.drawPath(path, paint1);
//     }

//     /// RIGHT OVAL CURVES
//     final ovalPaint = Paint()
//       ..color = Colors.white.withOpacity(0.06)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;

//     for (int i = 0; i < 7; i++) {
//       canvas.drawOval(
//         Rect.fromCenter(
//           center: Offset(size.width * .85, size.height * .62),
//           width: 120 + (i * 60),
//           height: 70 + (i * 40),
//         ),
//         ovalPaint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }