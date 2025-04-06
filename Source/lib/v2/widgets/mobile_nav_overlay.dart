import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import AutoSizeText
import 'package:myportfolio/v2/theme/v2_theme.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome

class MobileNavOverlay extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClose;
  final ScrollController scrollController;
  final GlobalKey aboutKey;
  final GlobalKey resumeKey;
  final GlobalKey projectsKey;
  final GlobalKey activityKey;
  final GlobalKey contactKey;

  const MobileNavOverlay({
    super.key,
    required this.isVisible,
    required this.onClose,
    required this.scrollController,
    required this.aboutKey,
    required this.resumeKey,
    required this.projectsKey,
    required this.activityKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Use 80% width like original CSS, or a max width
    final overlayWidth = (screenWidth * 0.8).clamp(0.0, 400.w);

    return AnimatedPositioned(
      duration: 500.ms, // Match original CSS transition
      curve: Curves.ease,
      top: 0,
      bottom: 0,
      right: isVisible ? 0 : -overlayWidth, // Slide in/out
      width: overlayWidth,
      child: Material(
        color: V2Colors.primary,
        elevation: 16,
        child: Stack(
          children: [
            // Close button at top right
            Positioned(
              top: 40.h,
              right: 32.w,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  child: Icon(
                    Icons.close,
                    color: V2Colors.text,
                    size: 100.sp, // Matches nav menu icon size
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.only(top: 100.h, left: 32.w, right: 32.w, bottom: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Navigation Links
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: 60.h), // Space for close button
                      children: [
                        _buildNavLink('About', 'about'),
                        SizedBox(height: 24.h),
                        _buildNavLink('Resume', 'resume'),
                        SizedBox(height: 24.h),
                        _buildNavLink('Projects', 'projects'),
                        SizedBox(height: 24.h),
                        _buildNavLink('Activity', 'activity'),
                        SizedBox(height: 24.h),
                        _buildNavLink('Contact', 'contact'),
                      ],
                    ),
                  ),

                  // Social Links (Placeholder Icons)
                  // TODO: Replace with actual icons (e.g., FontAwesomeIcons)
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: overlayWidth - 64.w,
                    ), // Account for padding
                    child: Wrap(
                      spacing: 20.w,
                      runSpacing: 20.h,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const FaIcon(FontAwesomeIcons.linkedin, color: V2Colors.text),
                          iconSize: 50.sp,
                          onPressed:
                              () => _launchUrlHelper(
                                'https://www.linkedin.com/in/ali-haydar-ayar-b45a4315b/',
                              ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const FaIcon(FontAwesomeIcons.github, color: V2Colors.text),
                          iconSize: 50.sp,
                          onPressed: () => _launchUrlHelper('https://github.com/Sonderman'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, String section) {
    return GestureDetector(
      onTap: () {
        onClose();
        Future.delayed(100.ms, () {
          switch (section) {
            case 'about':
              Scrollable.ensureVisible(
                aboutKey.currentContext!,
                duration: const Duration(milliseconds: 500),
              );
              break;
            case 'resume':
              Scrollable.ensureVisible(
                resumeKey.currentContext!,
                duration: const Duration(milliseconds: 500),
              );
              break;
            case 'projects':
              Scrollable.ensureVisible(
                projectsKey.currentContext!,
                duration: const Duration(milliseconds: 500),
              );
              break;
            case 'activity':
              Scrollable.ensureVisible(
                activityKey.currentContext!,
                duration: const Duration(milliseconds: 500),
              );
              break;
            case 'contact':
              Scrollable.ensureVisible(
                contactKey.currentContext!,
                duration: const Duration(milliseconds: 500),
              );
              break;
          }
        });
      },
      child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: AutoSizeText(
              title,
              style: TextStyle(
                fontFamily: V2Fonts.heading,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                color: V2Colors.text,
              ),
              minFontSize: 10, // Added minFontSize
            ),
          )
          .animate(target: isVisible ? 1 : 0)
          .fadeIn(delay: 300.ms, duration: 400.ms)
          .slideX(begin: 0.2),
    );
  }

  // Helper function to launch URLs safely
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
}
