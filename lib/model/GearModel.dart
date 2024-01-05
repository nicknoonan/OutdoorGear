import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
      'weight': weight,
      'type': type,
      'category': category,
      'description': description,
      'tags': tags
    };
  }

  static Future<List<Gear>> loadGearAsset(String gearAssetPath) async {
    await Future.delayed(
        const Duration(milliseconds: 0)); // simulate a load delay to make sure the UI is behaving properly

    File gearAssetFile = File(gearAssetPath);
    String gearAssetJson = await gearAssetFile.readAsString();
    return Gear.fromDynamicList(jsonDecode(gearAssetJson));
  }
}

class GearModel extends ChangeNotifier {
  List<Gear> gearList = List.empty();
  bool gearLoaded = false;
  final String gearAssetPath = 'C:\\Users\\minke\\source\\repos\\OutdoorGear\\assets\\gear.json';

  GearModel() {
    Gear.loadGearAsset(gearAssetPath).then((list) {
      gearList = list;
      gearLoaded = true;
      notifyListeners();
    });
  }

  void addGear(Gear gear) {
    gearList.add(gear);
    writeGearListToDisk().whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> writeGearListToDisk() async {
    File gearAssetFile = File(gearAssetPath);
    IOSink gearAssetFileSink = gearAssetFile.openWrite();
    gearAssetFileSink.write(jsonEncode(gearList));
    await gearAssetFileSink.flush();
    await gearAssetFileSink.close();
  }

  void writeGearListToDiskSync(Function? callback) {
    writeGearListToDisk().whenComplete(() {
      if (null != callback) {
        callback();
      }
    });
  }
}
