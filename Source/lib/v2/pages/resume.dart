import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
// import 'package:myportfolio/v2/widgets/nav_menu.dart'; // No longer needed here
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false; // For NavMenu sticky state

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final isScrolled = _scrollController.hasClients && _scrollController.offset > 50;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implement MobileNavOverlay integration
    return Scaffold(
      backgroundColor: AppColors.primaryLight, // Match original section background
      // This page is now effectively unused, the content is in ResumeSection
      // Removing the NavMenu call to resolve the error.
      body: SingleChildScrollView(
        // Removed Column and NavMenu
        // children: [
        // NavMenu(isScrolled: _isScrolled), // REMOVED
        // Expanded( // Removed Expanded
        // child: SingleChildScrollView( // Kept SingleChildScrollView for structure
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 50.h),
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
                      // Placeholder item
                      {
                        'date': '2015 - 2020',
                        'title': 'Bachelor of Computer Engineering',
                        'subtitle': 'Karabuk University, Karabuk/Turkey',
                        'details': null,
                      },
                    ],
                  ),
                  SizedBox(height: 60.h), // Spacing like var(--spacing-xl)
                  // Experience Timeline - Placeholder
                  _buildTimelineSection(
                    icon: Icons.work_outline, // Placeholder for briefcase
                    title: 'Experiences',
                    items: [
                      // Placeholder items
                      {
                        'date': 'Apr 2024 - Present',
                        'title': 'Flutter & Unity Game Developer',
                        'subtitle': 'Freelancer',
                        'details': ['Have published 80+ apps on mobile platforms.'],
                      },
                      {
                        'date': 'Mar 2023 - Mar 2024',
                        'title': 'Game Developer',
                        'subtitle': null,
                        'details': [
                          'I took part in the development process of 2 mobile games:',
                          'Sky Wars Online: Istanbul',
                          'Zombie Rush Drive',
                        ],
                      },
                    ],
                  ),
                ],
              ),

              // TODO: Add Footer Placeholder if needed
              SizedBox(height: 50.h), // Add some bottom padding
            ],
          ),
        ),
        // ), // Removed Expanded closing
        // ], // Removed Column closing
      ), // Close SingleChildScrollView
    );
  }

  // Placeholder Widget for a Timeline Section (Education/Experience)
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
        SizedBox(height: 30.h), // Spacing like var(--spacing-md)
        // Timeline Items - Placeholder Structure
        // TODO: Implement actual vertical line and dot structure
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              items
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 30.h), // Spacing like var(--spacing-lg)
                      child: Container(
                        padding: EdgeInsets.all(24.w), // Spacing like var(--spacing-md)
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(8.r), // --border-radius-md
                          boxShadow: [
                            // Approximate --shadow-md
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
                                borderRadius: BorderRadius.circular(4.r), // --border-radius-sm
                              ),
                              child: Text(
                                item['date'],
                                style: TextStyle(
                                  fontSize: 14.sp, // Approx 0.9rem
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
                                fontSize: 18.sp, // Approx 1.2rem
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
                                  fontSize: 16.sp, // 1rem
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
                                        (item['details'].length > 1 && detail != item['details'][0])
                                            ? '• $detail'
                                            : detail, // Add bullet for list items after first
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
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
