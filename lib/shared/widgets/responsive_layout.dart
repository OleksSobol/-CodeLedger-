import 'package:flutter/material.dart';

/// A wrapper that applies a maximum width to its child and centers it at the top.
/// Use this on wide screens to prevent content from stretching infinitely.
class ResponsiveAlign extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveAlign({
    super.key,
    required this.child,
    this.maxWidth = 960.0,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
