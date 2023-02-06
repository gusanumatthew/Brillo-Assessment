import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final Widget child;
  const AppDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: child,
    );
  }
}
