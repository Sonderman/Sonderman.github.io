import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary, // Match original section background
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 80.h),
        child: Column(
          children: [
            // Section Header
            const SectionHeader(title: 'About Me'),
            SizedBox(height: 50.h),

            // About Content (Image + Text) - Using LayoutBuilder for responsiveness
            LayoutBuilder(
              builder: (context, constraints) {
                const double breakpoint = 992.0;
                bool isDesktop = constraints.maxWidth >= breakpoint;

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
                    Text(
                      "What I'm Doing",
                      style: TextStyle(
                        fontFamily: AppFonts.heading,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
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
                } else {
                  return Column(
                    children: [
                      ConstrainedBox(constraints: BoxConstraints(maxWidth: 400.w), child: leftSide),
                      SizedBox(height: 50.h),
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
                Text(
                  "My Skills",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.heading,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 30.h),
                Wrap(
                  spacing: 40.w,
                  runSpacing: 30.h,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildSkillItem(context, "Flutter", 90),
                    _buildSkillItem(context, "Dart", 85),
                    _buildSkillItem(context, "Unity Engine", 75),
                    _buildSkillItem(context, "C#", 70),
                  ],
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
        child: Text(text, style: TextStyle(fontSize: 16.sp, color: AppColors.text, height: 1.6)),
      ),
    ); // Close Animate
  }

  // Removed _buildServiceCard helper method, replaced by _ServiceInfoCard widget below

  Widget _buildSkillItem(BuildContext context, String skill, int percentage) {
    // Calculation needs context for MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = 60.w * 2;
    double wrapSpacing = 40.w;
    int numberOfColumns = screenWidth < 600 ? 1 : 2;
    double availableWidth =
        (screenWidth - horizontalPadding - (wrapSpacing * (numberOfColumns - 1))) / numberOfColumns;
    availableWidth = availableWidth.clamp(150.w, 400.w);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  skill,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              // Background track
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
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
                              colors: [AppColors.secondary, AppColors.accent1],
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
  const _AboutImageSection({super.key});

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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Icon(icon, color: AppColors.secondary, size: 20.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textMuted),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchUrlHelper(url),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: const BoxDecoration(color: AppColors.card, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.text, size: 20.sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = ScreenUtil().screenWidth < 600 ? 200.w : 300.w;

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
                      border: Border.all(color: AppColors.secondary, width: 2.w),
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
        SizedBox(height: 30.h),
        // Social Links Section
        _buildSocialLink(
          icon: Icons.email_outlined,
          text: 'alihaydar338@gmail.com',
          url: 'mailto:alihaydar338@gmail.com',
        ),
        SizedBox(height: 16.h),
        _buildSocialLink(icon: Icons.location_on_outlined, text: 'Remote/Turkey'),
        SizedBox(height: 16.h),
        // Social Icons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSocialIcon(Icons.link, 'https://linkedin.com'), // Use actual URLs
            SizedBox(width: 16.w),
            _buildSocialIcon(Icons.code, 'https://github.com/sonderman'), // Use actual URLs
          ],
        ),
      ],
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
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: _isHovered ? [AppTheme.shadowLg] : [AppTheme.shadowMd], // Enhance shadow
            border: Border.all(
              // Add subtle border
              color: _isHovered ? AppColors.secondary.withOpacity(0.5) : Colors.transparent,
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
                width: 50.w,
                height: 50.h,
                decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                child: Icon(widget.icon, color: AppColors.primary, size: 24.sp),
              ),
              SizedBox(width: 24.w),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: AppFonts.heading,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 14.sp, color: AppColors.textMuted, height: 1.5),
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
