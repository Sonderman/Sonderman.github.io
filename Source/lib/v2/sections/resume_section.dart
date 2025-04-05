import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLight, // Match original section background
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 60.w,
          vertical: 80.h,
        ), // Increased vertical padding
        child: Column(
          children: [
            // Section Header
            const SectionHeader(title: 'Resume'),
            SizedBox(height: 50.h), // Spacing like var(--spacing-lg)
            // Resume Content (Timelines)
            // TODO: Implement responsive layout (Row/Column or just Column)
            Column(
              // Using Column for now, original was flex column
              children: [
                // Education Timeline - Placeholder
                _buildTimelineSection(
                  icon: Icons.school_outlined, // Placeholder for graduation-cap
                  title: 'Education',
                  items: [
                    // Actual data from v1
                    {
                      'date': '2015 - 2020',
                      'title': 'Bachelor of Computer Engineering',
                      'subtitle': 'Karabuk University, Karabuk/Turkey',
                      'details': null, // No specific details listed in v1 for education
                    },
                  ],
                ),
                SizedBox(height: 60.h), // Spacing like var(--spacing-xl)
                // Experience Timeline - Placeholder
                _buildTimelineSection(
                  icon: Icons.work_outline, // Placeholder for briefcase
                  title: 'Experiences',
                  items: [
                    // Actual data from v1
                    {
                      'date': 'Apr 2024 - Present',
                      'title':
                          'Flutter & Unity Game Developer | Freelancer', // Combined title/subtitle from v1
                      'subtitle': null, // Explicitly null as subtitle wasn't separate in v1 item
                      'details': ['Have published 80+ apps on mobile platforms.'],
                    },
                    {
                      'date': 'Mar 2023 - Mar 2024',
                      'title': 'Game Developer',
                      'subtitle': null, // No subtitle in v1 item
                      'details': [
                        'I took part in the development process of 2 mobile games:',
                        'Sky Wars Online: Istanbul', // Kept as separate list items for clarity
                        'Zombie Rush Drive',
                      ],
                    },
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Placeholder Widget for a Timeline Section (Education/Experience)
  // TODO: Consider making this a separate reusable widget
  Widget _buildTimelineSection({
    required IconData icon,
    required String title,
    required List<Map<String, dynamic>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Header
        Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
              child: Icon(icon, color: AppColors.primary, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.heading,
                fontSize: 28.sp, // Approx 1.8rem
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        // Timeline Implementation using Stack
        Stack(
          children: [
            // Vertical Line
            Positioned(
              left: 25.w - 1.w, // Center the line (Icon width / 2 - Line width / 2)
              top: 0,
              bottom: 0,
              child: Container(
                width: 2.w, // Line width
                color: AppColors.secondary.withOpacity(0.5), // Line color
              ),
            ),
            // Timeline Items
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final bool isLast = index == items.length - 1;

                return Padding(
                  // Add padding to the left to make space for the line and dot
                  padding: EdgeInsets.only(left: 50.w, bottom: isLast ? 0 : 30.h),
                  child: Stack(
                    clipBehavior: Clip.none, // Allow dot to overflow
                    children: [
                      // Timeline Dot
                      Positioned(
                        left:
                            -50.w - 8.w, // Position left relative to padding (Padding - Dot Radius)
                        top: 0, // Align dot with the top of the content card
                        child: Container(
                              width: 16.w,
                              height: 16.h,
                              decoration: const BoxDecoration(
                                color: AppColors.secondary,
                                shape: BoxShape.circle,
                              ),
                            )
                            // Add pulse animation to the dot
                            .animate(onPlay: (controller) => controller.repeat(reverse: true))
                            .scaleXY(
                              delay: (200 * index).ms, // Stagger pulse start slightly
                              duration: 1000.ms,
                              begin: 0.8,
                              end: 1.2,
                              curve: Curves.easeInOut,
                            ),
                      ),
                      // Timeline Content Card
                      Container(
                            padding: EdgeInsets.all(24.w),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date Badge
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    item['date'],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                // Title
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                    fontFamily: AppFonts.heading,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text,
                                  ),
                                ),
                                // Subtitle (Optional)
                                if (item['subtitle'] != null) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    item['subtitle'],
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.accent1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                                // Details (Optional List)
                                if (item['details'] != null &&
                                    (item['details'] as List).isNotEmpty) ...[
                                  SizedBox(height: 12.h),
                                  ...(item['details'] as List<String>)
                                      .map(
                                        (detail) => Padding(
                                          padding: EdgeInsets.only(bottom: 4.h),
                                          child: Text(
                                            (item['details'].length > 1 &&
                                                    detail !=
                                                        (item['details'] as List<String>)
                                                            .firstWhere(
                                                              (d) => d.isNotEmpty,
                                                              orElse: () => '',
                                                            ))
                                                ? '• $detail'
                                                : detail,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: AppColors.textMuted,
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ],
                              ],
                            ),
                          )
                          // Add scroll-triggered animation to the content card
                          .animate()
                          .fadeIn(duration: 600.ms, delay: (100 * index).ms)
                          .slideY(
                            begin: 0.2,
                            duration: 600.ms,
                            delay: (100 * index).ms,
                            curve: Curves.easeOut,
                          ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
