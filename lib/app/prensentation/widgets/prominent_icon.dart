import 'package:flutter/material.dart';

class ProminentIcon extends StatelessWidget {
  final Widget prominentIcon;
  const ProminentIcon({super.key, required this.prominentIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      width: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white.withOpacity(0.16),
      ),
      child: Center(child: prominentIcon),
    );
  }
}
