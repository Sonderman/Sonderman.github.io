import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
// import 'package:myportfolio/v2/widgets/nav_menu.dart'; // No longer needed here
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false; // For NavMenu sticky state

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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
    // TODO: Implement MobileNavOverlay integration similar to HomePage if needed globally
    return Scaffold(
      backgroundColor: AppColors.primary, // Match original section background
      // This page is now effectively unused, the content is in AboutSection
      // Removing the NavMenu call to resolve the error.
      body: SingleChildScrollView(
        // Removed Column and NavMenu
        // children: [
        // NavMenu(isScrolled: _isScrolled), // REMOVED
        // Expanded( // Removed Expanded
        // child: SingleChildScrollView( // Kept SingleChildScrollView for structure
        controller: _scrollController,
        child: Padding(
          // Use similar padding as original section-container
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 50.h),
          child: Column(
            children: [
              // Section Header
              const SectionHeader(title: 'About Me'),
              SizedBox(height: 50.h), // Spacing like var(--spacing-lg)
              // About Content (Image + Text)
              // TODO: Implement responsive layout (Row/Column)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side (Image + Social Links)
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // Image Frame - Placeholder for now
                        // TODO: Add image frame border effect from CSS
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r), // --border-radius-lg
                            boxShadow: [
                              // Approximate --shadow-lg
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              'assets/profileImage.png', // Placeholder image
                              fit: BoxFit.cover,
                              // TODO: Add hover scale effect later
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h), // Spacing like var(--spacing-md)
                        // Social Links Section
                        _buildSocialLink(
                          icon: Icons.email_outlined,
                          text: 'alihaydar338@gmail.com',
                          url: 'mailto:alihaydar338@gmail.com',
                        ),
                        SizedBox(height: 16.h), // Spacing like var(--spacing-sm)
                        _buildSocialLink(
                          icon: Icons.location_on_outlined,
                          text: 'Remote/Turkey',
                          // No URL for location
                        ),
                        SizedBox(height: 16.h), // Spacing like var(--spacing-sm)
                        // Social Icons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Align icons left
                          children: [
                            _buildSocialIcon(Icons.link, 'TODO: LinkedIn URL'), // Placeholder
                            SizedBox(width: 16.w), // Spacing like var(--spacing-sm)
                            _buildSocialIcon(Icons.code, 'TODO: GitHub URL'), // Placeholder
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.w), // Spacing like var(--spacing-lg)
                  // Right Side (Text + Services)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About Me Text Paragraphs
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
                        SizedBox(height: 40.h), // Spacing like var(--spacing-lg)
                        // "What I'm Doing" Section
                        Text(
                          "What I'm Doing",
                          style: TextStyle(
                            fontFamily: AppFonts.heading,
                            fontSize: 28.sp, // Approx 1.8rem
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                        SizedBox(height: 24.h), // Spacing like var(--spacing-md)
                        // Services Grid (Using Wrap for responsiveness for now)
                        // TODO: Use proper Grid layout if needed
                        Wrap(
                          spacing: 30.w, // var(--spacing-md) approx
                          runSpacing: 30.h,
                          children: [
                            _buildServiceCard(
                              icon: Icons.phone_android, // Placeholder, use mobile_alt if available
                              title: 'Mobile Applications',
                              description:
                                  'Professional development of applications for iOS and Android.',
                            ),
                            _buildServiceCard(
                              icon:
                                  Icons
                                      .sports_esports_outlined, // Placeholder, use gamepad if available
                              title: 'Mobile Games',
                              description:
                                  'Professional development of Casual/Hypercasual games for iOS and Android.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80.h), // Spacing like var(--spacing-xl)
              // Skills Section
              Column(
                children: [
                  Text(
                    "My Skills",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.heading,
                      fontSize: 28.sp, // Approx 1.8rem
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  SizedBox(height: 30.h), // Spacing like var(--spacing-md)
                  // Skills Grid (Using Wrap for responsiveness for now)
                  // TODO: Use proper Grid layout if needed (e.g., GridView.builder)
                  Wrap(
                    spacing: 40.w, // Gap like var(--spacing-md)
                    runSpacing: 30.h, // Gap like var(--spacing-md)
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

  // Helper for Social Link cards
  Widget _buildSocialLink({required IconData icon, required String text, String? url}) {
    // TODO: Add hover effect from CSS
    return InkWell(
      onTap:
          url != null
              ? () {
                /* TODO: Implement URL launching */
              }
              : null,
      child: Container(
        padding: EdgeInsets.all(16.w), // Spacing like var(--spacing-sm)
        decoration: BoxDecoration(
          color: AppColors.card, // Use theme card color
          borderRadius: BorderRadius.circular(8.r), // --border-radius-md
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.secondary, size: 20.sp), // Approx 1.2rem
            SizedBox(width: 16.w),
            Expanded(
              // Allow text to wrap if needed
              child: Text(
                text,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textMuted),
                overflow: TextOverflow.ellipsis, // Prevent overflow visually
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Social Icon buttons
  Widget _buildSocialIcon(IconData icon, String url) {
    // TODO: Add hover effect from CSS
    return InkWell(
      onTap: () {
        /* TODO: Implement URL launching */
      },
      borderRadius: BorderRadius.circular(20.r), // Make splash circular
      child: Container(
        width: 40.w, // Match CSS size
        height: 40.h,
        decoration: const BoxDecoration(
          color: AppColors.card, // Use theme card color
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.text, size: 20.sp),
      ),
    );
  }

  // Helper for About Paragraphs
  Widget _buildAboutParagraph(String text) {
    // TODO: Add scroll animation later
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h), // Spacing like var(--spacing-md)
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp, // Match body text size
          color: AppColors.text,
          height: 1.6, // Line height
        ),
      ),
    );
  }

  // Helper for Service Cards
  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    // TODO: Add hover effect later
    return Container(
      padding: EdgeInsets.all(30.w), // Spacing like var(--spacing-md)
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8.r), // --border-radius-md
      ),
      constraints: BoxConstraints(minWidth: 250.w), // Ensure minimum width
      child: Row(
        mainAxisSize: MainAxisSize.min, // Keep content tight
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Circle
          Container(
            width: 50.w,
            height: 50.h,
            decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.primary, size: 24.sp), // Approx 1.5rem
          ),
          SizedBox(width: 24.w), // Spacing like var(--spacing-md)
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppFonts.heading,
                    fontSize: 18.sp, // Approx 1.2rem
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 8.h), // Spacing like var(--spacing-xs)
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp, // Approx 0.9rem
                    color: AppColors.textMuted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Skill Items
  Widget _buildSkillItem(BuildContext context, String skill, int percentage) {
    // Calculate width based on available space (assuming 2 columns in Wrap)
    // This is an approximation and might need adjustment based on actual layout behavior
    double availableWidth =
        (MediaQuery.of(context).size.width - (120.w) - (40.w)) /
        2; // Screen - padding - spacing / columns
    double progressBarWidth = (availableWidth * (percentage / 100)).clamp(0.0, availableWidth);

    // TODO: Add scroll animation later
    return SizedBox(
      width: availableWidth, // Approx 2 columns with spacing
      // Wrap the Column with ConstrainedBox
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400.w), // Max width for larger screens
        child: Column(
          children: [
            // Skill Info (Name + Percentage)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  skill,
                  style: TextStyle(
                    fontSize: 16.sp, // 1rem approx
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
            SizedBox(height: 8.h), // Spacing like var(--spacing-xs)
            // Skill Bar
            Container(
              height: 8.h, // Match CSS height
              decoration: BoxDecoration(
                color: AppColors.primaryLight, // Bar background
                borderRadius: BorderRadius.circular(4.r), // --border-radius-sm
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                // TODO: Animate width later
                child: Container(
                  width: progressBarWidth, // Use calculated width
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      // Match CSS gradient
                      colors: [AppColors.secondary, AppColors.accent1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ],
        ), // Close Column
      ), // Close ConstrainedBox
    );
  }
}
