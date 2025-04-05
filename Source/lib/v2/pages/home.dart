import 'dart:async'; // Import Timer
import 'package:flutter/foundation.dart'; // For kIsWeb check
import 'package:flutter/gestures.dart'; // For PointerHoverEvent
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme
import '../widgets/mobile_nav_overlay.dart'; // Import MobileNavOverlay
import '../widgets/nav_menu.dart';
import '../widgets/particles_background.dart'; // Import ParticlesBackground
// import '../widgets/animated_scroll_indicator.dart'; // No longer needed for single page
import '../widgets/footer.dart'; // Import Footer
import '../widgets/back_to_top_button.dart'; // Import BackToTopButton
import '../sections/about_section.dart'; // Import AboutSection
import '../sections/resume_section.dart'; // Import ResumeSection
import '../sections/projects_section.dart'; // Import ProjectsSection
import '../sections/activity_section.dart'; // Import ActivitySection
import '../sections/contact_section.dart'; // Import ContactSection

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isMobileNavVisible = false;
  bool _isScrolled = false;

  // State for typing animation
  final List<String> _subtitles = const [
    "Flutter & Unity Game Developer",
    "Mobile App Developer",
    "Software Engineer",
  ];
  int _subtitleIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  String _currentSubtitle = "";
  Timer? _typingTimer;

  // State for parallax effect
  Offset _parallaxOffset = Offset.zero;
  bool _isDesktopWeb = false;

  // GlobalKeys for scroll anchoring
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey activityKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey(); // Key for the contact button/section if needed

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // Initialize subtitle
    if (_subtitles.isNotEmpty) {
      _currentSubtitle = _subtitles[0].substring(0, 1);
      _charIndex = 1;
    }
    _startTypingAnimation();

    // Check if parallax should be enabled
    _isDesktopWeb =
        kIsWeb && ![TargetPlatform.iOS, TargetPlatform.android].contains(defaultTargetPlatform);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _toggleMobileNav() {
    setState(() {
      _isMobileNavVisible = !_isMobileNavVisible;
    });
  }

  void _scrollListener() {
    final isScrolled = _scrollController.hasClients && _scrollController.offset > 50;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  // Typing animation logic
  void _tickTypingAnimation() {
    if (!mounted) return;

    const typingSpeed = Duration(milliseconds: 100);
    const deletingSpeed = Duration(milliseconds: 50);
    const pauseDuration = Duration(milliseconds: 1500);
    Duration nextTickDuration = typingSpeed;

    setState(() {
      String currentTargetText = _subtitles[_subtitleIndex];

      if (_isDeleting) {
        if (_charIndex > 0) {
          _currentSubtitle = currentTargetText.substring(0, _charIndex - 1);
          _charIndex--;
          nextTickDuration = deletingSpeed;
        } else {
          _isDeleting = false;
          _subtitleIndex = (_subtitleIndex + 1) % _subtitles.length;
          currentTargetText = _subtitles[_subtitleIndex];
          _currentSubtitle = ""; // Clear before starting next word
          _charIndex = 0;
          // Add pause before typing next word
          nextTickDuration = const Duration(milliseconds: 500);
        }
      } else {
        if (_charIndex < currentTargetText.length) {
          _currentSubtitle = currentTargetText.substring(0, _charIndex + 1);
          _charIndex++;
          nextTickDuration = typingSpeed;
        } else {
          _isDeleting = true;
          nextTickDuration = pauseDuration;
        }
      }
    });

    _typingTimer = Timer(nextTickDuration, _tickTypingAnimation);
  }

  void _startTypingAnimation() {
    const initialDelay = Duration(milliseconds: 3000);
    _typingTimer?.cancel();
    _typingTimer = Timer(initialDelay, _tickTypingAnimation);
  }

  // Mouse hover handler for parallax
  void _handleMouseHover(PointerHoverEvent event) {
    if (!mounted || !_isDesktopWeb) return;

    final Size screenSize = MediaQuery.of(context).size;
    final double normalizedX = (event.position.dx / screenSize.width) - 0.5;
    final double normalizedY = (event.position.dy / screenSize.height) - 0.5;
    const double parallaxFactor = 20.0;

    setState(() {
      _parallaxOffset = Offset(normalizedX * parallaxFactor, normalizedY * parallaxFactor);
    });
  }

  // Helper method for floating icons
  Widget _buildFloatingIcon({
    required IconData icon,
    required Color color,
    required Alignment alignment,
    required double size,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: size * 0.5),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .moveY(
            begin: -5.h,
            end: 5.h,
            duration: const Duration(seconds: 3),
            curve: Curves.easeInOut,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Main stack for content, overlay, particles, and back-to-top
        children: [
          // Particle Background (Behind Everything)
          const Positioned.fill(
            child: ParticlesBackground(
              particleCount: 80, // Keep particle count
              connectionColor: Colors.white, // Set connection line color (adjust if needed)
              connectionDistance: 100.0, // Set connection distance (adjust if needed)
            ),
          ),
          // Content Column (Nav + Scrollable Area)
          Column(
            children: [
              NavMenu(
                onMenuPressed: _toggleMobileNav,
                isMobileMenuOpen: _isMobileNavVisible,
                isScrolled: _isScrolled,
                // Pass the keys to NavMenu
                homeKey: homeKey,
                aboutKey: aboutKey,
                resumeKey: resumeKey,
                projectsKey: projectsKey,
                activityKey: activityKey,
                contactKey: contactKey,
                scrollController: _scrollController, // Pass ScrollController
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    // Changed from Stack to Column
                    children: [
                      // --- Hero Section ---
                      Container(
                        key: homeKey, // Assign key to Hero section container
                        constraints: BoxConstraints(
                          minHeight: 1.sh - 80.h, // Ensure hero takes viewport height minus nav
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 40.h),
                        alignment: Alignment.center,
                        child: MouseRegion(
                          onHover: _handleMouseHover,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              bool isDesktop = constraints.maxWidth > 992;
                              CrossAxisAlignment textAlignment =
                                  isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center;
                              MainAxisAlignment rowAlignment =
                                  isDesktop
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.center;

                              // --- Hero Text Column ---
                              Widget heroText = Transform.translate(
                                offset: _isDesktopWeb ? _parallaxOffset * -1.0 : Offset.zero,
                                child: Column(
                                  crossAxisAlignment: textAlignment,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Name
                                    Text(
                                          'Ali Haydar AYAR',
                                          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displayMedium?.copyWith(
                                            fontFamily: AppFonts.heading,
                                            fontSize: isDesktop ? 64.sp : 48.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.text,
                                          ),
                                        )
                                        .animate()
                                        .fadeIn(
                                          duration: 800.ms,
                                          delay: 200.ms,
                                          curve: Curves.easeOut,
                                        )
                                        .slideY(
                                          begin: 0.3,
                                          duration: 800.ms,
                                          delay: 200.ms,
                                          curve: Curves.easeOut,
                                        ),
                                    SizedBox(height: 10.h),
                                    // Title
                                    Text(
                                          'Software Developer',
                                          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineMedium?.copyWith(
                                            fontFamily: AppFonts.heading,
                                            fontSize: isDesktop ? 40.sp : 32.sp,
                                            color: AppColors.secondary,
                                          ),
                                        )
                                        .animate()
                                        .fadeIn(
                                          duration: 800.ms,
                                          delay: 600.ms, // Adjusted delay
                                          curve: Curves.easeOut,
                                        )
                                        .slideY(
                                          begin: 0.3,
                                          duration: 800.ms,
                                          delay: 600.ms, // Adjusted delay
                                          curve: Curves.easeOut,
                                        ),
                                    SizedBox(height: 20.h),
                                    // Subtitle (Typing)
                                    Text(
                                          _currentSubtitle,
                                          key: ValueKey(_subtitleIndex),
                                          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontSize: isDesktop ? 18.sp : 16.sp,
                                            color: AppColors.textMuted,
                                            height: 1.4,
                                          ),
                                        )
                                        .animate()
                                        .fadeIn(
                                          duration: 800.ms,
                                          delay: 1000.ms, // Adjusted delay
                                          curve: Curves.easeOut,
                                        )
                                        .slideY(
                                          begin: 0.3,
                                          duration: 800.ms,
                                          delay: 1000.ms, // Adjusted delay
                                          curve: Curves.easeOut,
                                        ),
                                    SizedBox(height: 30.h),
                                    // CTA Buttons
                                    Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: isDesktop ? 0 : 40.w,
                                          ),
                                          child: Flex(
                                            direction: isDesktop ? Axis.horizontal : Axis.vertical,
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Scroll to Projects section
                                                  Scrollable.ensureVisible(
                                                    projectsKey.currentContext!,
                                                    duration: const Duration(milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                                child: const Text('View Projects'),
                                              ),
                                              SizedBox(
                                                width: isDesktop ? 20.w : 0,
                                                height: isDesktop ? 0 : 15.h,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  // Scroll to Contact section
                                                  Scrollable.ensureVisible(
                                                    contactKey
                                                        .currentContext!, // Assuming contact section has this key
                                                    duration: const Duration(milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                                child: const Text('Get in Touch'),
                                              ),
                                            ],
                                          ),
                                        )
                                        .animate()
                                        .fadeIn(
                                          duration: 800.ms,
                                          delay: 1400.ms, // Adjusted delay
                                          curve: Curves.easeOut,
                                        )
                                        .slideY(
                                          begin: 0.3,
                                          duration: 800.ms,
                                          delay: 1400.ms, // Adjusted delay
                                          curve: Curves.easeOut,
                                        ),
                                  ],
                                ),
                              );

                              // --- Hero Image ---
                              Widget heroImage = Transform.translate(
                                offset: _isDesktopWeb ? _parallaxOffset * 0.75 : Offset.zero,
                                child: Container(
                                  width: isDesktop ? 300.w : 250.w,
                                  height: isDesktop ? 300.h : 250.h,
                                  margin: EdgeInsets.symmetric(vertical: isDesktop ? 0 : 40.h),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Profile Image
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.secondary,
                                            width: 4.w,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 16,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/profileImage.png',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                      ),
                                      // Floating Icons
                                      _buildFloatingIcon(
                                        icon: Icons.flutter_dash,
                                        color: const Color(0xFF54C5F8),
                                        alignment: const Alignment(-0.9, -0.9),
                                        size: isDesktop ? 60.w : 50.w,
                                      ),
                                      _buildFloatingIcon(
                                        icon: Icons.gamepad_outlined,
                                        color: AppColors.text,
                                        alignment: const Alignment(0.9, 0.9),
                                        size: isDesktop ? 60.w : 50.w,
                                      ),
                                    ],
                                  ),
                                ),
                              );

                              // --- Build Layout ---
                              return Flex(
                                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                                mainAxisAlignment: rowAlignment,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:
                                    isDesktop
                                        ? [Expanded(child: heroText), Expanded(child: heroImage)]
                                        : [heroText, heroImage],
                              );
                            },
                          ),
                        ),
                      ), // Close Hero Section Container
                      // --- About Section ---
                      Animate(
                        effects: [
                          // Removed const
                          FadeEffect(duration: 600.ms),
                          SlideEffect(
                            begin: const Offset(0, 50),
                            curve: Curves.easeOut,
                            duration: 600.ms,
                          ), // Added duration
                        ],
                        child: Container(key: aboutKey, child: const AboutSection()),
                      ),

                      // --- Resume Section ---
                      Animate(
                        effects: [
                          // Removed const
                          FadeEffect(duration: 600.ms),
                          SlideEffect(
                            begin: const Offset(0, 50),
                            curve: Curves.easeOut,
                            duration: 600.ms,
                          ), // Added duration
                        ],
                        child: Container(key: resumeKey, child: const ResumeSection()),
                      ),

                      // --- Projects Section ---
                      Animate(
                        effects: [
                          // Removed const
                          FadeEffect(duration: 600.ms),
                          SlideEffect(
                            begin: const Offset(0, 50),
                            curve: Curves.easeOut,
                            duration: 600.ms,
                          ), // Added duration
                        ],
                        child: Container(key: projectsKey, child: const ProjectsSection()),
                      ),

                      // --- Activity Section ---
                      Animate(
                        effects: [
                          // Removed const
                          FadeEffect(duration: 600.ms),
                          SlideEffect(
                            begin: const Offset(0, 50),
                            curve: Curves.easeOut,
                            duration: 600.ms,
                          ), // Added duration
                        ],
                        child: Container(key: activityKey, child: const ActivitySection()),
                      ),

                      // --- Contact Section ---
                      Animate(
                        effects: [
                          // Removed const
                          FadeEffect(duration: 600.ms),
                          SlideEffect(
                            begin: const Offset(0, 50),
                            curve: Curves.easeOut,
                            duration: 600.ms,
                          ), // Added duration
                        ],
                        child: Container(
                          key: contactKey,
                          child: const ContactSection(),
                        ), // Assign key
                      ),

                      // --- Footer ---
                      Footer(
                        onLogoTap: () {
                          _scrollController.animateTo(
                            0.0, // Scroll to the top
                            duration: const Duration(milliseconds: 500), // Animation duration
                            curve: Curves.easeInOut, // Animation curve
                          );
                        },
                      ), // Footer inside the scrollable column
                    ], // Close Column children
                  ), // Close Column
                ),
              ),
            ],
          ), // Close Content Column
          // Mobile Nav Overlay
          MobileNavOverlay(isVisible: _isMobileNavVisible, onClose: _toggleMobileNav),
          // Back To Top Button - On top of everything
          BackToTopButton(scrollController: _scrollController),
        ],
      ),
    );
  }
}
