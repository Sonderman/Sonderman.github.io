import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/data/personal_datas.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart'; // Import url_launcher

class ActivitySection extends StatelessWidget {
  const ActivitySection({super.key});

  // TODO: Add state management for GitHub data if fetched dynamically (or lift state up)

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
            const SectionHeader(title: 'Activity'),
            SizedBox(height: 40.h), // Spacing like var(--spacing-lg)
            // GitHub Profile Section - Basic UI
            Container(
                  width: double.infinity, // Take full width
                  padding: EdgeInsets.all(24.w),
                  margin: EdgeInsets.only(bottom: 40.h),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
                    boxShadow: [AppTheme.shadowMd],
                  ),
                  child: Row(
                    // Use Row for horizontal layout
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Placeholder Avatar
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(
                          Icons.person_outline, // Placeholder icon
                          size: 40.sp,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      // Profile Info Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Fit content vertically
                          children: [
                            Text(
                              'Sonderman', // GitHub Username
                              style: TextStyle(
                                fontFamily: AppFonts.heading,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Placeholder for Bio/Location if needed later
                            Text(
                              'View profile on GitHub', // Placeholder text
                              style: TextStyle(fontSize: 16.sp, color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      // View Profile Button
                      ElevatedButton.icon(
                        icon: Icon(Icons.link, size: 18.sp),
                        label: const Text('View Profile'),
                        onPressed: () async {
                          final Uri url = Uri.parse('https://github.com/Sonderman');
                          if (!await launchUrl(url)) {
                            // Optional: Show error if URL can't be launched
                            debugPrint('Could not launch $url');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                          textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, duration: 600.ms, curve: Curves.easeOut),

            // GitHub Contributions Section - Using Static Image
            Container(
                  padding: EdgeInsets.all(16.w), // Reduced padding slightly
                  margin: EdgeInsets.only(bottom: 40.h),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
                    boxShadow: [AppTheme.shadowMd],
                  ),
                  // Use ClipRRect to ensure image respects border radius
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppTheme.borderRadiusMd - 4.r,
                    ), // Adjust inner radius
                    child: Center(
                      child: WebViewX(
                        width: 0.8.sw,
                        height: 1.sw * 0.6,
                        initialSourceType: SourceType.html,
                        initialContent: githubAll(isMobile: false),
                        ignoreAllGestures: true, // Corrected indentation and placement
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 100.ms)
                .slideY(begin: 0.2, duration: 600.ms, delay: 100.ms, curve: Curves.easeOut),

            // GitHub Repositories Section - Basic List UI
            Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
                    boxShadow: [AppTheme.shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'Recent Repositories', // Title for the list
                        style: TextStyle(
                          fontFamily: AppFonts.heading,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Placeholder Repository List Items
                      _buildRepoListItem(
                        name: 'MyPortfolio',
                        description: 'Flutter web portfolio showcasing projects and skills.',
                        language: 'Dart',
                        stars: 15, // Placeholder
                      ),
                      Divider(color: AppColors.primaryLight, height: 20.h),
                      _buildRepoListItem(
                        name: 'FlutterGameTemplate',
                        description: 'A template for building games with Flutter.',
                        language: 'Dart',
                        stars: 8, // Placeholder
                      ),
                      Divider(color: AppColors.primaryLight, height: 20.h),
                      _buildRepoListItem(
                        name: 'UnityHelpers',
                        description: 'Collection of helper scripts for Unity development.',
                        language: 'C#',
                        stars: 22, // Placeholder
                      ),
                      // View All Repositories Button
                      SizedBox(height: 20.h), // Add spacing before button
                      Align(
                        alignment: Alignment.center,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('View All Repositories'),
                          onPressed:
                              () =>
                                  _launchUrlHelper('https://github.com/Sonderman?tab=repositories'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.secondary,
                            side: BorderSide(color: AppColors.secondary.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: 0.2, duration: 600.ms, delay: 200.ms, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }

  // Helper function to launch URLs safely (copied from other sections)
  Future<void> _launchUrlHelper(String url) async {
    final Uri? launchUri = Uri.tryParse(url);
    if (launchUri == null) {
      debugPrint('Invalid URL: $url');
      return;
    }
    try {
      bool launched = await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      if (!launched) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
    }
  }

  // Helper widget for a single repository list item
  Widget _buildRepoListItem({
    required String name,
    required String description,
    required String language,
    required int stars,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.book_outlined, color: AppColors.secondary, size: 20.sp), // Repo icon
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Repo Name (Make it clickable)
                InkWell(
                  onTap: () {
                    // Construct GitHub repo URL (assuming username 'Sonderman')
                    final String repoUrl = 'https://github.com/Sonderman/$name';
                    _launchUrlHelper(repoUrl);
                  },
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent1, // Keep link color
                      decoration: TextDecoration.underline, // Add underline
                      decorationColor: AppColors.accent1,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                // Repo Description
                Text(
                  description,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textMuted),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                // Language and Stars
                Row(
                  children: [
                    Icon(Icons.circle, color: _getLanguageColor(language), size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(language, style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted)),
                    SizedBox(width: 16.w),
                    Icon(Icons.star_border, color: AppColors.secondary, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      stars.toString(),
                      style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get a color based on language (simple version)
  // TODO: Expand with more languages or use a package
  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Colors.blue.shade300;
      case 'c#':
        return Colors.green.shade400;
      case 'javascript':
        return Colors.yellow.shade600;
      default:
        return AppColors.textMuted;
    }
  }
}
