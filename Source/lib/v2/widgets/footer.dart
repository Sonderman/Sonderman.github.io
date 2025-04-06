import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import AutoSizeText
import 'package:myportfolio/v2/data/personal_datas.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate

class Footer extends StatelessWidget {
  final VoidCallback? onLogoTap; // Callback for logo tap

  const Footer({super.key, this.onLogoTap});

  // Helper for launching URLs (kept stateless as it doesn't depend on Footer's state)
  Future<void> _launchUrlHelper(String url) async {
    final Uri? launchUri = Uri.tryParse(url);
    if (launchUri == null || url == '#') {
      debugPrint('Invalid or placeholder URL: $url');
      return;
    }
    try {
      bool launched = await launchUrl(launchUri);
      if (!launched) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: V2Colors.primaryLight, // Match original footer background
      padding: EdgeInsets.symmetric(
        vertical: 40.h,
        horizontal: 60.w,
      ), // Approx var(--spacing-lg) and container padding
      child: Column(
        children: [
          // Footer Content (Logo + Social) - Use LayoutBuilder for responsiveness
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 768; // Breakpoint from CSS

              Widget logo = MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                  onTap: onLogoTap, // Call the callback
                  borderRadius: BorderRadius.circular(V2Theme.borderRadiusSm), // For splash effect
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.h,
                      horizontal: 8.w,
                    ), // Add padding for tap area
                    child: AutoSizeText(
                      'Ali Haydar AYAR',
                      style: TextStyle(
                        fontFamily: V2Fonts.heading,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: V2Colors.text,
                      ),
                      minFontSize: 10, // Moved minFontSize here
                    ),
                  ),
                ),
              );

              Widget socialIcons = Row(
                // Extracted social icons widget
                mainAxisSize: MainAxisSize.min, // Keep icons close together
                children: [
                  _FooterSocialIcon(
                    icon: Icons.link,
                    url: linkedInUrl,
                    launchUrlHelper: _launchUrlHelper,
                  ),
                  SizedBox(width: 16.w),
                  _FooterSocialIcon(
                    icon: Icons.code,
                    url: githubUrl,
                    launchUrlHelper: _launchUrlHelper,
                  ),
                ],
              );

              if (isMobile) {
                // Mobile: Column layout
                return Column(
                  children: [
                    logo,
                    SizedBox(height: V2Theme.spacingMd.h), // Spacing for mobile column
                    socialIcons,
                  ],
                );
              } else {
                // Desktop: Row layout
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [logo, socialIcons],
                );
              }
            },
          ),
          SizedBox(height: 30.h),
          // Footer Bottom (Copyright)
          Divider(color: V2Colors.primary, thickness: 1.h),
          SizedBox(height: 30.h),
          AutoSizeText(
            // Already AutoSizeText, just need to add minFontSize
            '© ${DateTime.now().year} Ali Haydar AYAR. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp, // Approx 0.9rem
              color: V2Colors.textMuted,
            ),
            minFontSize: 10, // Added minFontSize
          ), // Removed extra parenthesis here
        ],
      ),
    );
  }
}

// StatefulWidget for Footer Social Icon with Hover Effect
class _FooterSocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final Future<void> Function(String) launchUrlHelper; // Pass helper function

  const _FooterSocialIcon({required this.icon, required this.url, required this.launchUrlHelper});

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.url,
        child: InkWell(
          onTap: () => widget.launchUrlHelper(widget.url), // Use passed helper
          borderRadius: BorderRadius.circular(20.r),
          child: AnimatedContainer(
            duration: 200.ms, // Faster hover transition
            transform: Matrix4.translationValues(0, _isHovered ? -3.h : 0, 0), // Translate Y
            decoration: BoxDecoration(
              color:
                  _isHovered ? V2Colors.secondary : V2Colors.primary, // Change background on hover
              shape: BoxShape.circle,
              boxShadow: _isHovered ? [V2Theme.shadowSm] : [], // Optional shadow on hover
            ),
            width: 40.w,
            height: 40.h,
            child: Icon(
              widget.icon,
              color: _isHovered ? V2Colors.primary : V2Colors.text, // Change icon color on hover
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
