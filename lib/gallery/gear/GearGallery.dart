// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/AddGearCardOverlay.dart';
import 'package:outdoor_gear/gallery/gear/GearListScrollView.dart';
import 'package:outdoor_gear/model/GalleryModel.dart';
import 'package:provider/provider.dart';

import '../../model/GearModel.dart';
import '../GalleryView.dart';
import 'GearCard.dart';

enum GearCardType { mini, overlay }

class GearGallery extends StatelessWidget {
  const GearGallery({super.key});

  static GalleryView view = const GalleryView(
      text: "gear", iconData: Icons.inventory_2_outlined, selectedIconData: Icons.inventory, child: GearGallery(), viewType: GalleryViewType.Gear);

  Widget gearList(BuildContext context, GalleryModel galleryContext, GearModel gearContext) {
    Widget list = LayoutBuilder(builder: (context, constraints) {
      return Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          width: constraints.maxWidth,
          child: GearListScrollView(gearContext: gearContext, galleryContext: galleryContext));
    });
    return Expanded(child: list);
  }

  Widget gearLoading(BuildContext context, GearModel gearContext) {
    Widget progressIndicator = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
    );
    return Center(child: progressIndicator);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GalleryModel, GearModel>(builder: (context, galleryContext, gearContext, child) {
      Widget list =
          gearContext.gearLoaded ? gearList(context, galleryContext, gearContext) : gearLoading(context, gearContext);
      return Container(
          //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Column(children: [const Text('test'), list]));
    });
  }
}
