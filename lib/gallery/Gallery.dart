import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/GalleryModel.dart';
import '../widgets/GrayedOut.dart';
import 'GalleryNavigation.dart';
import 'GalleryView.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryModel>(builder: (context, galleryContext, child) {
      return Expanded(
          child: GrayedOut(
              grayedOut: galleryContext.actionView,
              child: GestureDetector(
                  onTap: () {
                    galleryContext.unregisterOverlay();
                  },
                  child: Row(children: [GalleryNavigation(), GalleryBody()]))));
    });
    //return const Expanded(child: Row(children: [GalleryNavigation(), GalleryBody()]));
  }
}
