import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/GearCard.dart';
import 'package:outdoor_gear/gallery/gear/GearGallery.dart';
import 'package:outdoor_gear/model/GalleryModel.dart';
import 'package:outdoor_gear/model/GearModel.dart';

class GearListScrollView extends StatelessWidget {
  final GearModel gearContext;
  final GalleryModel galleryContext;

  const GearListScrollView({super.key, required this.gearContext, required this.galleryContext});

  void updateGear(Gear gear) {
    gearContext.updateGear(gear);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController(initialScrollOffset: gearContext.gearListInitialScrollOffset);
    scrollController.addListener(() {
      gearContext.setGearListInitialScrollOffset(scrollController.offset);
    });
    return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
        scrollDirection: Axis.vertical,
        controller: scrollController,
        child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: gearContext.gearList.map((gear) {
              return GearCard(
                  editMode: false,
                  galleryContext: galleryContext,
                  gear: gear,
                  cardType: GearCardType.mini,
                  updateGear: (gear) {
                    return gearContext.updateGear(gear);
                  },
                  onTap: !galleryContext.actionView
                      ? () {
                          galleryContext.registerOverlay(
                              context,
                              GearCard(
                                editMode: false,
                                cardType: GearCardType.overlay,
                                galleryContext: galleryContext,
                                gear: gear,
                                updateGear: (gear) {
                                  return gearContext.updateGear(gear);
                                },
                                deleteGear: (gear) {
                                  return gearContext.deleteGear(gear);
                                },
                              ));
                        }
                      : null);
            }).toList()));
  }
}
