import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Gear {
  String name;
  String brand;
  double weight;
  String type;
  String category;
  String description;
  List<String> tags;

  Gear(this.name, this.brand, this.weight, this.type, this.category, this.description, this.tags);

  Gear.fromDynamic(dynamic gear)
      : name = gear['name'] as String,
        brand = gear['brand'] as String,
        weight = gear['weight'] as double,
        type = gear['type'] as String,
        category = gear['category'] as String,
        description = gear['description'] as String,
        tags = (gear['tags'] as List<dynamic>).map((tag) => tag.toString()).toList();

  static List<Gear> fromDynamicList(List<dynamic> gearList) {
    return gearList.map((gear) => Gear.fromDynamic(gear)).toList();
  }

  static Future<List<Gear>> loadGearAsset(String gearAssetPath) async {
    String gearJson = await rootBundle.loadString(gearAssetPath);
    await Future.delayed(
        const Duration(milliseconds: 200)); // simulate a load delay to make sure the UI is behaving properly
    return Gear.fromDynamicList(jsonDecode(gearJson));
  }
}

class GearModel extends ChangeNotifier {
  List<Gear> gearList = List.empty();
  bool gearLoaded = false;

  GearModel() {
    Gear.loadGearAsset('assets/gear.json').then((list) {
      gearList = list;
      gearLoaded = true;
      notifyListeners();
    });
  }

  void addGear(Gear gear) {
    gearList.add(gear);
    notifyListeners();
  }

  Future<void> writeGearToDisk() async{
    
  }
}
