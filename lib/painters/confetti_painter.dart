import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../enums/confetti_enums.dart';

/// Confetti particle and painter classes

class ConfettiParticle {
  Offset position; // normalized
  Offset velocity;
  Color color;
  double size;
  double rotationSpeed;
  String? emoji;
  double opacity; // 0..1
  double lifespan; // 0..1

  ConfettiParticle({
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
    required this.rotationSpeed,
    this.emoji,
    required this.opacity,
    required this.lifespan,
  });
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double animationValue;
  final double physicsValue;
  final ConfettiType confettiType;
  final ConfettiStyle confettiStyle;
  final AnimationConfetti animationStyle;
  final BlendMode? blendMode;

  ConfettiPainter({
    required this.particles,
    required this.animationValue,
    required this.physicsValue,
    required this.confettiType,
    required this.confettiStyle,
    required this.animationStyle,
    this.blendMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    if (blendMode != null) {
      paint.blendMode = blendMode!;
    }

    for (var particle in particles) {
      // Update posisi
      final dx = particle.velocity.dx * 0.01;
      final dy = particle.velocity.dy * 0.01;
      particle.position = Offset(
        particle.position.dx + dx,
        particle.position.dy + dy,
      );

      // Update rotasi (contoh, sekadar nambah)
      particle.rotationSpeed += 0.01;

      final px = particle.position.dx * size.width;
      final py = particle.position.dy * size.height;

      // transform
      canvas.save();
      canvas.translate(px, py);

      final angle = particle.rotationSpeed * math.pi / 180.0;
      canvas.rotate(angle);

      paint.color = particle.color.withOpacity(particle.opacity);

      switch (confettiStyle) {
        case ConfettiStyle.custom:
          canvas.drawCircle(Offset.zero, particle.size, paint);
          break;
        case ConfettiStyle.star:
          _drawStar(canvas, paint, particle.size, 5);
          break;
        case ConfettiStyle.emoji:
          final textSpan = TextSpan(
            text: particle.emoji ?? '🎉',
            style: TextStyle(fontSize: particle.size * 2),
          );
          final tp = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          )..layout();
          tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
          break;
        case ConfettiStyle.ribbons:
          final rect = Rect.fromCenter(
            center: Offset.zero,
            width: particle.size * 0.5,
            height: particle.size * 6,
          );
          canvas.drawRect(rect, paint);
          break;
        case ConfettiStyle.paper:
          final rect2 = Rect.fromCenter(
            center: Offset.zero,
            width: particle.size,
            height: particle.size,
          );
          canvas.drawRect(rect2, paint);
          break;
      }

      canvas.restore();
    }
  }

  void _drawStar(Canvas canvas, Paint paint, double radius, int points) {
    final path = Path();
    final angle = math.pi / points;

    for (int i = 0; i < 2 * points; i++) {
      final r = (i % 2) == 0 ? radius : radius / 2;
      final x = r * math.sin(i * angle);
      final y = -r * math.cos(i * angle);
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
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}
