import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScrollIndicator extends StatefulWidget {
  final ScrollController controller;

  const ScrollIndicator({super.key, required this.controller});

  @override
  State<ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<ScrollIndicator> {
  bool _visible = false;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateProgress);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    final newProgress =
        widget.controller.offset /
        (widget.controller.position.maxScrollExtent - widget.controller.position.minScrollExtent);
    setState(() {
      _progress = newProgress.clamp(0.0, 1.0);
      _visible = widget.controller.offset > 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: 300.ms,
      bottom: _visible ? 40.h : -60.h,
      right: 40.w,
      child: AnimatedOpacity(
        duration: 300.ms,
        opacity: _visible ? 1 : 0,
        child: Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber, width: 2.w),
          ),
          child: Center(
            child: Text(
              '${(_progress * 100).toInt()}%',
              style: TextStyle(fontSize: 14.sp, color: Colors.amber, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
