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
  final bool needSpacingbwImage;

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
    this.needSpacingbwImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.15,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          decoration: BoxDecoration(
            color:
                bgColor ?? (isDark ? theme.colorScheme.surface : Colors.white),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: borderColor ?? AppColors.clrPrimary,
              width: 0.8,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
     
              Flexible(
                flex: 3,
                child: SizedBox(
                  height: 36.h,
                  child: Center(child: imageWidget),
                ),
              ),

              if (needSpacingbwImage) SizedBox(height: 2.h),

           
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: textColor ?? theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              if (value != null) ...[
                SizedBox(height: 2.h),
                Flexible(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      value!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: valueColor ?? theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
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

  const AnimatedBorderCard({super.key, required this.child});

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
      builder: (_, _) {
        return CustomPaint(
          painter: BorderDotPainter(progress: controller.value),
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
        ..color = Colors.orange.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // Dot
    canvas.drawCircle(point, 4, Paint()..color = Colors.orange);
  }

  @override
  bool shouldRepaint(covariant BorderDotPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
