import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';


class PerfectShadow extends StatelessWidget {
  const PerfectShadow({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.5,
      color: Colors.grey,
      offset: const Offset(0, 0),
      sigma: 4,
      child: child,
    );
  }
}
