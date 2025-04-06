import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import AutoSizeText
import 'package:myportfolio/v2/data/personal_datas.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart'; // Import theme
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
      color: V2Colors.primaryLight, // Match original section background
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
                    color: V2Colors.card,
                    borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
                    boxShadow: [V2Theme.shadowMd],
                  ),
                  child: Row(
                    // Use Row for horizontal layout
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Placeholder Avatar
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: V2Colors.primaryLight,
                        child: Icon(
                          Icons.person_outline, // Placeholder icon
                          size: 40.sp,
                          color: V2Colors.secondary,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      // Profile Info Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Fit content vertically
                          children: [
                            AutoSizeText(
                              'Sonderman', // GitHub Username
                              style: TextStyle(
                                fontFamily: V2Fonts.heading,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: V2Colors.text,
                              ),
                              minFontSize: 10, // Added minFontSize
                            ),
                            SizedBox(height: 8.h),
                            // Placeholder for Bio/Location if needed later
                            AutoSizeText(
                              'View profile on GitHub', // Placeholder text
                              style: TextStyle(fontSize: 16.sp, color: V2Colors.textMuted),
                              minFontSize: 10, // Added minFontSize
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      // View Profile Button
                      ElevatedButton.icon(
                        icon: Icon(Icons.link, size: 18.sp),
                        label: const AutoSizeText(
                          'View Profile',
                          minFontSize: 10,
                        ), // Added minFontSize
                        onPressed: () async {
                          final Uri url = Uri.parse('https://github.com/Sonderman');
                          if (!await launchUrl(url)) {
                            // Optional: Show error if URL can't be launched
                            debugPrint('Could not launch $url');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: V2Colors.secondary,
                          foregroundColor: V2Colors.primary,
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
                    color: V2Colors.card,
                    borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
                    boxShadow: [V2Theme.shadowMd],
                  ),
                  // Use ClipRRect to ensure image respects border radius
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      V2Theme.borderRadiusMd - 4.r,
                    ), // Adjust inner radius
                    child: Center(
                      // Using LayoutBuilder ensures dimensions are calculated during layout phase
                      // before WebViewX attempts to render. This prevents "never laid out" errors.
                      // The 4:3 aspect ratio (width * 0.75) provides consistent sizing.
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth * 0.8;
                          final height = width * 0.75;
                          return SizedBox(
                            width: width,
                            height: height,
                            child: WebViewX(
                              width: width,
                              height: height,
                              initialSourceType: SourceType.html,
                              initialContent: githubAll(isMobile: false),
                              ignoreAllGestures: true,
                            ),
                          );
                        },
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
                    color: V2Colors.card,
                    borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
                    boxShadow: [V2Theme.shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      AutoSizeText(
                        'Recent Repositories', // Title for the list
                        style: TextStyle(
                          fontFamily: V2Fonts.heading,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: V2Colors.text,
                        ),
                        minFontSize: 10, // Added minFontSize
                      ),
                      SizedBox(height: 20.h),
                      // Placeholder Repository List Items
                      _buildRepoListItem(
                        name: 'MyPortfolio',
                        description: 'Flutter web portfolio showcasing projects and skills.',
                        language: 'Dart',
                        stars: 15, // Placeholder
                      ),
                      Divider(color: V2Colors.primaryLight, height: 20.h),
                      _buildRepoListItem(
                        name: 'FlutterGameTemplate',
                        description: 'A template for building games with Flutter.',
                        language: 'Dart',
                        stars: 8, // Placeholder
                      ),
                      Divider(color: V2Colors.primaryLight, height: 20.h),
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
                          label: const AutoSizeText(
                            'View All Repositories',
                            minFontSize: 10,
                          ), // Added minFontSize
                          onPressed:
                              () =>
                                  _launchUrlHelper('https://github.com/Sonderman?tab=repositories'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: V2Colors.secondary,
                            side: BorderSide(color: V2Colors.secondary.withOpacity(0.5)),
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
          Icon(Icons.book_outlined, color: V2Colors.secondary, size: 20.sp), // Repo icon
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
                  child: AutoSizeText(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: V2Colors.accent1, // Keep link color
                      decoration: TextDecoration.underline, // Add underline
                      decorationColor: V2Colors.accent1,
                    ),
                    minFontSize: 10, // Added minFontSize
                  ), // Closing parenthesis for AutoSizeText
                ), // Closing parenthesis for InkWell
                SizedBox(height: 4.h),
                // Repo Description
                AutoSizeText(
                  description,
                  style: TextStyle(fontSize: 14.sp, color: V2Colors.textMuted),
                  minFontSize: 10, // Added minFontSize
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                // Language and Stars
                Row(
                  children: [
                    Icon(Icons.circle, color: _getLanguageColor(language), size: 12.sp),
                    SizedBox(width: 4.w),
                    AutoSizeText(
                      language,
                      style: TextStyle(fontSize: 12.sp, color: V2Colors.textMuted),
                      minFontSize: 10,
                    ), // Added minFontSize
                    SizedBox(width: 16.w),
                    Icon(Icons.star_border, color: V2Colors.secondary, size: 14.sp),
                    SizedBox(width: 4.w),
                    AutoSizeText(
                      stars.toString(),
                      style: TextStyle(fontSize: 12.sp, color: V2Colors.textMuted),
                      minFontSize: 10, // Added minFontSize
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
        return V2Colors.textMuted;
    }
  }
}
