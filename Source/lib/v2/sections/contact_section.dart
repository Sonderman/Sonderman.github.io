import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import AutoSizeText
import 'package:myportfolio/v2/data/personal_datas.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart'; // Import theme
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
      color: V2Colors.primary, // Match original section background
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

                _buildContactForm()
                    .animate() // Add entry animation
                    .fadeIn(duration: 600.ms, delay: 150.ms) // Stagger animation
                    .slideX(begin: 0.2, duration: 600.ms, delay: 150.ms, curve: Curves.easeOut);

                if (isDesktop) {
                  // Desktop layout: Row
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: contactInfo),
                      SizedBox(width: V2Theme.spacingLg.w), // Use theme spacing
                      //Expanded(flex: 2, child: contactForm),
                    ],
                  );
                } else {
                  // Mobile layout: Column
                  return Column(
                    children: [
                      //contactForm, // Form first on mobile like original CSS
                      SizedBox(height: V2Theme.spacingLg.h), // Use theme spacing
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
        SizedBox(height: V2Theme.spacingMd.h),
        _ContactInfoCard(
          // Use the new StatefulWidget
          icon: Icons.location_on_outlined,
          title: 'Location',
          content: 'Remote/Turkey',
          // No URL for location
          launchUrlHelper: _launchUrlHelper, // Pass the helper function (though not used here)
        ),
        SizedBox(height: V2Theme.spacingMd.h),
        // Social Profiles Card
        Container(
          padding: EdgeInsets.all(V2Theme.spacingMd.w),
          decoration: BoxDecoration(
            color: V2Colors.card,
            borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
            boxShadow: [V2Theme.shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "Social Profiles",
                style: TextStyle(
                  fontSize: 18.sp, // Adjust size
                  fontWeight: FontWeight.w600,
                  color: V2Colors.text,
                ),
                minFontSize: 10, // Added minFontSize
              ),
              SizedBox(height: V2Theme.spacingMd.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;

                  // Calculate scaled sizes
                  double scaledContainerSize;
                  double scaledIconSize;
                  double spacing;

                  if (maxWidth >= 800) {
                    scaledContainerSize = 56.w;
                    scaledIconSize = 28.sp;
                    spacing = 24.w;
                  } else if (maxWidth >= 500) {
                    scaledContainerSize = 48.w;
                    scaledIconSize = 24.sp;
                    spacing = 20.w;
                  } else {
                    scaledContainerSize = 48.w;
                    scaledIconSize = 24.sp;
                    spacing = 16.w;
                  }

                  // Enforce minimum pixel sizes regardless of scaling
                  double containerSize = scaledContainerSize.clamp(48.0, 80.0);
                  double iconSize = scaledIconSize.clamp(24.0, 40.0);

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing / 2,
                    children: [
                      _FooterSocialIcon(
                        icon: Icons.link,
                        url: linkedInUrl,
                        launchUrlHelper: _launchUrlHelper,
                        size: containerSize,
                        iconSize: iconSize,
                      ),
                      _FooterSocialIcon(
                        icon: Icons.code,
                        url: githubUrl,
                        launchUrlHelper: _launchUrlHelper,
                        size: containerSize,
                        iconSize: iconSize,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Removed _buildContactCard helper method, replaced by _ContactInfoCard widget below

  // Helper for Contact Form section
  Widget _buildContactForm() {
    return Container(
      padding: EdgeInsets.all(V2Theme.spacingLg.w),
      decoration: BoxDecoration(
        color: V2Colors.card,
        borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
        boxShadow: [V2Theme.shadowMd],
      ),
      child: Form(
        // Use Form widget
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "Send me a message",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: V2Colors.text),
              minFontSize: 10, // Added minFontSize
            ),
            SizedBox(height: V2Theme.spacingMd.h),
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
            SizedBox(height: V2Theme.spacingMd.h),
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
            SizedBox(height: V2Theme.spacingMd.h),
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
            SizedBox(height: V2Theme.spacingMd.h),
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
            SizedBox(height: V2Theme.spacingLg.h),
            // Submit Button with loading indicator
            // Submit Button (Functionality Removed)
            ElevatedButton.icon(
              onPressed: _submitForm, // Keep validation, but no actual submission
              icon: const Icon(Icons.send), // Remove loading indicator logic
              label: const AutoSizeText('Send Message', minFontSize: 10), // Added minFontSize
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
          content: AutoSizeText(
            'Contact form submission is currently disabled.',
            minFontSize: 10,
          ), // Added minFontSize
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
        child: AutoSizeText(
          widget.content,
          style: TextStyle(
            fontSize: 16.sp,
            color: V2Colors.secondary, // Highlight if link
            decoration: TextDecoration.underline,
            decorationColor: V2Colors.secondary,
          ),
          minFontSize: 10, // Added minFontSize
        ),
      );
    } else {
      contentWidget = AutoSizeText(
        widget.content,
        style: TextStyle(fontSize: 16.sp, color: V2Colors.textMuted),
        minFontSize: 10, // Added minFontSize
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isLink ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: 200.ms, // Animation duration for hover effect
        padding: EdgeInsets.all(V2Theme.spacingMd.w),
        decoration: BoxDecoration(
          color: V2Colors.card,
          borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
          boxShadow:
              _isHovered ? [V2Theme.shadowLg] : [V2Theme.shadowMd], // Enhance shadow on hover
          border: Border.all(
            // Add subtle border on hover
            color: _isHovered ? V2Colors.secondary.withOpacity(0.5) : Colors.transparent,
            width: 1.5,
          ),
        ),
        transform: Matrix4.translationValues(0, _isHovered ? -4.h : 0, 0), // Slight lift on hover
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container (doesn't change on hover)
            Container(
              width: 100.sp,
              height: 100.sp,
              decoration: const BoxDecoration(color: V2Colors.secondary, shape: BoxShape.circle),
              child: Icon(widget.icon, color: V2Colors.primary, size: 90.sp),
            ),
            SizedBox(width: V2Theme.spacingMd.w),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: V2Colors.text,
                    ),
                    minFontSize: 10, // Added minFontSize
                  ),
                  SizedBox(height: V2Theme.spacingXs.h),
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

// StatefulWidget for Footer Social Icon with Hover Effect
class _FooterSocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final Future<void> Function(String) launchUrlHelper; // Pass helper function
  final double size; // Container size
  final double iconSize; // Icon size

  const _FooterSocialIcon({
    required this.icon,
    required this.url,
    required this.launchUrlHelper,
    this.size = 48,
    this.iconSize = 24,
  });

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
            width: widget.size,
            height: widget.size,
            child: Icon(
              widget.icon,
              color: _isHovered ? V2Colors.primary : V2Colors.text,
              size: widget.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
