import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myportfolio/v2/theme/app_theme.dart'; // Import theme

class NavMenu extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        // Wrap with ClipRect and BackdropFilter for blur effect
        return ClipRect(
          // Required for BackdropFilter
          child: BackdropFilter(
            filter: ImageFilter.blur(
              // Apply blur only when scrolled
              sigmaX: isScrolled ? 5.0 : 0.0,
              sigmaY: isScrolled ? 5.0 : 0.0,
            ),
            child: AnimatedContainer(
              // Animate container properties based on scroll state
              duration: 300.ms, // Match CSS transition
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: isScrolled ? 10.h : 16.h, // Adjust padding when scrolled
              ),
              decoration: BoxDecoration(
                // Use theme overlay color, adjust opacity based on scroll
                color: AppColors.overlay.withOpacity(isScrolled ? 1.0 : 0.7),
                boxShadow:
                    isScrolled
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
                  // Logo
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _scrollToSection(homeKey), // Scroll to home section
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        child: Text(
                          'AH',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Navigation
                  if (isMobile)
                    // Use custom animated hamburger icon
                    GestureDetector(
                      onTap: onMenuPressed,
                      child: AnimatedSwitcher(
                        duration: 300.ms,
                        transitionBuilder: (child, animation) {
                          return RotationTransition(turns: animation, child: child);
                        },
                        child:
                            isMobileMenuOpen
                                ? Icon(
                                  Icons.close,
                                  key: const ValueKey('close'),
                                  color: AppColors.text,
                                  size: 28.sp,
                                )
                                : Icon(
                                  Icons.menu,
                                  key: const ValueKey('menu'),
                                  color: AppColors.text,
                                  size: 28.sp,
                                ),
                      ),
                    )
                  else
                    Row(
                      children: [
                        NavItem(
                          title: 'About',
                          sectionKey: aboutKey,
                          scrollController: scrollController,
                        ),
                        NavItem(
                          title: 'Resume',
                          sectionKey: resumeKey,
                          scrollController: scrollController,
                        ),
                        NavItem(
                          title: 'Projects',
                          sectionKey: projectsKey,
                          scrollController: scrollController,
                        ),
                        NavItem(
                          title: 'Activity',
                          sectionKey: activityKey,
                          scrollController: scrollController,
                        ),
                        // Special styling for Contact button
                        _ContactNavButton(
                          // Use the new StatefulWidget
                          sectionKey: contactKey,
                          scrollToSection: _scrollToSection, // Pass the scroll helper
                        ),
                      ],
                    ),
                ],
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
}

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
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color:
                          isActive
                              ? AppColors
                                  .secondary // Active color
                              : _isHovered
                              ? AppColors.secondary.withOpacity(0.8) // Hover color
                              : AppColors.text, // Default color
                    ),
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
                  color: AppColors.secondary,
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
    final hoverColor = Color.lerp(AppColors.secondary, Colors.black, 0.15);

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
            color: _isHovered ? hoverColor : AppColors.secondary, // Animate color
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
            boxShadow: _isHovered ? [AppTheme.shadowSm] : [], // Optional shadow
          ),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: AppFonts.heading,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary, // Text color remains the same
            ),
          ),
        ),
      ),
    );
  }
}
