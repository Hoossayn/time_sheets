import 'package:flutter/material.dart';

class AppGlassContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const AppGlassContainer({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.16),
        ),
        child: child,
      ),
    );
  }
}
