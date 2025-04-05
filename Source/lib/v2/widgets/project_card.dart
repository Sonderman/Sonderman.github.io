import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart'; // Correct single import for AppTheme
import '../models/project.dart'; // Import the Project model
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

// Removed duplicate Project class definition

class ProjectCard extends StatefulWidget {
  final Project project; // Use the imported Project model

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  // Helper to get platform icon
  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'mobile':
        return Icons.phone_android; // Or Icons.mobile_friendly
      case 'web':
        return Icons.web;
      // Add more cases as needed
      default:
        return Icons.device_unknown;
    }
  }

  // Helper to get link icon
  IconData _getLinkIcon(String linkType) {
    switch (linkType.toLowerCase()) {
      case 'playstore':
        return Icons.shop; // Placeholder, consider FontAwesome or custom icon
      case 'appstore':
        return Icons.apple; // Placeholder
      case 'github':
        return Icons.code; // Placeholder
      // Add more cases as needed
      default:
        return Icons.link;
    }
  }

  // Helper for launching URLs
  Future<void> _launchUrlHelper(String url) async {
    final Uri? launchUri = Uri.tryParse(url);
    if (launchUri == null || url == '#') {
      // Also check for placeholder '#'
      debugPrint('Invalid or placeholder URL: $url');
      // Optionally show a message to the user
      return;
    }
    try {
      // Use launchMode external application for web links if needed
      // bool launched = await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      bool launched = await launchUrl(launchUri); // Default mode
      if (!launched) {
        debugPrint('Could not launch $url');
        // Optionally show a snackbar or message to the user
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
      // Optionally show a snackbar or message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click, // Indicate interactivity
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
          boxShadow: _isHovered ? [AppTheme.shadowLg] : [AppTheme.shadowMd],
        ),
        clipBehavior: Clip.antiAlias, // Clip the image overflow
        child: Stack(
          // Use Stack for the date overlay
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image with Hover Effect
                SizedBox(
                  height: 200.h, // Match original CSS height
                  width: double.infinity,
                  child: ClipRRect(
                    // Ensure image respects border radius
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppTheme.borderRadiusMd),
                    ),
                    child: AnimatedScale(
                      scale: _isHovered ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: Image.asset(
                        widget.project.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => const Center(
                              child: Icon(Icons.image_not_supported),
                            ), // Placeholder on error
                      ),
                    ),
                  ),
                ),
                // Project Info
                Padding(
                  padding: EdgeInsets.all(AppTheme.spacingMd.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        style: TextStyle(
                          fontSize: 18.sp, // Adjusted size
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),
                      Row(
                        // Combine platforms and links
                        children: [
                          // Platform Icons
                          ...widget.project.platforms.map(
                            (platform) => Padding(
                              padding: EdgeInsets.only(right: AppTheme.spacingXs.w),
                              child: Icon(
                                _getPlatformIcon(platform),
                                color: AppColors.textMuted,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const Spacer(), // Push links to the right
                          // Link Icons
                          ...widget.project.links.entries.map(
                            (entry) => Padding(
                              padding: EdgeInsets.only(left: AppTheme.spacingXs.w),
                              child: InkWell(
                                onTap: () => _launchUrlHelper(entry.value), // Call helper
                                borderRadius: BorderRadius.circular(20.r),
                                child: Container(
                                  width: 35.w, // Slightly smaller than original for balance
                                  height: 35.h,
                                  decoration: const BoxDecoration(
                                    // Can be const
                                    color: AppColors.primaryLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _getLinkIcon(entry.key),
                                    color: AppColors.text,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Date Overlay
            Positioned(
              top: AppTheme.spacingSm.h,
              right: AppTheme.spacingSm.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
                ),
                child: Text(
                  widget.project.date, // Display formatted date
                  style: TextStyle(
                    fontSize: 12.sp, // Smaller date font
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
