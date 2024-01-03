import 'package:flutter/material.dart';

import 'GalleryView.dart';

class GearLoadoutGallery extends StatelessWidget {
  static GalleryView view() {
    return GalleryView("loadout", Icons.view_list_outlined, Icons.view_list, GearLoadoutGallery(), null);
  }

  const GearLoadoutGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("gear loadout gallery");
  }
}
