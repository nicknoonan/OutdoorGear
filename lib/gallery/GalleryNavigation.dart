// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants.dart';
import 'GalleryView.dart';
import '../model/GalleryModel.dart';

class GalleryNavigation extends StatelessWidget {
  const GalleryNavigation({super.key});

  List<NavigationRailDestination> MapRailDestinations(GalleryModel galleryContext) {
    Iterable<NavigationRailDestination> railDestinations;
    railDestinations = GalleryViews.views.map((view) {
      return NavigationRailDestination(
          icon: Icon(view.iconData),
          selectedIcon: Icon(view.selectedIconData),
          label: Text(view.text),
          disabled: galleryContext.actionView);
    });
    return railDestinations.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 65,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Consumer<GalleryModel>(builder: (context, galleryContext, child) {
            return NavigationRail(
                backgroundColor: Theme.of(context).canvasColor,
                selectedIndex: galleryContext.viewIndex,
                groupAlignment: -1,
                onDestinationSelected: (int index) {
                  galleryContext.selectView(index);
                },
                labelType: NavigationRailLabelType.none,
                indicatorShape: Constants.roundedRectanlgeBorder,
                destinations: MapRailDestinations(galleryContext));
          })),
      const VerticalDivider(
        width: 1.5,
      )
    ]);
  }
}
