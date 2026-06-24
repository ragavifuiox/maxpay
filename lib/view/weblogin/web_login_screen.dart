import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/web_login_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({super.key});

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  final WebLoginController controller =
      Get.find<WebLoginController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetScanner();
    });

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// FULL SCREEN CAMERA
          MobileScanner(
            fit: BoxFit.cover,
            onDetect: (capture) async {
              if (controller.isScanned.value) return;

              final barcode =
                  capture.barcodes.first.rawValue;

              if (barcode != null &&
                  barcode.isNotEmpty) {
                controller.scannedUserId.value =
                    barcode;

                controller.isScanned.value = true;

                await controller.submitLogin();
              }
            },
          ),

          /// DARK OVERLAY WITH TRANSPARENT CENTER
          const ScannerOverlay(),

          /// TOP HEADER
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Text(
                    "Scan & Web Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// SCANNER FRAME
          Center(
            child: SizedBox(
              width: 280.w,
              height: 280.w,
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (_, __) {
                    return CustomPaint(
                      painter: ScannerPainter(
                        animationController.value,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          /// BOTTOM TEXT
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "Scan QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Place QR code inside the frame",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    const double scanSize = 280;

    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.black54,
        BlendMode.srcOut,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              backgroundBlendMode: BlendMode.dstOut,
            ),
          ),
          Center(
            child: Container(
              width: scanSize,
              height: scanSize,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerPainter extends CustomPainter {
  final double value;

  ScannerPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    const double gap = 15;
    const double corner = 40;
    const double stroke = 6;

    final left = gap;
    final top = gap;
    final right = size.width - gap;
    final bottom = size.height - gap;

    final paint = Paint()
      ..color = AppColors.clrPrimary
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    // Top Left
    canvas.drawLine(
      Offset(left, top),
      Offset(left + corner, top),
      paint,
    );
    canvas.drawLine(
      Offset(left, top),
      Offset(left, top + corner),
      paint,
    );

    // Top Right
    canvas.drawLine(
      Offset(right, top),
      Offset(right - corner, top),
      paint,
    );
    canvas.drawLine(
      Offset(right, top),
      Offset(right, top + corner),
      paint,
    );

    // Bottom Left
    canvas.drawLine(
      Offset(left, bottom),
      Offset(left + corner, bottom),
      paint,
    );
    canvas.drawLine(
      Offset(left, bottom),
      Offset(left, bottom - corner),
      paint,
    );

    // Bottom Right
    canvas.drawLine(
      Offset(right, bottom),
      Offset(right - corner, bottom),
      paint,
    );
    canvas.drawLine(
      Offset(right, bottom),
      Offset(right, bottom - corner),
      paint,
    );

    // Scan Line
    final y = top + ((bottom - top) * value);

    final scanPaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 3;

    canvas.drawLine(
      Offset(left + 10, y),
      Offset(right - 10, y),
      scanPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScannerPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}