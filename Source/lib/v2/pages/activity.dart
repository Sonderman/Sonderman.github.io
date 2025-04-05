import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
// import 'package:myportfolio/v2/widgets/nav_menu.dart'; // No longer needed here
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false; // For NavMenu sticky state

  // TODO: Add state for GitHub data if fetched dynamically

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // TODO: Fetch GitHub data if needed
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
      // This page is now effectively unused, the content is in ActivitySection
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
              const SectionHeader(title: 'Activity'),
              SizedBox(height: 40.h), // Spacing like var(--spacing-lg)
              // GitHub Profile Section - Placeholder
              // TODO: Implement GitHub profile card
              Container(
                padding: EdgeInsets.all(24.w),
                margin: EdgeInsets.only(bottom: 40.h), // Spacing like var(--spacing-lg)
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    // Approximate --shadow-md
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                height: 200.h, // Placeholder height
                child: const Center(child: Text('GitHub Profile Placeholder')),
              ),

              // GitHub Contributions Section - Placeholder
              // TODO: Implement Contributions graph (image or custom painter)
              Container(
                padding: EdgeInsets.all(24.w),
                margin: EdgeInsets.only(bottom: 40.h), // Spacing like var(--spacing-lg)
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    // Approximate --shadow-md
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                height: 200.h, // Placeholder height
                child: const Center(child: Text('GitHub Contributions Placeholder')),
              ),

              // GitHub Repositories Section - Placeholder
              // TODO: Implement Repositories list/grid
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    // Approximate --shadow-md
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                height: 300.h, // Placeholder height
                child: const Center(child: Text('GitHub Repositories Placeholder')),
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
}
