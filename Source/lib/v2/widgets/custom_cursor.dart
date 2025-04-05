import 'package:flutter/foundation.dart'; // For kIsWeb and defaultTargetPlatform
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart'; // Import theme

class CustomCursor extends StatefulWidget {
  final Widget child; // The main app content

  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _position = Offset.zero;
  bool _isHoveringWindow = false; // Track if mouse is inside the window
  bool _showCursor = false; // Control overall visibility

  // TODO: Implement global state for hover effect (e.g., using GetX or Provider)
  // bool _isHoveringInteractive = false;
  // Color _outlineColor = AppColors.secondary;
  // double _outlineSize = 40.w;

  @override
  void initState() {
    super.initState();
    // Determine if we should show the custom cursor
    _showCursor =
        kIsWeb && // Only on web
        ![TargetPlatform.iOS, TargetPlatform.android] // Exclude touch platforms
        .contains(defaultTargetPlatform);
  }

  void _updatePosition(PointerEvent event) {
    if (mounted) {
      setState(() {
        _position = event.position;
      });
    }
  }

  void _onMouseEnter(PointerEvent event) {
    if (mounted) {
      setState(() {
        _isHoveringWindow = true;
        _position = event.position; // Update position immediately on enter
      });
    }
  }

  void _onMouseExit(PointerEvent event) {
    if (mounted) {
      setState(() {
        _isHoveringWindow = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_showCursor) {
      // If not showing custom cursor, just return the child
      return widget.child;
    }

    // Use ScreenUtil context if available, otherwise fallback
    final screenWidth = ScreenUtil().screenWidth;
    final screenHeight = ScreenUtil().screenHeight;

    // Calculate cursor sizes based on original CSS (8px dot, 40px outline)
    // Using .w for potentially responsive sizing, adjust if needed
    final double dotSize = 8.w;
    final double outlineSize = 40.w; // TODO: Animate this based on hover state

    return MouseRegion(
      cursor: SystemMouseCursors.none, // Hide the default system cursor
      onHover: _updatePosition,
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      child: Stack(
        children: [
          // Main application content
          widget.child,

          // Cursor Dot
          AnimatedPositioned(
            duration: 50.ms, // Faster movement for the dot
            curve: Curves.linear,
            left: _position.dx - (dotSize / 2),
            top: _position.dy - (dotSize / 2),
            child: AnimatedOpacity(
              duration: 300.ms,
              opacity: _isHoveringWindow ? 1.0 : 0.0,
              child: IgnorePointer(
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: const BoxDecoration(
                    color: V2Colors.secondary, // Use theme color
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          // Cursor Outline
          AnimatedPositioned(
            duration: 150.ms, // Slightly slower for smoother outline follow
            curve: Curves.easeOut,
            left: _position.dx - (outlineSize / 2),
            top: _position.dy - (outlineSize / 2),
            child: AnimatedOpacity(
              duration: 300.ms,
              opacity: _isHoveringWindow ? 1.0 : 0.0,
              child: IgnorePointer(
                child: AnimatedContainer(
                  // TODO: Animate size and color based on hover state
                  duration: 200.ms,
                  width: outlineSize,
                  height: outlineSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: V2Colors.secondary, // TODO: Change color on hover
                      width: 2.w,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
