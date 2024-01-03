import 'package:flutter/material.dart';

class Constants {
  static final colorScheme = ColorScheme.fromSeed(seedColor: Colors.purple, brightness: Brightness.dark);
  static const borderRadiusSize = 10.0;
  static const borderRadius = BorderRadius.all(Radius.circular(borderRadiusSize));
  static const roundedRectanlgeBorder = RoundedRectangleBorder(borderRadius: borderRadius);
}
