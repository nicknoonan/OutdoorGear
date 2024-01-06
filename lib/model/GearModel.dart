import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outdoor_gear/provider/DiskGearAssetProvider.dart';
import 'package:outdoor_gear/provider/GearAssetProvider.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class Gear {
  UuidValue id;
  String name;
  String brand;
  double weight;
  String type;
  String category;
  String description;
  List<String> tags;

  Gear(this.id, this.name, this.brand, this.weight, this.type, this.category, this.description, this.tags);

  Gear.fromDynamic(dynamic gear)
      : id = UuidValue.fromString(gear['id']),
        name = gear['name'] as String,
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
      'id': id.toString(),
      'name': name,
      'brand': brand,
      'weight': weight,
      'type': type,
      'category': category,
      'description': description,
      'tags': tags
    };
  }
}

class GearModel extends ChangeNotifier {
  List<Gear> gearList = List.empty();
  bool gearLoaded = false;
  double gearListInitialScrollOffset = 0;
  final String assetPath = 'C:\\Users\\minke\\source\\repos\\OutdoorGear\\assets\\gear.json';
  late GearAssetProvider assetProvider;

  GearModel() {
    assetProvider = DiskGearAssetProvider(assetPath: assetPath);
    assetProvider.loadGear().then((list) {
      gearList = list;
      gearLoaded = true;
      notifyListeners();
    });
  }

  void setGearListInitialScrollOffset(double value) {
    gearListInitialScrollOffset = value;
  }

  void addGear(Gear gear) {
    gearList.add(gear);
    assetProvider.addGear(gear).whenComplete(() => notifyListeners());
  }

  void updateGear(Gear updateGear) {
    //gearList.singleWhere((gear) => gear.id == updateGear.id);
    // for (int i = 0; i < gearList.length; i++) {
    //   if (gearList[i].id == updateGear.id) {
    //     gearList[i] = updateGear;
    //   }
    // }
    assetProvider.updateGear(updateGear).whenComplete(() => notifyListeners());
  }

  Future<void> writeGearListToDisk() async {
    File gearAssetFile = File(assetPath);
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
