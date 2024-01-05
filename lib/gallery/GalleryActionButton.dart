import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../model/GalleryModel.dart';
//import '../model/GearModel.dart';
import '../model/GearModel.dart';
import 'gear/GearCard.dart';
import 'gear/GearGallery.dart';

class GalleryActionButton extends StatelessWidget {
  const GalleryActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<GalleryModel, GearModel>(builder: (context, galleryContext, gearContext, child) {
      Widget button = FloatingActionButton(
          onPressed: () {
            galleryContext.registerOverlay(context, galleryContext.actionButtonHandler!);
          },
          shape: Constants.roundedRectanlgeBorder,
          child: const Icon(Icons.add));
      return galleryContext.view.actionButtonHandler == null || galleryContext.actionView || !gearContext.gearLoaded
          ? const SizedBox()
          : button;
    });
  }
}
