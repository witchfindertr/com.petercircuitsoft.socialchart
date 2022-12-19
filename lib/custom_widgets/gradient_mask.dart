import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.pinkAccent, Colors.deepPurpleAccent, Colors.red],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: (Theme.of(context).brightness == Brightness.light)
            ? [
                Color.fromRGBO(0xab, 0x4e, 0x86, 1),
                Color.fromRGBO(0x31, 0x2f, 0xa5, 1),
                Color.fromRGBO(0x96, 0x0b, 0xd8, 1),
              ]
            : [
                Color.fromRGBO(0x7c, 0x99, 0xfc, 1),
                Color.fromRGBO(0xc5, 0xdd, 0x58, 1),
                Color.fromRGBO(0xeb, 0x41, 0xb8, 1),
              ], //logoColor: ["#7c99fc", "#c5dd58", "#eb41b8"],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
