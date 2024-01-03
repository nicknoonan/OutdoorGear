// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:outdoor_gear/model/GalleryModel.dart';
import 'package:provider/provider.dart';

import '../../model/GearModel.dart';
import '../GalleryView.dart';
import 'GearCard.dart';

enum GearCardType { mini, overlay }

class GearGallery extends StatelessWidget {
  const GearGallery({super.key});

  static GalleryView view() {
    return GalleryView("gear", Icons.inventory_2_outlined, Icons.inventory, GearGallery(), SizedBox());
  }

  Widget gearList(BuildContext context, GalleryModel galleryContext, GearModel gearContext) {
    Widget list = LayoutBuilder(builder: (context, constraints) {
      return Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          width: constraints.maxWidth,
          child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              scrollDirection: Axis.vertical,
              child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 10,
                  children: gearContext.gearList.map((gear) {
                    return GearCard(editMode: false, galleryContext: galleryContext, gear: gear, cardType: GearCardType.mini);
                  }).toList())));
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
