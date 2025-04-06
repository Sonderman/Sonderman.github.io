import 'dart:async'; // Import Timer
import 'dart:math'; // Import Random for icon animation
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb check
import 'package:flutter/gestures.dart'; // For PointerHoverEvent
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart'; // Import theme
import '../widgets/mobile_nav_overlay.dart'; // Import MobileNavOverlay
import '../widgets/nav_menu.dart';
import '../widgets/particles_background.dart'; // Import ParticlesBackground
import '../widgets/footer.dart'; // Import Footer
import '../widgets/back_to_top_button.dart'; // Import BackToTopButton
import '../widgets/animated_scroll_indicator.dart'; // Import AnimatedScrollIndicator
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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

  // State for floating icon animation
  late AnimationController _icon1EffectController; // Controller for teleport effect
  late AnimationController _icon2EffectController;
  Offset _icon1Position = Offset.zero; // Current position
  Offset _icon2Position = Offset.zero;
  Timer? _icon1TeleportTimer;
  Timer? _icon2TeleportTimer;
  Size _bounds = Size.zero; // To store the available area for icons
  final double _iconSize = 100.sp; // Define icon size here

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

    // Initialize floating icon effect controllers
    _icon1EffectController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    ); // Duration for scale out/in
    _icon2EffectController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // Use WidgetsBinding to get initial size and start timers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Set initial bounds and positions
        _bounds = MediaQuery.of(context).size;
        setState(() {
          _icon1Position = _getRandomOffset(_bounds, _iconSize);
          _icon2Position = _getRandomOffset(_bounds, _iconSize);
        });

        // Start the teleport scheduling
        _scheduleNextTeleport(1);
        _scheduleNextTeleport(2);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _typingTimer?.cancel();
    _icon1TeleportTimer?.cancel();
    _icon2TeleportTimer?.cancel();
    _icon1EffectController.dispose();
    _icon2EffectController.dispose();
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

  // --- Floating Icon Animation Logic ---

  // Calculate a random offset within the bounds
  Offset _getRandomOffset(Size bounds, double iconSize) {
    if (bounds == Size.zero) return Offset.zero; // Avoid division by zero if bounds not set
    final random = Random();
    // Ensure icon stays fully within bounds
    final maxX = bounds.width - iconSize;
    final maxY = bounds.height - iconSize;
    // Add a small padding from the edges
    const padding = 20.0;
    final double dx = padding + random.nextDouble() * (maxX - 2 * padding);
    final double dy = padding + random.nextDouble() * (maxY - 2 * padding);
    return Offset(dx.clamp(padding, maxX - padding), dy.clamp(padding, maxY - padding));
  }

  // Schedule the next teleport jump for an icon
  void _scheduleNextTeleport(int iconIndex) {
    if (!mounted) return;

    final random = Random();
    // Wait between 3 and 6 seconds before the next teleport
    final delay = Duration(milliseconds: 3000 + random.nextInt(3000));

    if (iconIndex == 1) {
      _icon1TeleportTimer?.cancel(); // Cancel previous timer if any
      _icon1TeleportTimer = Timer(delay, () => _teleportIcon(1));
    } else {
      _icon2TeleportTimer?.cancel();
      _icon2TeleportTimer = Timer(delay, () => _teleportIcon(2));
    }
  }

  // Perform the teleport (scale out, move, scale in)
  void _teleportIcon(int iconIndex) {
    if (!mounted || _bounds == Size.zero) return;

    final controller = (iconIndex == 1) ? _icon1EffectController : _icon2EffectController;
    final newPosition = _getRandomOffset(_bounds, _iconSize);

    // Listener for scale-out completion
    void scaleOutListener(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return; // Check mount status again

        // Update position state *after* scaling out
        setState(() {
          if (iconIndex == 1) {
            _icon1Position = newPosition;
          } else {
            _icon2Position = newPosition;
          }
        });

        // Remove this listener
        controller.removeStatusListener(scaleOutListener);

        // Add listener for scale-in completion
        void scaleInListener(AnimationStatus status) {
          if (status == AnimationStatus.dismissed) {
            // Scale-in finishes when reversed to start
            if (!mounted) return;
            controller.removeStatusListener(scaleInListener);
            // Schedule the *next* teleport after scale-in is done
            _scheduleNextTeleport(iconIndex);
          }
        }

        controller.addStatusListener(scaleInListener);

        // Start scale-in animation
        controller.reverse(from: 1.0);
      }
    }

    // Add the scale-out listener and start the scale-out animation
    controller.addStatusListener(scaleOutListener);
    controller.forward(from: 0.0);
  }

  // --- End Floating Icon Teleport Logic ---

  // Helper method for floating icons - Optimized responsive version
  Widget _buildFloatingIcon({
    required Widget image,
    required Offset position,
    required AnimationController effectController,
    required double size,
  }) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine screen size category
          final bool isMobile = constraints.maxWidth < 600;
          final bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1200;

          // Calculate responsive sizes using screen percentage
          final double containerSize =
              isMobile
                  ? size *
                      0.6 // 60% on mobile
                  : isTablet
                  ? size *
                      0.8 // 80% on tablet
                  : size; // Full size on desktop

          // Responsive border width
          final double borderWidth =
              isMobile
                  ? 1.0.w
                  : isTablet
                  ? 1.2.w
                  : 1.5.w;

          // Responsive shadow
          final double shadowBlur =
              isMobile
                  ? 6.0
                  : isTablet
                  ? 8.0
                  : 12.0;

          return Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  color: V2Colors.primary.withOpacity(0.9),
                  shape: BoxShape.circle,
                  border: Border.all(color: V2Colors.secondary, width: borderWidth),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: shadowBlur,
                      offset: Offset(0, shadowBlur / 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(containerSize * 0.15), // 15% padding
                child: FittedBox(child: image),
              )
              .animate(controller: effectController, autoPlay: false)
              .scale(begin: const Offset(1, 1), end: const Offset(0, 0), curve: Curves.easeIn)
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.05, 1.05),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Update bounds if screen size changes
    final currentBounds = MediaQuery.of(context).size;
    if (_bounds != currentBounds && currentBounds != Size.zero) {
      // Use addPostFrameCallback to avoid setting state during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _bounds = currentBounds;
            // Optionally, you could force a reposition if bounds change drastically
            // _icon1Position = _getRandomOffset(_bounds, _iconSize);
            // _icon2Position = _getRandomOffset(_bounds, _iconSize);
          });
        }
      });
    }
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
          // Floating Icons - Updated for Teleport
          // Build icons once their positions are initialized
          if (_bounds != Size.zero) ...[
            // Ensure bounds are calculated
            _buildFloatingIcon(
              image: Image.asset("assets/icons/flutter.png"),
              position: _icon1Position,
              effectController: _icon1EffectController,
              size: _iconSize,
            ),
            _buildFloatingIcon(
              image: Image.asset("assets/icons/unity.png", color: Colors.white),
              position: _icon2Position,
              effectController: _icon2EffectController,
              size: _iconSize,
            ),
          ],
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
                      Stack(
                        children: [
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
                                  const tabletBreakpoint = 768;
                                  const desktopBreakpoint = 992;
                                  bool isDesktop = constraints.maxWidth > desktopBreakpoint;
                                  bool isTablet =
                                      constraints.maxWidth > tabletBreakpoint && !isDesktop;
                                  CrossAxisAlignment textAlignment =
                                      isDesktop
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.center;
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
                                        AutoSizeText(
                                              'Ali Haydar AYAR',
                                              textAlign:
                                                  isDesktop ? TextAlign.start : TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.displayMedium?.copyWith(
                                                fontFamily: V2Fonts.heading,
                                                fontSize:
                                                    isDesktop
                                                        ? 64.sp
                                                        : isTablet
                                                        ? 56.sp
                                                        : 44.sp,
                                                fontWeight: FontWeight.bold,
                                                color: V2Colors.text,
                                              ),
                                              minFontSize: 10, // Added minFontSize
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
                                        AutoSizeText(
                                              'Software Developer',
                                              textAlign:
                                                  isDesktop ? TextAlign.start : TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.headlineMedium?.copyWith(
                                                fontFamily: V2Fonts.heading,
                                                fontSize:
                                                    isDesktop
                                                        ? 40.sp
                                                        : isTablet
                                                        ? 36.sp
                                                        : 30.sp,
                                                color: V2Colors.secondary,
                                              ),
                                              minFontSize: 10, // Added minFontSize
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
                                        AutoSizeText(
                                              _currentSubtitle,
                                              key: ValueKey(_subtitleIndex),
                                              textAlign:
                                                  isDesktop ? TextAlign.start : TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge?.copyWith(
                                                fontSize:
                                                    isDesktop
                                                        ? 20.sp
                                                        : isTablet
                                                        ? 19.sp
                                                        : 18.sp,
                                                color: V2Colors.textMuted,
                                                height: 1.4,
                                              ),
                                              minFontSize: 10, // Added minFontSize
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
                                                direction:
                                                    isDesktop ? Axis.horizontal : Axis.vertical,
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
                                                    child: const AutoSizeText(
                                                      'View Projects',
                                                      minFontSize: 10,
                                                    ), // Converted and added minFontSize
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
                                                    child: const AutoSizeText(
                                                      'Get in Touch',
                                                      minFontSize: 10,
                                                    ), // Converted and added minFontSize
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
                                    child: SizedBox(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Profile Image
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: V2Colors.secondary,
                                                width: isDesktop ? 4.w : 6.w,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.3),
                                                  blurRadius: 24,
                                                  offset: const Offset(0, 12),
                                                ),
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                'assets/profileImage.png',
                                              ),
                                              radius: isDesktop ? 0.1.sw : 0.15.sw,
                                            ),
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
                                            ? [
                                              Expanded(child: heroImage),
                                              Expanded(child: heroText),
                                            ]
                                            : [heroImage, SizedBox(height: 30.h), heroText],
                                  );
                                },
                              ),
                            ),
                          ),
                          // Scroll Indicator
                          Positioned(
                            bottom: 40.h,
                            left: 0,
                            right: 0,
                            child: AnimatedScrollIndicator(scrollController: _scrollController),
                          ),
                        ],
                      ), // Close Hero Section Stack
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
          MobileNavOverlay(
            isVisible: _isMobileNavVisible,
            onClose: _toggleMobileNav,
            scrollController: _scrollController,
            aboutKey: aboutKey,
            resumeKey: resumeKey,
            projectsKey: projectsKey,
            activityKey: activityKey,
            contactKey: contactKey,
          ),
          // Back To Top Button - On top of everything
          BackToTopButton(scrollController: _scrollController),
        ],
      ),
    );
  }
}
