import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart';
import 'package:myportfolio/v2/widgets/section_header.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myportfolio/v2/data/personal_datas.dart'; // Import personal data

// Define a constant for the responsive breakpoint
const double _kDesktopBreakpoint = 768.0; // Adjusted breakpoint for better tablet handling

/// Represents the main section displaying the resume (Education & Experience).
///
/// This section adapts its layout based on screen size:
/// - Mobile (< 768dp): Single column layout.
/// - Desktop/Tablet (>= 768dp): Two-column layout.
/// It fetches data from `personal_datas.dart`.
class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  // NOTE: Static data has been moved to lib/v2/data/personal_datas.dart

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use primaryLight color for the section background
      color: V2Colors.primaryLight,
      child: Padding(
        // Apply responsive horizontal padding and fixed vertical padding
        padding: EdgeInsets.symmetric(
          horizontal:
              ScreenUtil().screenWidth > _kDesktopBreakpoint
                  ? 60.w
                  : V2Theme.spacingMd.w, // Less padding on mobile
          vertical: V2Theme.spacingXl.h, // Use theme constant for vertical padding
        ),
        child: Column(
          children: [
            // Section Header
            const SectionHeader(title: 'Resume'),
            SizedBox(height: V2Theme.spacingLg.h), // Use theme constant for spacing
            // Responsive Layout for Timelines
            LayoutBuilder(
              builder: (context, constraints) {
                // Check if the screen width is greater than the breakpoint
                if (constraints.maxWidth >= _kDesktopBreakpoint) {
                  // Desktop/Tablet Layout: Two columns
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Education Timeline (Left Column)
                      Expanded(
                        child: TimelineSection(
                          icon: Icons.school_outlined, // Education icon
                          title: 'Education',
                          // Use data from personal_datas.dart
                          items: educationHistory,
                        ),
                      ),
                      // Spacing between columns
                      SizedBox(width: V2Theme.spacingLg.w),
                      // Experience Timeline (Right Column)
                      Expanded(
                        child: TimelineSection(
                          icon: Icons.work_outline, // Experience icon
                          title: 'Experiences',
                          // Use data from personal_datas.dart
                          items: experienceHistory,
                        ),
                      ),
                    ],
                  );
                } else {
                  // Mobile Layout: Single column
                  return Column(
                    children: [
                      // Education Timeline
                      TimelineSection(
                        icon: Icons.school_outlined,
                        title: 'Education',
                        // Use data from personal_datas.dart
                        items: educationHistory,
                      ),
                      // Spacing between timeline sections on mobile
                      SizedBox(height: V2Theme.spacingLg.h),
                      // Experience Timeline
                      TimelineSection(
                        icon: Icons.work_outline,
                        title: 'Experiences',
                        // Use data from personal_datas.dart
                        items: experienceHistory,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget representing a single timeline section (e.g., Education, Experience).
///
/// Displays a title with an icon, followed by a vertical timeline of [ResumeItem]s.
class TimelineSection extends StatelessWidget {
  final IconData icon;
  final String title;
  // Updated to use List<ResumeItem>
  final List<ResumeItem> items;

  const TimelineSection({required this.icon, required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Header (Icon + Title)
        Row(
          children: [
            // Circular Icon Background
            Container(
              width: 150.sp, // Fixed width
              height: 150.sp, // Fixed height
              decoration: const BoxDecoration(
                color: V2Colors.secondary, // Use secondary color for background
                shape: BoxShape.circle, // Circular shape
              ),
              child: Icon(
                icon,
                color: V2Colors.primary, // Use primary color for icon
                size: 130.sp, // Scaled icon size
              ),
            ),
            SizedBox(width: V2Theme.spacingSm.w), // Use theme constant for spacing
            // Timeline Title Text
            AutoSizeText(
              title,
              style: TextStyle(
                fontFamily: V2Fonts.heading, // Use heading font
                fontSize: 28.sp, // Scaled font size
                fontWeight: FontWeight.w600, // Bold weight
                color: V2Colors.text, // Use standard text color
              ),
              minFontSize: 18, // Minimum font size to prevent text becoming too small
              maxLines: 1,
            ),
          ],
        ),
        SizedBox(height: V2Theme.spacingMd.h), // Use theme constant for spacing below header
        // Timeline Implementation using Stack
        Stack(
          children: [
            // Vertical Timeline Line
            Positioned(
              // Position the line in the center relative to the dot/icon area
              left: 25.w - 1.w, // (Icon width / 2) - (Line width / 2)
              top: 8.h, // Start line slightly below the top of the first dot
              bottom: 8.h, // End line slightly above the bottom of the last dot
              child: Container(
                width: 2.w, // Line width
                color: V2Colors.secondary.withOpacity(0.3), // Lighter, less prominent line color
              ),
            ),

            // Timeline Items Column
            Padding(
              // Add left padding to align content next to the line/dots
              padding: EdgeInsets.only(left: 50.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(items.length, (index) {
                  // Get the ResumeItem object
                  final ResumeItem item = items[index];
                  final bool isLast = index == items.length - 1;

                  // Build each timeline item card using the ResumeItem
                  return Padding(
                    // Add bottom padding between items, except for the last one
                    padding: EdgeInsets.only(bottom: isLast ? 0 : V2Theme.spacingMd.h),
                    child: TimelineItemCard(
                      item: item, // Pass the ResumeItem object
                      itemIndex: index, // Pass index for animation staggering
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// A widget representing a single card within the timeline.
///
/// Displays the date, title, subtitle (optional), and details (optional)
/// for a [ResumeItem], along with an animated dot on the timeline.
class TimelineItemCard extends StatelessWidget {
  // Updated to accept a ResumeItem object
  final ResumeItem item;
  final int itemIndex; // Used for staggering animations

  const TimelineItemCard({required this.item, required this.itemIndex, super.key});

  @override
  Widget build(BuildContext context) {
    // Extract data directly from the item object properties
    final String date = item.date;
    final String title = item.title;
    final String? subtitle = item.subtitle;
    final List<String>? details = item.details;

    return Stack(
      clipBehavior: Clip.none, // Allow the dot to be positioned outside the card bounds
      children: [
        // Pulsing Timeline Dot
        Positioned(
          // Position dot to the left of the card, aligned with the timeline line
          left: -50.w - 8.w, // (Left Padding of Column) - (Dot Radius)
          top: 0, // Align dot vertically with the top of the card content
          child: Container(
                width: 16.w, // Dot width
                height: 16.h, // Dot height
                decoration: const BoxDecoration(
                  color: V2Colors.secondary, // Use secondary color for the dot
                  shape: BoxShape.circle, // Circular shape
                ),
              )
              // Apply the pulsing animation (kept as per user request)
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scaleXY(
                delay: (200 * itemIndex).ms, // Stagger animation start based on index
                duration: 1000.ms, // Animation duration
                begin: 0.8, // Scale down
                end: 1.2, // Scale up
                curve: Curves.easeInOut, // Smooth easing
              ),
        ),

        // Timeline Content Card
        Container(
              // Apply standard padding using theme constant
              padding: EdgeInsets.all(V2Theme.spacingMd.w),
              decoration: BoxDecoration(
                color: V2Colors.card, // Use card background color
                // Apply standard border radius using theme constant
                borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
                // Apply standard medium shadow using theme constant
                boxShadow: const [V2Theme.shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Badge
                  Container(
                    // Apply responsive padding using theme constants
                    padding: EdgeInsets.symmetric(
                      horizontal: V2Theme.spacingSm.w,
                      vertical: V2Theme.spacingXs.h,
                    ),
                    decoration: BoxDecoration(
                      color: V2Colors.secondary, // Use secondary color for badge background
                      // Apply small border radius using theme constant
                      borderRadius: BorderRadius.circular(V2Theme.borderRadiusSm),
                    ),
                    child: AutoSizeText(
                      date, // Use item.date
                      style: TextStyle(
                        fontFamily: V2Fonts.body, // Use body font for badge
                        fontSize: 14.sp, // Scaled font size
                        fontWeight: FontWeight.w600, // Bold weight
                        color:
                            V2Colors.primary, // Use primary color for text on secondary background
                      ),
                      minFontSize: 10, // Minimum font size
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: V2Theme.spacingSm.h), // Use theme constant for spacing
                  // Title
                  AutoSizeText(
                    title, // Use item.title
                    style: TextStyle(
                      fontFamily: V2Fonts.heading, // Use heading font
                      fontSize: 18.sp, // Scaled font size
                      fontWeight: FontWeight.w600, // Bold weight
                      color: V2Colors.text, // Use standard text color
                    ),
                    minFontSize: 14, // Minimum font size
                    maxLines: 2, // Allow up to two lines for title
                  ),

                  // Subtitle (Optional)
                  if (subtitle != null && subtitle.isNotEmpty) ...[
                    SizedBox(height: V2Theme.spacingXs.h), // Smaller spacing for subtitle
                    AutoSizeText(
                      subtitle, // Use item.subtitle
                      style: TextStyle(
                        fontFamily: V2Fonts.body, // Use body font
                        fontSize: 16.sp, // Scaled font size
                        color: V2Colors.accent1, // Use accent color for subtitle
                        fontWeight: FontWeight.w500, // Medium weight
                      ),
                      minFontSize: 12, // Minimum font size
                      maxLines: 2, // Allow up to two lines
                    ),
                  ],

                  // Details (Optional List)
                  if (details != null && details.isNotEmpty) ...[
                    SizedBox(height: V2Theme.spacingSm.h), // Use theme constant for spacing
                    // Map each detail string to a text widget
                    ...details.map(
                      (detail) => Padding(
                        // Add small bottom padding between detail items
                        padding: EdgeInsets.only(bottom: V2Theme.spacingXs.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bullet point for details (if more than one, or if it doesn't already start like a list)
                            if (details.length > 1 || !detail.trim().startsWith('•'))
                              Padding(
                                padding: EdgeInsets.only(
                                  right: V2Theme.spacingSm.w / 2,
                                  top: 2.h,
                                ), // Adjust spacing for bullet
                                child: Text(
                                  '•',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: V2Colors.textMuted, // Muted color for bullet
                                  ),
                                ),
                              ),
                            // Detail Text (Expanded to wrap)
                            Expanded(
                              child: AutoSizeText(
                                // Remove leading bullet if we added one
                                (details.length > 1 || !detail.trim().startsWith('•'))
                                    ? detail
                                    : detail.trim().substring(1).trim(),
                                style: TextStyle(
                                  fontFamily: V2Fonts.body, // Use body font
                                  fontSize: 15.sp, // Scaled font size
                                  color: V2Colors.textMuted, // Use muted text color
                                  height: 1.5, // Line height for readability
                                ),
                                minFontSize: 12, // Minimum font size
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            )
            // Apply scroll-triggered animation to the content card
            .animate()
            .fadeIn(duration: 600.ms, delay: (100 * itemIndex).ms) // Fade in effect
            .slideY(
              // Slide in from bottom effect
              begin: 0.2,
              duration: 600.ms,
              delay: (100 * itemIndex).ms,
              curve: Curves.easeOut,
            ),
      ],
    );
  }
}
