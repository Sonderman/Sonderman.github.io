import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myportfolio/v2/theme/v2_theme.dart'; // For default color

class Particle {
  double x;
  double y;
  double radius;
  Color color;
  double vx;
  double vy;
  double initialOpacity;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.vx,
    required this.vy,
    required this.opacity,
  }) : initialOpacity = opacity;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Animation<double> animation;
  final Color connectionColor;
  final double connectionDistance;

  ParticlePainter({
    required this.particles,
    required this.animation,
    this.connectionColor = Colors.white, // Default connection color
    this.connectionDistance = 100.0, // Default connection distance
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Update and draw particles
    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];

      // Update position (simple linear motion)
      p.x += p.vx;
      p.y += p.vy;

      // Wrap around edges
      if (p.x < -p.radius) p.x = size.width + p.radius;
      if (p.x > size.width + p.radius) p.x = -p.radius;
      if (p.y < -p.radius) p.y = size.height + p.radius;
      if (p.y > size.height + p.radius) p.y = -p.radius;

      // Draw particle
      paint.color = p.color.withOpacity(p.opacity);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);

      // Draw connections
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final dx = p.x - p2.x;
        final dy = p.y - p2.y;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < connectionDistance) {
          final opacity =
              (1.0 - distance / connectionDistance) * 0.1; // Match original JS opacity logic
          if (opacity > 0) {
            paint.color = connectionColor.withOpacity(opacity);
            paint.strokeWidth = 1.0;
            canvas.drawLine(Offset(p.x, p.y), Offset(p2.x, p2.y), paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    // Repaint is driven by the animation listener
    return false;
  }
}

// Helper to get random colors similar to the original JS
Color getRandomParticleColor() {
  final List<Color> colors = [
    V2Colors.secondary, // #ffd700
    V2Colors.accent1, // #00b4d8
    V2Colors.accent2, // #7209b7
    V2Colors.text, // #f8f9fa
  ];
  return colors[Random().nextInt(colors.length)];
}
