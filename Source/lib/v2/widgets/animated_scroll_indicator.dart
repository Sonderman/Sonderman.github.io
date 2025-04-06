import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart';

class AnimatedScrollIndicator extends StatefulWidget {
  final ScrollController scrollController;

  const AnimatedScrollIndicator({super.key, required this.scrollController});

  @override
  State<AnimatedScrollIndicator> createState() => _AnimatedScrollIndicatorState();
}

class _AnimatedScrollIndicatorState extends State<AnimatedScrollIndicator> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final isScrolled = widget.scrollController.hasClients && widget.scrollController.offset > 50;
    if (_isVisible == isScrolled) {
      setState(() {
        _isVisible = !isScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        // Use theme colors
        const Color indicatorColor = V2Colors.text;
        double mouseWidth = isMobile ? 60.0 : 30.0;
        double mouseHeight = isMobile ? 100.0 : 50.0;
        const double wheelSize = 6.0;
        const double arrowSize = 10.0;
        const double arrowBorderWidth = 2.0;
        return Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.end : MainAxisAlignment.center,

          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: 300.ms,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mouse Outline
                  Container(
                    width: mouseWidth.sp,
                    height: mouseHeight.sp,
                    decoration: BoxDecoration(
                      border: Border.all(color: indicatorColor, width: 2.w),
                      borderRadius: BorderRadius.circular(60.r), // Approx radius
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        // Mouse Wheel
                        child: Container(
                          width: wheelSize.w,
                          height: wheelSize.h,
                          decoration: const BoxDecoration(
                            color: indicatorColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h), // Spacing like var(--spacing-sm)
                  // Arrows
                  SizedBox(
                    width: arrowSize.w * 2, // Container for arrows
                    height: arrowSize.h * 3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(3, (index) {
                        return Positioned(
                          top: (index * arrowSize * 0.6).h, // Stagger arrows vertically
                          child: Animate(
                            onPlay: (controller) => controller.repeat(),
                            delay: (index * 200).ms, // Stagger animation start
                            effects: [
                              // Fade In
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 750.ms, // Half of 1.5s cycle
                                curve: Curves.easeIn,
                              ),
                              // Move Down
                              MoveEffect(
                                begin: Offset(0, -5.h),
                                end: Offset(0, 5.h),
                                duration: 1500.ms,
                                curve: Curves.easeInOut,
                              ),
                              // Fade Out (starts after fade in finishes)
                              FadeEffect(
                                begin: 1.0,
                                end: 0.0,
                                delay: 750.ms,
                                duration: 750.ms,
                                curve: Curves.easeOut,
                              ),
                            ],
                            child: Transform.rotate(
                              angle: 45 * (3.14159 / 180), // Rotate 45 degrees
                              child: Container(
                                width: arrowSize.w,
                                height: arrowSize.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: indicatorColor,
                                      width: arrowBorderWidth.w,
                                    ),
                                    right: BorderSide(
                                      color: indicatorColor,
                                      width: arrowBorderWidth.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            if (isMobile) SizedBox(width: 50.sp),
          ],
        );
      },
    );
  }
}
