import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Mimic CSS .section-header structure
    return Column(
      children: [
        // Mimic CSS .section-title
        AutoSizeText(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: V2Fonts.heading,
            // Responsive font size
            fontSize:
                ScreenUtil().screenWidth < 600
                    ? 40
                        .sp // Mobile size
                    : ScreenUtil().screenWidth < 1200
                    ? 48
                        .sp // Tablet size
                    : 60.sp, // Desktop size
            fontWeight: FontWeight.w700,
            color: V2Colors.text,
          ),
          minFontSize: 10, // Added minFontSize
          // TODO: Add character reveal animation later
        ), // Removed extra parenthesis from line 27 and 29
        SizedBox(height: 16.h), // Spacing like var(--spacing-sm)
        // Mimic CSS .section-divider
        // Using Stack to overlay the accent lines on the main divider
        Stack(
          alignment: Alignment.center,
          children: [
            // Main Divider (Secondary Color)
            Container(width: 80.w, height: 4.h, color: V2Colors.secondary),
            // Left Accent Line (Accent 1) - Positioned relative to center
            Positioned(
              left: -20.w - 40.w / 2, // (divider width / 2) + accent offset + (accent width / 2)
              child: Container(width: 40.w, height: 4.h, color: V2Colors.accent1),
            ),
            // Right Accent Line (Accent 2) - Positioned relative to center
            Positioned(
              right: -20.w - 40.w / 2, // (divider width / 2) + accent offset + (accent width / 2)
              child: Container(width: 40.w, height: 4.h, color: V2Colors.accent2),
            ),
          ],
        ),
      ],
    );
  }
}
