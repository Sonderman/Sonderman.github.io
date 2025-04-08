import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/data/personal_datas.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart'; // Import theme
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import 'package:auto_size_text/auto_size_text.dart'; // Import AutoSizeText

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: V2Colors.primary, // Match original section background
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              ScreenUtil().screenWidth < 600
                  ? 24
                      .w // Mobile
                  : ScreenUtil().screenWidth < 1200
                  ? 40
                      .w // Tablet
                  : 60.w, // Desktop
          vertical: ScreenUtil().screenWidth < 600 ? 40.h : 80.h,
        ),
        child: Column(
          children: [
            // Section Header
            const SectionHeader(title: 'About Me'),
            SizedBox(height: 50.h),

            // About Content (Image + Text) - Using LayoutBuilder for responsiveness
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                bool isMobile = screenWidth < 600;
                bool isTablet = screenWidth >= 600 && screenWidth < 1200;
                bool isDesktop = screenWidth >= 1200;

                // Define Widgets for Left and Right sides
                Widget leftSide = const _AboutImageSection(); // Extracted StatefulWidget

                Widget rightSide = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Apply scroll animation to each paragraph
                    _buildAboutParagraph(
                      "Hello! I am Ali Haydar. I graduated from Karabük University in computer engineering and I am passionate about software development. I have been working with the Flutter framework for more than 2 years and I am constantly improving myself in this field. Additionally, I have 1 year of work experience with Unity Engine and took part in mobile game development processes.",
                    ),
                    _buildAboutParagraph(
                      "The complex application I developed with Flutter and the mobile games I published with Unity gave me the opportunity to showcase my talents and creativity in the software world. These experiences encouraged me to further my technical skills and develop further in new projects.",
                    ),
                    _buildAboutParagraph(
                      "I am currently improving myself further in Flutter and looking for new job opportunities in this field. I look forward to contributing and developing unique applications as part of an innovative team.",
                    ),
                    _buildAboutParagraph(
                      "I am someone who likes to take responsibility, is prone to teamwork and is willing to constantly learn. I look forward to collaborating on new projects and achieving great success together. Feel free to contact me!",
                    ),
                    SizedBox(height: 40.h),
                    AutoSizeText(
                      "What I'm Doing",
                      style: TextStyle(
                        fontFamily: V2Fonts.heading,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: V2Colors.text,
                      ),
                      minFontSize: 10, // Added minFontSize
                    ), // Removed extra parenthesis
                    SizedBox(height: 24.h),
                    Wrap(
                      spacing: 30.w,
                      runSpacing: 30.h,
                      children: [
                        // Apply scroll animation to each service card
                        _ServiceInfoCard(
                          // Use new StatefulWidget
                          icon: Icons.phone_android,
                          title: 'Mobile Applications',
                          description:
                              'Professional development of applications for iOS and Android.',
                        ),
                        _ServiceInfoCard(
                          // Use new StatefulWidget
                          icon: Icons.sports_esports_outlined,
                          title: 'Mobile Games',
                          description:
                              'Professional development of Casual/Hypercasual games for iOS and Android.',
                        ),
                      ],
                    ),
                  ],
                );

                // Return Row for desktop, Column for mobile
                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: leftSide),
                      SizedBox(width: 50.w),
                      Expanded(flex: 2, child: rightSide),
                    ],
                  );
                } else if (isTablet) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(constraints: BoxConstraints(maxWidth: 300.w), child: leftSide),
                      SizedBox(width: 40.w),
                      Expanded(child: rightSide),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 0.8.sw),
                        child: leftSide,
                      ),
                      SizedBox(height: isMobile ? 30.h : 50.h),
                      rightSide,
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 80.h),

            // Skills Section
            Column(
              children: [
                AutoSizeText(
                  "My Skills",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: V2Fonts.heading,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: V2Colors.text,
                  ),
                  minFontSize: 10, // Added minFontSize
                ), // Removed extra parenthesis
                SizedBox(height: 40.h), // Increased from 30
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;
                    if (isMobile) {
                      // On mobile, stack skill items vertically and make them full width
                      final double horizontalPadding =
                          24.w * 2; // Mobile padding from main container
                      final double maxWidth = constraints.maxWidth - horizontalPadding;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: _buildSkillItem(context, "Flutter", 90, maxWidth: maxWidth),
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            width: double.infinity,
                            child: _buildSkillItem(context, "Dart", 85, maxWidth: maxWidth),
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            width: double.infinity,
                            child: _buildSkillItem(context, "Unity Engine", 75, maxWidth: maxWidth),
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            width: double.infinity,
                            child: _buildSkillItem(context, "C#", 70, maxWidth: maxWidth),
                          ),
                        ],
                      );
                    } else {
                      // On tablet and desktop, use Wrap for multi-column layout
                      return Wrap(
                        spacing: 40.w,
                        runSpacing: 30.h,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildSkillItem(context, "Flutter", 90),
                          _buildSkillItem(context, "Dart", 85),
                          _buildSkillItem(context, "Unity Engine", 75),
                          _buildSkillItem(context, "C#", 70),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Methods defined within AboutSection ---

  Widget _buildAboutParagraph(String text) {
    // Add scroll animation
    return Animate(
      effects: [
        FadeEffect(duration: 600.ms, curve: Curves.easeOut),
        SlideEffect(begin: const Offset(0, 30), duration: 600.ms, curve: Curves.easeOut),
      ],
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: AutoSizeText(
          text,
          style: TextStyle(
            fontSize:
                ScreenUtil().screenWidth < 600
                    ? 18
                        .sp // Mobile
                    : ScreenUtil().screenWidth < 1200
                    ? 19
                        .sp // Tablet
                    : 20.sp, // Desktop
            color: V2Colors.text,
            height: 1.6,
          ),
          minFontSize: ScreenUtil().screenWidth < 600 ? 14 : 16,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ); // Close Animate
  }

  // Removed _buildServiceCard helper method, replaced by _ServiceInfoCard widget below

  Widget _buildSkillItem(BuildContext context, String skill, int percentage, {double? maxWidth}) {
    // Calculation needs context for MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = 60.w * 2;
    double wrapSpacing = 40.w;
    int numberOfColumns = screenWidth < 600 ? 1 : 2;

    double availableWidth;
    if (maxWidth != null) {
      availableWidth = maxWidth;
    } else {
      availableWidth =
          (screenWidth - horizontalPadding - (wrapSpacing * (numberOfColumns - 1))) /
          numberOfColumns;
      availableWidth = availableWidth.clamp(150.w, 400.w);
    }
    double progressBarWidth = (availableWidth * (percentage / 100)).clamp(0.0, availableWidth);

    // Wrap with Animate to trigger on scroll
    return Animate(
      effects: [
        FadeEffect(duration: 600.ms, curve: Curves.easeOut),
        SlideEffect(begin: const Offset(0, 30), duration: 600.ms, curve: Curves.easeOut),
      ],
      child: SizedBox(
        width: availableWidth,
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: availableWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      skill,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: V2Colors.text,
                        fontWeight: FontWeight.w500,
                      ),
                      minFontSize: 16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AutoSizeText(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: V2Colors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                    minFontSize: 16,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              // Background track
              height: 8.h,
              decoration: BoxDecoration(
                color: V2Colors.primaryLight,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                // Animate the width of the inner container representing the progress
                child: Container() // Placeholder container to apply animation to
                    .animate()
                    .custom(
                      duration: 1000.ms, // Animation duration
                      curve: Curves.easeOutCubic,
                      begin: 0.0, // Start width
                      end: progressBarWidth, // End width from calculation
                      builder: (_, value, __) {
                        // Corrected builder signature
                        // Build the container with the animated width 'value'
                        // and explicitly define the decoration.
                        return Container(
                          width: value,
                          decoration: BoxDecoration(
                            // Define decoration explicitly
                            gradient: const LinearGradient(
                              colors: [V2Colors.secondary, V2Colors.accent1],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        );
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    ); // Close Animate
  }
}

// StatefulWidget for the Image Section to manage hover state and contain its helpers
class _AboutImageSection extends StatefulWidget {
  const _AboutImageSection();

  @override
  __AboutImageSectionState createState() => __AboutImageSectionState();
}

class __AboutImageSectionState extends State<_AboutImageSection> {
  bool _isHovered = false;

  // --- Helper Methods moved inside the State class ---

  Future<void> _launchUrlHelper(String url) async {
    final Uri? launchUri = Uri.tryParse(url);
    if (launchUri == null) {
      debugPrint('Could not parse URL: $url');
      return;
    }
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        debugPrint('Could not launch $url');
        // Optionally show a snackbar or message to the user
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
      // Optionally show a snackbar or message to the user
    }
  }

  Widget _buildSocialLink({required IconData icon, required String text, String? url}) {
    return InkWell(
      onTap: url != null ? () => _launchUrlHelper(url) : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 28.w),
        decoration: BoxDecoration(color: V2Colors.card, borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Flexible(flex: 0, child: Icon(icon, color: V2Colors.secondary, size: 60.sp)),
            SizedBox(width: 28.w),
            Expanded(
              child: AutoSizeText(
                text,
                style: TextStyle(color: V2Colors.textMuted),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double imageSize =
        ScreenUtil().screenWidth < 600
            ? 400
                .sp // Mobile
            : ScreenUtil().screenWidth < 1200
            ? 350
                .w // Tablet
            : 350.w; // Desktop

    return Column(
      children: [
        // Image Frame with Border and Hover Effect
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.basic,
          child: SizedBox(
            width: imageSize,
            height: imageSize,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Border Element
                Positioned(
                  top: -5.w,
                  left: -5.w,
                  right: -5.w,
                  bottom: -5.w,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r + 5.r),
                      border: Border.all(color: V2Colors.secondary, width: 2.w),
                    ),
                  ),
                ),
                // Image Container
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Image.asset(
                        'assets/profileImage.png',
                        fit: BoxFit.cover,
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 40.h), // Increased from 30
        // Social Links Section
        _buildSocialLink(
          icon: Icons.email_outlined,
          text: 'alihaydar338@gmail.com',
          url: 'mailto:alihaydar338@gmail.com',
        ),
        SizedBox(height: 24.h), // Increased from 20
        _buildSocialLink(icon: Icons.location_on_outlined, text: 'Remote/Turkey'),
        SizedBox(height: 24.h), // Increased from 20
        // Social Icons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _FooterSocialIcon(
              icon: Icons.link,
              url: linkedInUrl,
              launchUrlHelper: _launchUrlHelper,
            ),
            SizedBox(width: 16.w),
            _FooterSocialIcon(icon: Icons.code, url: githubUrl, launchUrlHelper: _launchUrlHelper),
          ],
        ),
      ],
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
            width: 80.sp,
            height: 80.sp,
            child: Icon(
              widget.icon,
              color: _isHovered ? V2Colors.primary : V2Colors.text, // Change icon color on hover
              size: 60.sp,
            ),
          ),
        ),
      ),
    );
  }
}

// --- New StatefulWidget for Service Info Card with Hover Effect ---

class _ServiceInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceInfoCard({required this.icon, required this.title, required this.description});

  @override
  State<_ServiceInfoCard> createState() => _ServiceInfoCardState();
}

class _ServiceInfoCardState extends State<_ServiceInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Add scroll animation here, wrapping the MouseRegion/AnimatedContainer
    return Animate(
      effects: [
        FadeEffect(duration: 600.ms, curve: Curves.easeOut),
        SlideEffect(begin: const Offset(0, 30), duration: 600.ms, curve: Curves.easeOut),
      ],
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.basic, // Default cursor, not clickable
        child: AnimatedContainer(
          duration: 200.ms,
          padding: EdgeInsets.all(30.w),
          decoration: BoxDecoration(
            color: V2Colors.card,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: _isHovered ? [V2Theme.shadowLg] : [V2Theme.shadowMd], // Enhance shadow
            border: Border.all(
              // Add subtle border
              color: _isHovered ? V2Colors.secondary.withOpacity(0.5) : Colors.transparent,
              width: 1.5,
            ),
          ),
          transform: Matrix4.translationValues(0, _isHovered ? -5.h : 0, 0), // Lift effect
          constraints: BoxConstraints(minWidth: 250.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                width: 100.sp,
                height: 100.sp,
                decoration: const BoxDecoration(color: V2Colors.secondary, shape: BoxShape.circle),
                child: Icon(widget.icon, color: V2Colors.primary, size: 90.sp),
              ),
              SizedBox(width: 24.w),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.title,
                      style: TextStyle(
                        fontFamily: V2Fonts.heading,
                        fontSize: 22.sp, // Increased base size
                        fontWeight: FontWeight.w600,
                        color: V2Colors.text,
                      ),
                      minFontSize: 18, // Increased min size
                      maxLines: 2, // Allow title to wrap if needed
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    AutoSizeText(
                      widget.description,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: V2Colors.textMuted,
                        height: 1.5,
                      ), // Increased base size
                      minFontSize: 15, // Increased min size
                      maxLines: 4, // Allow description to wrap
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
