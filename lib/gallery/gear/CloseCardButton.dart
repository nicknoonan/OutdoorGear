import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/GearGallery.dart';
import 'package:outdoor_gear/model/GalleryModel.dart';

class CloseCardButton extends StatelessWidget {
  final GearCardType cardType;
  final GalleryModel galleryContext;

  const CloseCardButton({super.key, required this.cardType, required this.galleryContext});

  @override
  Widget build(BuildContext context) {
    //close card button
    Widget closeCardButton = cardType == GearCardType.overlay
        ? CloseButton(onPressed: () {
            galleryContext.unregisterOverlay();
          })
        : const SizedBox();

    return closeCardButton;
  }
}
