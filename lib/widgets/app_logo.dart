import 'package:flutter/material.dart';

/// Splash logo: blue gradient circle with a pill and two dots.
/// Drawn in code so you don't need the SVG asset. Swap with SvgPicture later if you want.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 131});

  final double size;

  @override
  Widget build(BuildContext context) {
    final s = size / 131; // scale factor relative to the Figma size
    const soft = Color(0x99FFFFFF);

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6AA1FF), Color(0xFF0560FD)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 22 * s,
            top: 67 * s,
            child: Transform.rotate(
              angle: 0.785398, // 45 degrees
              child: Container(
                width: 50 * s,
                height: 14 * s,
                decoration: BoxDecoration(
                  color: soft,
                  borderRadius: BorderRadius.circular(7 * s),
                ),
              ),
            ),
          ),
          Positioned(
            left: 68 * s,
            top: 63 * s,
            child: Container(
              width: 18 * s,
              height: 18 * s,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 84.5 * s,
            top: 47.5 * s,
            child: Container(
              width: 17 * s,
              height: 17 * s,
              decoration: const BoxDecoration(
                color: soft,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
