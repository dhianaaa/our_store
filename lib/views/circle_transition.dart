import 'dart:math';
import 'package:flutter/material.dart';

Route circleRevealRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 900),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return ClipPath(
            clipper: CircleRevealClipper(animation.value),
            child: child,
          );
        },
      );
    },
  );
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double progress;

  CircleRevealClipper(this.progress);

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius =
        sqrt(size.width * size.width + size.height * size.height);

    final radius = maxRadius * progress;

    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) =>
      oldClipper.progress != progress;
}
