import 'package:flutter/material.dart';

import 'GalleryView.dart';

class GearLoadoutGallery extends StatelessWidget {
  static GalleryView view = GalleryView(
      text: "loadout",
      iconData: Icons.view_list_outlined,
      selectedIconData: Icons.view_list,
      child: GearLoadoutGallery());

  const GearLoadoutGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("gear loadout gallery");
  }
}
