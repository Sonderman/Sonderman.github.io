import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'particle_painter.dart'; // Import the new painter

class ParticlesBackground extends StatefulWidget {
  final int particleCount;
  final Color connectionColor;
  final double connectionDistance;

  const ParticlesBackground({
    super.key,
    this.particleCount = 80, // Increased default to match original JS
    this.connectionColor = Colors.white,
    this.connectionDistance = 100.0,
  });

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  Size _size = Size.zero; // To store canvas size

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duration doesn't matter much here
    )..repeat(); // Repeat indefinitely to drive the painter updates

    _particles = [];
    // Initialize particles later in didChangeDependencies or LayoutBuilder
  }

  void _initializeParticles(Size size) {
    if (_particles.isNotEmpty && size == _size) return; // Avoid re-initialization

    _size = size;
    _particles = List.generate(widget.particleCount, (index) {
      return Particle(
        x: Random().nextDouble() * size.width,
        y: Random().nextDouble() * size.height,
        radius: 1.w + Random().nextDouble() * 2.w, // Adjusted size range
        color: getRandomParticleColor(),
        vx: (Random().nextDouble() - 0.5) * 0.5, // Match original JS velocity
        vy: (Random().nextDouble() - 0.5) * 0.5, // Match original JS velocity
        opacity: Random().nextDouble() * 0.5 + 0.1, // Match original JS opacity
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Initialize particles once layout is known
          _initializeParticles(constraints.biggest);

          return CustomPaint(
            size: constraints.biggest,
            painter: ParticlePainter(
              particles: _particles,
              animation: _controller,
              connectionColor: widget.connectionColor,
              connectionDistance: widget.connectionDistance,
            ),
          );
        },
      ),
    );
  }
}
