import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String? value;
  final Widget imageWidget;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? valueColor;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    this.value,
    required this.imageWidget,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.valueColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: bgColor ?? (isDark ? theme.colorScheme.surface : Colors.white),

          borderRadius: BorderRadius.circular(12.r),

          border: Border.all(
            color: borderColor ?? AppColors.clrPrimary,
            width: 0.8,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// IMAGE / ICON
            imageWidget,

            SizedBox(height: 10.h),

            /// TITLE
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

            /// VALUE
            if (value != null) ...[
              SizedBox(height: 2.h),

              Text(
                value!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  color: valueColor ?? theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 🔥 Zoom In + Zoom Out + Blink Animation
class BlinkingZoomCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const BlinkingZoomCard({super.key, required this.child, this.onTap});

  @override
  State<BlinkingZoomCard> createState() => _BlinkingZoomCardState();
}

class _BlinkingZoomCardState extends State<BlinkingZoomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    /// ZOOM ANIMATION
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    /// BLINK ANIMATION
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: RepaintBoundary(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
          // child: widget.child,
        ),
      ),
    );
  }
}
class AnimatedBorderCard extends StatefulWidget {
  final Widget child;

  const AnimatedBorderCard({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBorderCard> createState() => _AnimatedBorderCardState();
}

class _AnimatedBorderCardState extends State<AnimatedBorderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: BorderDotPainter(
            progress: controller.value,
          ),
          child: widget.child,
        );
      },
    );
  }
}


class BorderDotPainter extends CustomPainter {
  final double progress;

  BorderDotPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 12.0;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(radius),
    );

    final path = Path()..addRRect(rect);

    final metric = path.computeMetrics().first;

    final distance = metric.length * progress;

    final tangent = metric.getTangentForOffset(distance);

    if (tangent == null) return;

    final point = tangent.position;

    // Glow
    canvas.drawCircle(
      point,
      8,
      Paint()
        ..color = Colors.orange.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          10,
        ),
    );

    // Dot
    canvas.drawCircle(
      point,
      4,
      Paint()..color = Colors.orange,
    );
  }

  @override
  bool shouldRepaint(covariant BorderDotPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}