import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myportfolio/app_routes.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome

class MobileNavOverlay extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClose;

  const MobileNavOverlay({super.key, required this.isVisible, required this.onClose});

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
        color: V2Colors.primary, // Match original background
        elevation: 16, // Add some shadow
        child: Padding(
          padding: EdgeInsets.only(
            top: 100.h, // Space from top like original
            left: 32.w,
            right: 32.w,
            bottom: 40.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navigation Links
              Expanded(
                child: ListView(
                  // Use ListView in case content overflows
                  children: [
                    /*
                    _buildNavLink('About', AppRoutes.about),
                    SizedBox(height: 20.h), // Spacing like var(--spacing-md)
                    _buildNavLink('Resume', AppRoutes.resume),
                    SizedBox(height: 20.h),
                    _buildNavLink('Projects', AppRoutes.projects),
                    SizedBox(height: 20.h),
                    _buildNavLink('Activity', AppRoutes.activity),
                    SizedBox(height: 20.h),
                    _buildNavLink('Contact', AppRoutes.contact),*/
                  ],
                ),
              ),

              // Social Links (Placeholder Icons)
              // TODO: Replace with actual icons (e.g., FontAwesomeIcons)
              Row(
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: V2Colors.text,
                    ), // Use FontAwesome LinkedIn
                    iconSize: 24.sp, // Approx 1.5rem
                    onPressed:
                        () => _launchUrlHelper(
                          'https://www.linkedin.com/in/ali-haydar-ayar-b45a4315b/',
                        ),
                  ),
                  SizedBox(width: 20.w), // Spacing like var(--spacing-md)
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      color: V2Colors.text,
                    ), // Use FontAwesome GitHub
                    iconSize: 24.sp,
                    onPressed: () => _launchUrlHelper('https://github.com/Sonderman'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, String route) {
    return GestureDetector(
      onTap: () {
        onClose(); // Close overlay first
        // Use Future.delayed to allow animation to start before navigation
        Future.delayed(100.ms, () => Get.toNamed(route));
      },
      child: Text(
            title,
            style: TextStyle(
              fontFamily: V2Fonts.heading,
              fontSize: 24.sp, // Approx 1.5rem
              fontWeight: FontWeight.w600,
              color: V2Colors.text,
            ),
          )
          .animate(target: isVisible ? 1 : 0) // Animate based on visibility
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
