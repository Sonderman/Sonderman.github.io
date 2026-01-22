import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import AutoSizeText
import 'package:myportfolio/v2/theme/v2_theme.dart'; // Import theme
import 'package:get/get.dart'; // Import GetX for state management
import 'package:myportfolio/controllers/version_controller.dart'; // Import VersionController

// Convert NavMenu to StatefulWidget to manage hover state
class NavMenu extends StatefulWidget {
  final VoidCallback? onMenuPressed; // Callback for mobile menu toggle
  final bool isMobileMenuOpen; // State for hamburger animation
  final bool isScrolled; // Flag for sticky state
  // Add GlobalKeys for scrolling
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey resumeKey;
  final GlobalKey projectsKey;
  final GlobalKey activityKey;
  final GlobalKey contactKey;
  final ScrollController scrollController; // Add ScrollController

  const NavMenu({
    super.key,
    this.onMenuPressed,
    this.isMobileMenuOpen = false, // Default to closed
    this.isScrolled = false, // Default to not scrolled
    required this.homeKey,
    required this.aboutKey,
    required this.resumeKey,
    required this.projectsKey,
    required this.activityKey,
    required this.contactKey,
    required this.scrollController, // Add to constructor
  });

  @override
  State<NavMenu> createState() => _NavMenuState();
}

// State class for NavMenu
class _NavMenuState extends State<NavMenu> {
  // State variable to track hover on the "WELCOME" text
  bool _isWelcomeHovered = false;

  // Removed duplicate @override
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        // Wrap with ClipRect and BackdropFilter for blur effect
        return ClipRect(
          // Required for BackdropFilter
          child: BackdropFilter(
            filter: ImageFilter.blur(
              // Apply blur only when scrolled (use widget property)
              sigmaX: widget.isScrolled ? 5.0 : 0.0,
              sigmaY: widget.isScrolled ? 5.0 : 0.0,
            ),
            child: AnimatedContainer(
              // Animate container properties based on scroll state
              duration: 300.ms, // Match CSS transition
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                // Adjust padding when scrolled (use widget property)
                vertical: widget.isScrolled ? 10.h : 16.h,
              ),
              decoration: BoxDecoration(
                // Use theme overlay color, adjust opacity based on scroll (use widget property)
                color: V2Colors.overlay.withOpacity(widget.isScrolled ? 1.0 : 0.7),
                boxShadow:
                    widget.isScrolled
                        ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Match CSS shadow
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ]
                        : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo (First child of the Row)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _isWelcomeHovered = true),
                    onExit: (_) => setState(() => _isWelcomeHovered = false),
                    child: GestureDetector(
                      onTap: () => _scrollToSection(widget.homeKey),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        child: AnimatedDefaultTextStyle(
                          duration: 200.ms,
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,

                            color: _isWelcomeHovered ? Colors.amber.shade300 : Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const AutoSizeText('WELCOME', minFontSize: 16),
                              SizedBox(width: 12.w),
                              // Reactive switch to toggle version
                              Obx(() {
                                final version = Get.find<VersionController>().currentVersion;
                                final isV1 = version.value == "v1";
                                return Row(
                                  children: [
                                    Text(
                                      "Switch to Old Version",
                                      style: TextStyle(
                                        // Increase font size on mobile devices for better readability
                                        fontSize: isMobile ? 60.sp : 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Switch(
                                      value: isV1,
                                      onChanged: (value) async {
                                        final newVersion = value ? "v1" : "v2";
                                        // Delay the version switch until after the switch animation completes (~300ms)
                                        Future.delayed(Duration(milliseconds: 300)).then((_) {
                                          // Switches version and resets navigation stack to simulate full restart
                                          Get.find<VersionController>().switchVersionAndRestart(
                                            newVersion,
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Navigation Widget (Second child of the Row)
                  // Use the ternary operator correctly here
                  isMobile
                      ? GestureDetector(
                        // Mobile View
                        onTap: widget.onMenuPressed,
                        child: AnimatedSwitcher(
                          duration: 300.ms,
                          transitionBuilder: (child, animation) {
                            return RotationTransition(turns: animation, child: child);
                          },
                          child:
                              widget.isMobileMenuOpen
                                  ? Icon(
                                    Icons.close,
                                    key: const ValueKey('close'),
                                    color: V2Colors.text,
                                    size: 100.sp,
                                  )
                                  : Icon(
                                    Icons.menu,
                                    key: const ValueKey('menu'),
                                    color: V2Colors.text,
                                    size: 100.sp,
                                  ),
                        ),
                      )
                      : Row(
                        // Desktop View
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavItem(
                            title: 'About',
                            sectionKey: widget.aboutKey,
                            scrollController: widget.scrollController,
                          ),
                          NavItem(
                            title: 'Resume',
                            sectionKey: widget.resumeKey,
                            scrollController: widget.scrollController,
                          ),
                          NavItem(
                            title: 'Projects',
                            sectionKey: widget.projectsKey,
                            scrollController: widget.scrollController,
                          ),
                          NavItem(
                            title: 'Activity',
                            sectionKey: widget.activityKey,
                            scrollController: widget.scrollController,
                          ),
                          _ContactNavButton(
                            sectionKey: widget.contactKey,
                            scrollToSection: _scrollToSection,
                          ),
                        ],
                      ),
                ], // End of main Row's children list
              ),
            ), // Close AnimatedContainer
          ), // Close BackdropFilter
        ); // Close ClipRect
      }, // Close LayoutBuilder builder
    ); // Close LayoutBuilder
  }

  // Removed _buildContactButton helper method, replaced by _ContactNavButton widget below

  // Helper function to scroll to a section
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500), // Adjust duration as needed
        curve: Curves.easeInOut, // Adjust curve as needed
        alignment: 0.0, // Align to the top
      );
    }
  }
} // End of _NavMenuState class

class NavItem extends StatefulWidget {
  final String title;
  final GlobalKey sectionKey;
  final ScrollController scrollController; // Add ScrollController

  const NavItem({
    super.key,
    required this.title,
    required this.sectionKey,
    required this.scrollController, // Add to constructor
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _isHovered = false;
  bool _isActive = false; // State for active link

  // Thresholds for determining active state (adjust as needed)
  static const double _activeThresholdTop = 100.0; // Pixels from top edge to consider active
  static const double _activeThresholdBottomFactor =
      0.5; // Consider active if top is above 50% of screen height

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
    // Initial check in case the page loads scrolled to a section
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
  }

  @override
  void dispose() {
    // Check if controller still has listeners before removing, prevents error if controller is disposed elsewhere
    if (widget.scrollController.hasListeners) {
      try {
        widget.scrollController.removeListener(_scrollListener);
      } catch (e) {
        // Handle potential errors if listener was already removed
        debugPrint("Error removing NavItem listener: $e");
      }
    }
    super.dispose();
  }

  void _scrollListener() {
    if (!mounted) return;

    final sectionContext = widget.sectionKey.currentContext;
    if (sectionContext == null) return;

    final RenderBox? sectionBox = sectionContext.findRenderObject() as RenderBox?;
    if (sectionBox == null) return;

    // Get the global position of the section
    final sectionPosition = sectionBox.localToGlobal(Offset.zero);
    final sectionHeight = sectionBox.size.height;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate visibility thresholds relative to the viewport
    final double topVisibleThreshold = _activeThresholdTop;
    final double bottomVisibleThreshold =
        screenHeight * (1.0 - _activeThresholdBottomFactor); // e.g., bottom 50%

    // Determine if the section is "active"
    // Active if the top of the section is above the bottom threshold
    // AND the bottom of the section is below the top threshold
    final bool currentlyActive =
        (sectionPosition.dy < bottomVisibleThreshold) &&
        (sectionPosition.dy + sectionHeight > topVisibleThreshold);

    if (currentlyActive != _isActive) {
      setState(() {
        _isActive = currentlyActive;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the _isActive state variable
    final bool isActive = _isActive;

    return GestureDetector(
      onTap: () {
        final context = widget.sectionKey.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignment: 0.0, // Align to top
          );
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child:
            Column(
              // Wrap content and underline in a Column
              mainAxisSize: MainAxisSize.min, // Keep column height tight
              children: [
                // Original content (Text with padding/margin)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: AutoSizeText(
                    widget.title,
                    style: TextStyle(
                      fontSize: 26.sp,
                      color:
                          isActive
                              ? V2Colors
                                  .secondary // Active color
                              : _isHovered
                              ? V2Colors.secondary.withOpacity(0.8) // Hover color
                              : V2Colors.text, // Default color
                    ),
                    minFontSize: 10, // Moved minFontSize here
                  ),
                ),
                // Animated Underline
                AnimatedContainer(
                  duration: 300.ms, // Match original CSS transition
                  height: 2.0, // Underline thickness
                  width:
                      _isHovered || isActive
                          ? 40.w
                          : 0, // Animate width based on hover/active (adjust width)
                  color: V2Colors.secondary,
                  curve: Curves.easeOut, // Animation curve
                ),
              ],
            ).animate().fadeIn(), // Apply fade-in to the whole column
      ),
    );
  }
}
// --- New StatefulWidget for Contact Nav Button with Hover Effect ---

class _ContactNavButton extends StatefulWidget {
  final GlobalKey sectionKey;
  final void Function(GlobalKey) scrollToSection; // Function to trigger scroll

  const _ContactNavButton({required this.sectionKey, required this.scrollToSection});

  @override
  State<_ContactNavButton> createState() => _ContactNavButtonState();
}

class _ContactNavButtonState extends State<_ContactNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const title = 'Contact';
    // Define hover color (e.g., slightly darker secondary)
    final hoverColor = Color.lerp(V2Colors.secondary, Colors.black, 0.15);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.scrollToSection(widget.sectionKey),
        child: AnimatedContainer(
          duration: 200.ms, // Hover animation duration
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: _isHovered ? hoverColor : V2Colors.secondary, // Animate color
            borderRadius: BorderRadius.circular(V2Theme.borderRadiusMd),
            boxShadow: _isHovered ? [V2Theme.shadowSm] : [], // Optional shadow
          ),
          child: AutoSizeText(
            title,
            style: TextStyle(
              fontFamily: V2Fonts.heading,
              fontSize: 30.sp,
              fontWeight: FontWeight.w500,
              color: V2Colors.primary, // Text color remains the same
            ),
            minFontSize: 10, // Moved minFontSize here
          ),
        ),
      ),
    );
  }
}
