import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/GearGallery.dart';

import '../../Constants.dart';
import '../../model/GearModel.dart';
import 'GearCardTextField.dart';

class InfoTrio extends StatelessWidget {
  final Gear gear;
  final GearCardType cardType;
  final bool editMode;
  final Function(double) onWeightChanged;
  final Function(String) onTypeChanged;
  final Function(String) onBrandChanged;

  const InfoTrio(
      {super.key,
      required this.gear,
      required this.cardType,
      required this.editMode,
      required this.onWeightChanged,
      required this.onTypeChanged,
      required this.onBrandChanged});

  @override
  Widget build(BuildContext context) {
    String weightText = gear.weight != 0 ? gear.weight.toString() : "";
    Widget weightWidget = Row(children: [
      Expanded(
          flex: editMode ? 1 : 0,
          child: GearCardTextField(
            editMode: editMode,
            onChanged: (value) {
              double weight = double.tryParse(value) ?? 0;
              onWeightChanged(weight);
            },
            style: Theme.of(context).textTheme.bodySmall,
            text: weightText,
            hintText: 'how much does this weigh?',
            labelText: 'weight (oz)',
          )),
      !editMode ? Text(
        'oz',
        style: Theme.of(context).textTheme.bodySmall,
      ) : const SizedBox()
    ]);
    Widget gearType = Row(children: [Expanded(
        flex: editMode ? 1 : 0,
        child: GearCardTextField(
          editMode: editMode,
          onChanged: (value) {
            String type = value;
            onTypeChanged(type);
          },
          style: Theme.of(context).textTheme.bodySmall,
          text: gear.type,
          hintText: 'what type of gear?',
          labelText: 'type',
        ))]);
    Widget gearBrand = Row(children: [Expanded(
        flex: editMode ? 1 : 0,
        child: GearCardTextField(
          editMode: editMode,
          onChanged: (value) {
            String brand = value;
            onBrandChanged(brand);
          },
          style: Theme.of(context).textTheme.bodySmall,
          text: gear.brand,
          hintText: 'who made this?',
          labelText: 'brand',
        ))]);
    Widget infoTrioDivider = const VerticalDivider(indent: 3, endIndent: 3, width: 15, thickness: 1);
    Widget infoTrio = Container(
        height: editMode ? null : 30,
        padding: editMode ? const EdgeInsets.all(10) : const EdgeInsets.fromLTRB(10, 0, 10, 0) ,
        margin: cardType == GearCardType.overlay ? const EdgeInsets.fromLTRB(0, 0, 0, 3) : null,
        decoration: BoxDecoration(borderRadius: Constants.borderRadius, color: Theme.of(context).primaryColor),
        //border: Border.all(color: Colors.red, width: 1)),
        child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: editMode ? Axis.vertical : Axis.horizontal,
            children: [weightWidget, infoTrioDivider, gearType, infoTrioDivider, gearBrand]));
    return infoTrio;
  }
}
