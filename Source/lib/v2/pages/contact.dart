import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
// import 'package:myportfolio/v2/widgets/nav_menu.dart'; // No longer needed here
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false; // For NavMenu sticky state

  // TODO: Add state for form fields and validation

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    // TODO: Dispose form controllers
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
      // This page is now effectively unused, the content is in ContactSection
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
              const SectionHeader(title: 'Contact Me'),
              SizedBox(height: 50.h), // Spacing like var(--spacing-lg)
              // Contact Content (Info + Form)
              // TODO: Implement responsive layout (Row/Column)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side (Contact Info) - Placeholder
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 400.h, // Placeholder height
                      color: AppColors.primaryLight.withOpacity(0.3),
                      child: const Center(child: Text('Contact Info Placeholder')),
                    ),
                  ),
                  SizedBox(width: 50.w), // Spacing like var(--spacing-lg)
                  // Right Side (Contact Form) - Placeholder
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(40.w), // Spacing like var(--spacing-lg)
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
                      height: 500.h, // Placeholder height
                      child: const Center(child: Text('Contact Form Placeholder')),
                    ),
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
}
