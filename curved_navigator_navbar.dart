import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AnimatedDrawIcon extends StatefulWidget {
  final ui.Path iconPath;
  final bool isSelected;
  final double size;
  final Color color;
  final Duration duration;

  const AnimatedDrawIcon({
    super.key,
    required this.iconPath,
    required this.isSelected,
    this.size = 28,
    required this.color,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<AnimatedDrawIcon> createState() => _AnimatedDrawIconState();
}

class _AnimatedDrawIconState extends State<AnimatedDrawIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    if (widget.isSelected) controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedDrawIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected) {
      controller.forward(from: 0);
    } else {
      controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _DrawPainter(
            progress: widget.isSelected ? controller.value : 1.0,
            iconPath: widget.iconPath,
            color: widget.color,
          ),
          size: Size(widget.size, widget.size),
        );
      },
    );
  }
}

class _DrawPainter extends CustomPainter {
  final double progress;
  final ui.Path iconPath;
  final Color color;

  _DrawPainter({
    required this.progress,
    required this.iconPath,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final PathMetrics pms = iconPath.computeMetrics();
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = color
      ..strokeCap = StrokeCap.round;

    for (var pm in pms) {
      final extract = pm.extractPath(
        0,
        pm.length * progress,
      );
      canvas.drawPath(extract, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DrawPainter oldDelegate) => true;
}
