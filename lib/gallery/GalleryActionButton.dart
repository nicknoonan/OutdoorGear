import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/GalleryView.dart';
import 'package:outdoor_gear/gallery/gear/AddGearCardOverlay.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../model/GalleryModel.dart';
//import '../model/GearModel.dart';
import '../model/GearModel.dart';
import 'gear/GearCard.dart';
import 'gear/GearGallery.dart';

class GalleryActionButton extends StatelessWidget {
  const GalleryActionButton({super.key});

  void resolveHandler(BuildContext context, GalleryModel galleryContext, GearModel gearContext) {
    switch (galleryContext.view.viewType) {
      case GalleryViewType.Home:
        {}
      case GalleryViewType.Gear:
        {
          galleryContext.registerOverlay(
              context, AddGearCardOverlay(galleryContext: galleryContext, gearContext: gearContext));
        }
      case GalleryViewType.Loadout:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GalleryModel, GearModel>(builder: (context, galleryContext, gearContext, child) {
      Widget button = FloatingActionButton(
          onPressed: () => resolveHandler(context, galleryContext, gearContext),
          shape: Constants.roundedRectanlgeBorder,
          child: const Icon(Icons.add));
      return [GalleryViewType.Home, GalleryViewType.Loadout].contains(galleryContext.view.viewType) || galleryContext.actionView || !gearContext.gearLoaded
          ? const SizedBox()
          : button;
    });
  }
}
