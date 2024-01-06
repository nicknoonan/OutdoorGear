// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'gear/GearGallery.dart';
import 'loadout/GearLoadoutGallery.dart';
import 'home/HomeGallery.dart';

enum GalleryViewType { Home, Gear, Loadout }

class GalleryView {
  final String text;
  final IconData iconData;
  final IconData selectedIconData;
  final Widget child;
  final GalleryViewType viewType;
  const GalleryView({required this.text, required this.iconData, required this.selectedIconData, required this.child, required this.viewType});
}

class GalleryViews {
  static List<GalleryView> views = [HomeGallery.view, GearGallery.view, GearLoadoutGallery.view];
}
