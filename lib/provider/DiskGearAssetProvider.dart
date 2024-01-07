import 'dart:convert';
import 'dart:io';

import 'package:outdoor_gear/model/GearModel.dart';
import 'package:outdoor_gear/provider/GearAssetProvider.dart';

class DiskGearAssetProvider extends GearAssetProvider {
  const DiskGearAssetProvider({required assetPath}) : super(assetPath: assetPath);

  @override
  Future<List<Gear>> loadGear() async {
    // await Future.delayed(
    //     const Duration(milliseconds: 1000)); // simulate a load delay to make sure the UI is behaving properly

    File gearAssetFile = File(assetPath);
    String gearAssetJson = await gearAssetFile.readAsString();
    return Gear.fromDynamicList(jsonDecode(gearAssetJson));
  }

  @override
  Future<void> updateGear(Gear gear) async {
    List<Gear> gearList = await loadGear();
    Gear? updateGear;
    int index = 0;
    while (updateGear == null && index < gearList.length) {
      if (gearList[index].id == gear.id) {
        updateGear = gear;
      } else {
        index++;
      }
    }
    if (updateGear != null) {
      gearList[index] = updateGear;
    }
    await writeGearListToDisk(gearList);
  }

  @override
  Future<void> addGear(Gear gear) async {
    List<Gear> gearList = await loadGear();
    gearList.add(gear);
    await writeGearListToDisk(gearList);
  }

  @override
  Future<void> deleteGear(Gear gear) async {
    
  }

  Future<void> writeGearListToDisk(List<Gear> gearList) async {
    File gearAssetFile = File(assetPath);
    IOSink gearAssetFileSink = gearAssetFile.openWrite();
    gearAssetFileSink.write(jsonEncode(gearList));
    await gearAssetFileSink.flush();
    await gearAssetFileSink.close();
  }
}
