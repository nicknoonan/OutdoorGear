// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'gear/GearGallery.dart';
import 'GearLoadoutGallery.dart';
import 'HomeGallery.dart';

class GalleryView {
  final String text;
  final IconData iconData;
  final IconData selectedIconData;
  final Widget child;
  final Widget? actionButtonHandler;
  const GalleryView(this.text, this.iconData, this.selectedIconData, this.child, this.actionButtonHandler);
}

class GalleryViews {
  static List<GalleryView> views = [HomeGallery.view, GearGallery.view, GearLoadoutGallery.view];
}



