import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    Key? key,
    required this.color,
    this.isActive = false,
  }) : super(key: key);

  final Color color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 16,
      child: CircleAvatar(
        radius: 13,
        backgroundColor: Colors.white.withOpacity(0.9),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: isActive ? color : color.withAlpha(1),
        ),
      ),
    );
  }
}
