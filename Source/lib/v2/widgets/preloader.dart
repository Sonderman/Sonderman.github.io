import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme

class Preloader extends StatefulWidget {
  final VoidCallback onLoadingComplete; // Callback when fade-out finishes

  const Preloader({super.key, required this.onLoadingComplete});

  @override
  State<Preloader> createState() => _PreloaderState();
}

class _PreloaderState extends State<Preloader> with SingleTickerProviderStateMixin {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    // Start fade out after 1.5 seconds (like original JS)
    Future.delayed(1500.ms, () {
      if (mounted) {
        setState(() => _visible = false);
        // Trigger callback after fade out animation (500ms)
        Future.delayed(500.ms, () {
          if (mounted) {
            widget.onLoadingComplete();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use IgnorePointer to prevent interaction when faded out but still present
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: 500.ms, // Original fade-out duration
        child: Container(
          color: AppColors.primary, // Use theme color
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder for SVG Logo Animation - Using a simple pulsing circle for now
                // TODO: Replace with actual SVG animation if possible
                Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondary, width: 4.w),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scaleXY(
                      end: 1.1,
                      duration: 1.seconds,
                      curve: Curves.easeInOut,
                    ) // Corrected: .seconds
                    .then()
                    .scaleXY(
                      end: 1.0,
                      duration: 1.seconds,
                      curve: Curves.easeInOut,
                    ), // Corrected: .seconds

                SizedBox(height: 30.h), // Spacing like var(--spacing-md)
                // Loading Text with animated dots (similar to original CSS)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Loading',
                      style: TextStyle(
                        fontFamily: AppFonts.heading,
                        fontSize: 18.sp, // Approx 1.2rem
                        color: AppColors.text,
                        letterSpacing: 2,
                      ),
                    ),
                    // Dot 1
                    Text('.', style: TextStyle(fontSize: 18.sp, color: AppColors.text))
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(delay: 0.ms, duration: 500.ms) // Fade in
                        .then(delay: 500.ms) // Stay visible
                        .fadeOut(duration: 500.ms), // Fade out (Total cycle 1.5s)
                    // Dot 2
                    Text('.', style: TextStyle(fontSize: 18.sp, color: AppColors.text))
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(delay: 500.ms, duration: 500.ms) // Start later
                        .then(delay: 500.ms)
                        .fadeOut(duration: 500.ms),
                    // Dot 3
                    Text('.', style: TextStyle(fontSize: 18.sp, color: AppColors.text))
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(delay: 1000.ms, duration: 500.ms) // Start even later
                        .then(delay: 500.ms)
                        .fadeOut(duration: 500.ms),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
