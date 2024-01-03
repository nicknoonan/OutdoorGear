import 'package:flutter/material.dart';
import '../gallery/GalleryView.dart';

class GalleryModel extends ChangeNotifier {
  int viewIndex = 1;
  GalleryView view = GalleryViews.views[1];
  bool actionView = false;
  OverlayEntry? overlay;

  void selectView(int index) {
    view = GalleryViews.views[index];
    viewIndex = index;
    notifyListeners();
  }

  void registerOverlay(BuildContext context, Widget overlayWidget) {
    actionView = true;
    OverlayEntry overlayEntry = buildGalleryOverlayEntry(context, overlayWidget);
    overlay = overlayEntry;
    Overlay.of(context).insert(overlayEntry);
    notifyListeners();
  }

  void unregisterOverlay() {
    actionView = false;
    if (overlay != null) {
      overlay!.remove();
      overlay!.dispose();
      overlay = null;
    }
    notifyListeners();
  }

  OverlayEntry buildGalleryOverlayEntry(BuildContext context, Widget overlay) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Center(
          child: Material(
        child: overlay,
      ));
    });
    return overlayEntry;
  }
}
