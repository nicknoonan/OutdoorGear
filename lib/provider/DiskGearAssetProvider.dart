import 'dart:convert';
import 'dart:io';

import 'package:outdoor_gear/model/GearModel.dart';
import 'package:outdoor_gear/provider/GearAssetProvider.dart';

class DiskGearAssetProvider extends GearAssetProvider {
  final String assetPath;

  const DiskGearAssetProvider({required this.assetPath}) : super(assetPath: assetPath);

  @override
  Future<List<Gear>> loadGear() async {
    await Future.delayed(
        const Duration(milliseconds: 1000)); // simulate a load delay to make sure the UI is behaving properly

    File gearAssetFile = File(assetPath);
    String gearAssetJson = await gearAssetFile.readAsString();
    return Gear.fromDynamicList(jsonDecode(gearAssetJson));
  }

  @override
  Future<void> updateGear(Gear updateGear) async {
    List<Gear> gearList = await loadGear();
    Gear gear = gearList.singleWhere((gear) => gear.id == updateGear.id);
    gear = updateGear;
    writeGearListToDisk(gearList);
  }

  @override
  Future<void> addGear(Gear gear) async {
    List<Gear> gearList = await loadGear();
    gearList.add(gear);
    await writeGearListToDisk(gearList);
  }

  Future<void> writeGearListToDisk(List<Gear> gearList) async {
    File gearAssetFile = File(assetPath);
    IOSink gearAssetFileSink = gearAssetFile.openWrite();
    gearAssetFileSink.write(jsonEncode(gearList));
    await gearAssetFileSink.flush();
    await gearAssetFileSink.close();
  }
}
