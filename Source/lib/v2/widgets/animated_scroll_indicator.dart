import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart';

class AnimatedScrollIndicator extends StatelessWidget {
  const AnimatedScrollIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // Use theme colors
    const Color indicatorColor = AppColors.text;
    const double mouseWidth = 30.0;
    const double mouseHeight = 50.0;
    const double wheelSize = 6.0;
    const double arrowSize = 10.0;
    const double arrowBorderWidth = 2.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mouse Outline
        Container(
          width: mouseWidth.w,
          height: mouseHeight.h,
          decoration: BoxDecoration(
            border: Border.all(color: indicatorColor, width: 2.w),
            borderRadius: BorderRadius.circular(20.r), // Approx radius
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              // Mouse Wheel
              child: Container(
                    width: wheelSize.w,
                    height: wheelSize.h,
                    decoration: const BoxDecoration(color: indicatorColor, shape: BoxShape.circle),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                    delay: 300.ms, // Start slightly after arrows
                  )
                  .moveY(
                    begin: 0,
                    end: (mouseHeight * 0.4).h, // Move down within mouse
                    duration: 1500.ms, // Match CSS scroll animation
                    curve: Curves.easeInOut,
                  )
                  .then(delay: 0.ms) // Immediately reset for repeat
                  .fadeOut(duration: 1.ms) // Vanish instantly at bottom
                  .moveY(begin: (mouseHeight * 0.4).h, end: 0) // Reset position
                  .fadeIn(duration: 1.ms), // Reappear instantly at top
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
                          bottom: BorderSide(color: indicatorColor, width: arrowBorderWidth.w),
                          right: BorderSide(color: indicatorColor, width: arrowBorderWidth.w),
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
    );
  }
}
