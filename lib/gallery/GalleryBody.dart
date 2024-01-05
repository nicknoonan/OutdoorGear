import 'package:flutter/material.dart';

class GalleryBody extends StatelessWidget {
  final Widget child;
  const GalleryBody({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(constraints: const BoxConstraints.expand(), child: child));
  }
}
