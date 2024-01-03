// class GearModel extends ChangeNotifier {
//   List<Gear> gearList = List.empty();
//   bool gearLoaded = false;

//   GearModel() {
//     Gear.loadGearAsset('assets/gear.json').then((list) {
//       gearList = list;
//       gearLoaded = true;
//       notifyListeners();
//     });
//   }
// }