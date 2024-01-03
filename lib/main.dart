import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Constants.dart';
import 'gallery/Gallery.dart';
import 'gallery/GalleryActionButton.dart';
import 'model/GalleryModel.dart';
import 'model/GearModel.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => GalleryModel()),
    ChangeNotifierProvider(create: (context) => GearModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: Constants.colorScheme),
        home: const Scaffold(floatingActionButton: GalleryActionButton(), body: Column(children: [Gallery()])));
  }
}
