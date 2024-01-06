import 'package:outdoor_gear/model/GearModel.dart';

abstract class GearAssetProvider {
  final String assetPath;

  const GearAssetProvider({required this.assetPath});

  Future<List<Gear>> loadGear();

  Future<void> updateGear(Gear gear);

  Future<void> addGear(Gear gear);
}
