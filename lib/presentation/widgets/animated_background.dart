import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../core/theme/app_theme.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;
  final AnimationController controller;

  const AnimatedBackground({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.backgroundGradient,
          ),
        ),
        
        // Animated particles
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return CustomPaint(
              painter: ParticlesPainter(
                animationValue: controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // Floating geometric shapes
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return CustomPaint(
              painter: GeometricShapesPainter(
                animationValue: controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // Content overlay
        child,
      ],
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final double animationValue;
  final List<Particle> particles;

  ParticlesPainter({required this.animationValue})
      : particles = List.generate(50, (index) => Particle(index));

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final x = particle.x * size.width;
      final y = (particle.y + animationValue * particle.speed) % 1.0 * size.height;
      final radius = particle.size * (0.5 + 0.5 * math.sin(animationValue * 2 * math.pi + particle.phase));

      paint.color = particle.color.withOpacity(0.05 + 0.1 * math.sin(animationValue * 2 * math.pi + particle.phase));
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class GeometricShapesPainter extends CustomPainter {
  final double animationValue;

  GeometricShapesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Floating hexagons
    _drawFloatingHexagon(canvas, size, paint, 0.2, 0.3, 50, 0);
    _drawFloatingHexagon(canvas, size, paint, 0.8, 0.6, 40, math.pi / 3);
    _drawFloatingHexagon(canvas, size, paint, 0.1, 0.8, 30, math.pi / 6);

    // Floating triangles
    _drawFloatingTriangle(canvas, size, paint, 0.9, 0.2, 25, 0);
    _drawFloatingTriangle(canvas, size, paint, 0.3, 0.9, 35, math.pi / 4);
  }

  void _drawFloatingHexagon(Canvas canvas, Size size, Paint paint, double relativeX, double relativeY, double radius, double rotationOffset) {
    final center = Offset(relativeX * size.width, relativeY * size.height);
    final rotation = animationValue * 2 * math.pi + rotationOffset;
    
    paint.color = AppTheme.secondaryColor.withOpacity(0.1);
    
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = rotation + i * math.pi / 3;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    
    canvas.drawPath(path, paint);
  }

  void _drawFloatingTriangle(Canvas canvas, Size size, Paint paint, double relativeX, double relativeY, double radius, double rotationOffset) {
    final center = Offset(relativeX * size.width, relativeY * size.height);
    final rotation = -animationValue * 2 * math.pi + rotationOffset;
    
    paint.color = AppTheme.primaryColor.withOpacity(0.08);
    
    final path = Path();
    for (int i = 0; i < 3; i++) {
      final angle = rotation + i * 2 * math.pi / 3;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(GeometricShapesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double phase;
  final Color color;

  Particle(int index)
      : x = math.Random(index).nextDouble(),
        y = math.Random(index * 2).nextDouble(),
        size = 2 + math.Random(index * 3).nextDouble() * 8,
        speed = 0.1 + math.Random(index * 4).nextDouble() * 0.3,
        phase = math.Random(index * 5).nextDouble() * 2 * math.pi,
        color = [
          AppTheme.primaryColor,
          AppTheme.secondaryColor,
          AppTheme.infoColor,
        ][math.Random(index * 6).nextInt(3)];
}