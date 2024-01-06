import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/GearCard.dart';
import 'package:outdoor_gear/gallery/gear/GearGallery.dart';
import 'package:outdoor_gear/model/GalleryModel.dart';
import 'package:outdoor_gear/model/GearModel.dart';
import 'package:outdoor_gear/widgets/GrayedOut.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v8.dart';

class AddGearCardOverlay extends StatelessWidget {
  final GalleryModel galleryContext;
  final GearModel gearContext;

  const AddGearCardOverlay({super.key, required this.galleryContext, required this.gearContext});

  @override
  Widget build(BuildContext context) {
    Widget overlay = GearCard(
      editMode: true,
      cardType: GearCardType.overlay,
      galleryContext: galleryContext,
      gear: Gear(UuidValue.fromString(const UuidV8().generate()), '', '', 0.0, '', '', '', []),
      updateGear: (gear) {
        gearContext.updateGear(gear);
      },
    );
    return overlay;
  }
}
