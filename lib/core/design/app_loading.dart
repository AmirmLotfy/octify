import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final Color? color;
  final double strokeWidth;

  const AppLoading({super.key, this.color, this.strokeWidth=4});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color,
      ),
    );
  }
}
