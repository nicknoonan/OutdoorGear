import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:outdoor_gear/model/GearModel.dart';
import 'package:outdoor_gear/provider/GearAssetProvider.dart';

class WebGearAssetProvider extends GearAssetProvider {
  const WebGearAssetProvider({required assetPath}) : super(assetPath: assetPath);

  @override
  Future<List<Gear>> loadGear() async {
    final gearResponse = await http.get(Uri.parse("$assetPath/api/gear"));
    if (gearResponse.statusCode == 200) {
      List<Gear> gearList = Gear.fromDynamicList(jsonDecode(gearResponse.body));
      return gearList;
    } else {
      throw Exception('failed to load gear asset');
    }
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
      String gearJson = jsonEncode(gear);
      print(gearJson);
      final gearResponse = await http.put(Uri.parse("$assetPath/api/gear/${gear.id}"),
          body: gearJson, headers: {'content-type': 'application/json'});
      print(gearResponse.statusCode);
    }
  }

  @override
  Future<void> addGear(Gear gear) async {
    String gearJson = jsonEncode(gear);
    print(gearJson);
    final gearResponse = await http.post(Uri.parse("$assetPath/api/gear"),
        body: gearJson, headers: {'content-type': 'application/json'});
    print(gearResponse.statusCode);
  }

  Future<void> writeGearListToDisk(List<Gear> gearList) async {
    File gearAssetFile = File(assetPath);
    IOSink gearAssetFileSink = gearAssetFile.openWrite();
    gearAssetFileSink.write(jsonEncode(gearList));
    await gearAssetFileSink.flush();
    await gearAssetFileSink.close();
  }
}
