import 'package:flutter/material.dart';

import 'GalleryView.dart';

class HomeGallery extends StatelessWidget {
  static GalleryView view = GalleryView("home", Icons.home_outlined, Icons.home_rounded, HomeGallery(), null);

  const HomeGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('home gallery');
  }
}
