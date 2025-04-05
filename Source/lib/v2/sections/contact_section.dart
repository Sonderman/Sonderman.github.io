import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
import 'package:myportfolio/v2/widgets/section_header.dart'; // Import SectionHeader
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
// Removed http and dart:convert imports as submission is disabled

class ContactSection extends StatefulWidget {
  // Changed to StatefulWidget
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // Created State class
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _messageController;

  // Removed submission state variables

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Helper for launching URLs (defined within the State class)
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
      color: AppColors.primary, // Match original section background
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 60.w,
          vertical: 80.h,
        ), // Increased vertical padding
        child: Column(
          children: [
            // Section Header
            const SectionHeader(title: 'Contact Me'),
            SizedBox(height: 50.h),
            // Contact Content - Using LayoutBuilder for responsiveness
            LayoutBuilder(
              builder: (context, constraints) {
                const double breakpoint = 992.0; // Match breakpoint used in AboutSection
                bool isDesktop = constraints.maxWidth >= breakpoint;

                Widget contactInfo = _buildContactInfo()
                    .animate() // Add entry animation
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.2, duration: 600.ms, curve: Curves.easeOut);

                Widget contactForm = _buildContactForm()
                    .animate() // Add entry animation
                    .fadeIn(duration: 600.ms, delay: 150.ms) // Stagger animation
                    .slideX(begin: 0.2, duration: 600.ms, delay: 150.ms, curve: Curves.easeOut);

                if (isDesktop) {
                  // Desktop layout: Row
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: contactInfo),
                      SizedBox(width: AppTheme.spacingLg.w), // Use theme spacing
                      Expanded(flex: 2, child: contactForm),
                    ],
                  );
                } else {
                  // Mobile layout: Column
                  return Column(
                    children: [
                      contactForm, // Form first on mobile like original CSS
                      SizedBox(height: AppTheme.spacingLg.h), // Use theme spacing
                      contactInfo,
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Contact Info section
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactInfoCard(
          // Use the new StatefulWidget
          icon: Icons.email_outlined,
          title: 'Email',
          content: 'alihaydar338@gmail.com',
          url: 'mailto:alihaydar338@gmail.com',
          launchUrlHelper: _launchUrlHelper, // Pass the helper function
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        _ContactInfoCard(
          // Use the new StatefulWidget
          icon: Icons.location_on_outlined,
          title: 'Location',
          content: 'Remote/Turkey',
          // No URL for location
          launchUrlHelper: _launchUrlHelper, // Pass the helper function (though not used here)
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        // Social Profiles Card
        Container(
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
            boxShadow: [AppTheme.shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Social Profiles",
                style: TextStyle(
                  fontSize: 18.sp, // Adjust size
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              SizedBox(height: AppTheme.spacingMd.h),
              Row(
                children: [
                  _buildSocialIcon(Icons.link, 'https://linkedin.com'), // Use actual URL
                  SizedBox(width: AppTheme.spacingSm.w),
                  _buildSocialIcon(Icons.code, 'https://github.com/sonderman'), // Use actual URL
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Removed _buildContactCard helper method, replaced by _ContactInfoCard widget below

  // Helper for social icons (similar to AboutSection)
  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchUrlHelper(url), // Launch URL using helper from State
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: const BoxDecoration(
          color: AppColors.primaryLight, // Match CSS
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.text, size: 20.sp),
      ),
    );
  }

  // Helper for Contact Form section
  Widget _buildContactForm() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
        boxShadow: [AppTheme.shadowMd],
      ),
      child: Form(
        // Use Form widget
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send me a message",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.text),
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            // Form Fields
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Your Name'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Your Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            SizedBox(height: AppTheme.spacingLg.h),
            // Submit Button with loading indicator
            // Submit Button (Functionality Removed)
            ElevatedButton.icon(
              onPressed: _submitForm, // Keep validation, but no actual submission
              icon: const Icon(Icons.send), // Remove loading indicator logic
              label: const Text('Send Message'), // Static text
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
            // Display submission message
            // Removed submission message display area
          ],
        ),
      ),
    );
  }

  // Form submission logic
  // Form submission logic (Functionality Removed)
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, but submission is disabled.
      // Optionally clear the form or show a message.
      debugPrint('Form validated, but submission is currently disabled.');

      // Example: Clear form after validation (optional)
      // _nameController.clear();
      // _emailController.clear();
      // _subjectController.clear();
      // _messageController.clear();
      // _formKey.currentState?.reset();

      // Example: Show a temporary message (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contact form submission is currently disabled.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

// --- New StatefulWidget for Contact Info Card with Hover Effect ---

class _ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;
  final String? url;
  final Future<void> Function(String) launchUrlHelper; // Pass the helper

  const _ContactInfoCard({
    required this.icon,
    required this.title,
    required this.content,
    this.url,
    required this.launchUrlHelper,
  });

  @override
  State<_ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<_ContactInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Determine if the card content should be interactive (link)
    bool isLink = widget.url != null && widget.url != '#';

    Widget contentWidget;
    if (isLink) {
      contentWidget = InkWell(
        onTap: () => widget.launchUrlHelper(widget.url!), // Launch URL
        child: Text(
          widget.content,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary, // Highlight if link
            decoration: TextDecoration.underline,
            decorationColor: AppColors.secondary,
          ),
        ),
      );
    } else {
      contentWidget = Text(
        widget.content,
        style: TextStyle(fontSize: 16.sp, color: AppColors.textMuted),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isLink ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: 200.ms, // Animation duration for hover effect
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
          boxShadow:
              _isHovered ? [AppTheme.shadowLg] : [AppTheme.shadowMd], // Enhance shadow on hover
          border: Border.all(
            // Add subtle border on hover
            color: _isHovered ? AppColors.secondary.withOpacity(0.5) : Colors.transparent,
            width: 1.5,
          ),
        ),
        transform: Matrix4.translationValues(0, _isHovered ? -4.h : 0, 0), // Slight lift on hover
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container (doesn't change on hover)
            Container(
              width: 50.w,
              height: 50.h,
              decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
              child: Icon(widget.icon, color: AppColors.primary, size: 24.sp),
            ),
            SizedBox(width: AppTheme.spacingMd.w),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXs.h),
                  contentWidget, // Display link or plain text
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
