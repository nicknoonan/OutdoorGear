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
    String getGearUri = "$assetPath/api/gear";
    print("[get] $getGearUri");
    //await Future.delayed(Duration(milliseconds: 1000));
    final gearResponse = await http.get(Uri.parse(getGearUri));
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
      String updateGearUri = "$assetPath/api/gear/${gear.id}";
      print("[put] $updateGearUri");
      print(gearJson);
      //await Future.delayed(Duration(milliseconds: 1000));
      final gearResponse =
          await http.put(Uri.parse(updateGearUri), body: gearJson, headers: {'content-type': 'application/json'});
      print(gearResponse.statusCode);
    }
  }

  @override
  Future<void> addGear(Gear gear) async {
    String gearJson = jsonEncode(gear);
    String postGearUri = "$assetPath/api/gear";
    print("[post] $postGearUri");
    print(gearJson);
    final gearResponse =
        await http.post(Uri.parse(postGearUri), body: gearJson, headers: {'content-type': 'application/json'});
    print(gearResponse.statusCode);
  }

  @override
  Future<void> deleteGear(Gear gear) async {
    String deleteGearUri = "$assetPath/api/gear/${gear.id}";
    print("[delete] $deleteGearUri");
    //await Future.delayed(Duration(milliseconds: 1000));
    final deleteResponse = await http.delete(Uri.parse(deleteGearUri));
    print(deleteResponse.statusCode);
  }
}
