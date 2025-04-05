import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myportfolio/v2/theme/app_theme.dart';

class BackToTopButton extends StatefulWidget {
  final ScrollController scrollController;

  const BackToTopButton({super.key, required this.scrollController});

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool _isVisible = false;
  bool _isHovered = false; // State for hover effect

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
    // Initial check in case the page loads scrolled down
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (!mounted) return;
    // Show button if scrolled down more than 300 (like original JS)
    final shouldBeVisible =
        widget.scrollController.hasClients && widget.scrollController.offset > 300;
    if (shouldBeVisible != _isVisible) {
      setState(() {
        _isVisible = shouldBeVisible;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: 500.ms, // Smooth scroll duration
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use AnimatedOpacity for fade effect and IgnorePointer to disable interaction when hidden
    return Positioned(
      bottom: 30.h, // Match CSS
      right: 30.w, // Match CSS
      child: IgnorePointer(
        ignoring: !_isVisible,
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: 300.ms, // Match CSS transition
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              // Animate container properties on hover
              duration: 200.ms, // Faster hover transition
              transform: Matrix4.translationValues(
                0,
                _isHovered ? -5.h : 0,
                0,
              ), // Translate Y on hover
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                // Animate background color
                backgroundColor:
                    _isHovered ? AppColors.accent1 : AppColors.secondary, // Change color on hover
                foregroundColor: AppColors.primary,
                mini: false,
                elevation: _isHovered ? 8 : 4, // Increase elevation slightly on hover
                tooltip: 'Back to Top',
                child: const Icon(Icons.arrow_upward),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
