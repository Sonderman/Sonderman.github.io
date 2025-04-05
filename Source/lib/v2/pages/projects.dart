import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
// import 'package:myportfolio/v2/widgets/nav_menu.dart'; // No longer needed here
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false; // For NavMenu sticky state

  // TODO: Add state for filters, sorting, project data, load more

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // TODO: Load initial project data
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
      backgroundColor: AppColors.primary, // Match original section background
      // This page is now effectively unused, the content is in ProjectsSection
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
              const SectionHeader(title: 'Projects'),
              SizedBox(height: 40.h), // Spacing like var(--spacing-lg)
              // Filter Buttons - Placeholder
              // TODO: Implement filter buttons and logic
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                color: AppColors.primaryLight.withOpacity(0.3),
                child: const Center(child: Text('Filter Buttons Placeholder')),
              ),
              SizedBox(height: 30.h), // Spacing like var(--spacing-md)
              // Sort Controls - Placeholder
              // TODO: Implement sort controls and logic
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                color: AppColors.primaryLight.withOpacity(0.3),
                child: const Center(child: Text('Sort Controls Placeholder')),
              ),
              SizedBox(height: 30.h), // Spacing like var(--spacing-md)
              // Projects Grid - Placeholder
              // TODO: Implement project grid (e.g., GridView.builder)
              Container(
                height: 400.h, // Placeholder height
                color: AppColors.primaryLight.withOpacity(0.5),
                child: const Center(child: Text('Projects Grid Placeholder')),
              ),
              SizedBox(height: 40.h), // Spacing like var(--spacing-lg)
              // Load More Button - Placeholder
              // TODO: Implement Load More button and logic
              ElevatedButton(
                onPressed: () {
                  /* TODO */
                },
                child: const Text('Load More Projects'),
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
