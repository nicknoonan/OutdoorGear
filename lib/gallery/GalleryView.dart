// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/GalleryModel.dart';
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
  static List<GalleryView> views = [HomeGallery.view(), GearGallery.view(), GearLoadoutGallery.view()];
}

class GalleryBody extends StatelessWidget {
  const GalleryBody({super.key});
  // Container(
  //   foregroundDecoration: BoxDecoration(
  //     color: Colors.grey,
  //     backgroundBlendMode: BlendMode.saturation,
  //   ),
  //   child: child,
  // )
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryModel>(builder: (context, gallery, child) {
      return Expanded(
          child: Container(
              constraints: const BoxConstraints.expand(),
              child: gallery.view.child));
    });
  }
}

