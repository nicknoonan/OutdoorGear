import 'package:flutter/material.dart';

import 'GalleryView.dart';

class HomeGallery extends StatelessWidget {
  static GalleryView view = GalleryView(
      text: "home", iconData: Icons.home_outlined, selectedIconData: Icons.home_rounded, child: HomeGallery());

  const HomeGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('home gallery');
  }
}
