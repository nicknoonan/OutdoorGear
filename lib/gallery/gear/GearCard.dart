import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/InfoTrio.dart';

import '../../Constants.dart';
import '../../model/GalleryModel.dart';
import '../../model/GearModel.dart';
import 'EditCardButton.dart';
import 'GearGallery.dart';
import 'GearCardTextField.dart';

class GearCard extends StatefulWidget {
  final GearCardType cardType;
  final GalleryModel galleryContext;
  final Gear gear;
  final bool editMode;
  final Function(Gear)? onGearAdd;

  const GearCard(
      {super.key,
      required this.cardType,
      required this.galleryContext,
      required this.gear,
      required this.editMode,
      this.onGearAdd});

  @override
  _GearCardState createState() => _GearCardState();
}

class _GearCardState extends State<GearCard> {
  late GearCardType cardType;
  late GalleryModel galleryContext;
  late Gear gear;
  late bool editMode;
  late String editName;
  late String editDescription;
  late double editWeight;
  late String editType;
  late String editBrand;
  late Function(Gear)? onGearAdd;

  @override
  void initState() {
    super.initState();
    cardType = widget.cardType;
    galleryContext = widget.galleryContext;
    gear = widget.gear;
    editMode = widget.editMode;
    editName = gear.name;
    editDescription = gear.description;
    editWeight = gear.weight;
    editType = gear.type;
    editBrand = gear.brand;
    onGearAdd = widget.onGearAdd;
  }

  void toggleEditMode() {
    setState(() {
      editMode = !editMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    //handle what happens when the card is tapped!
    Function()? cardOnTap = !galleryContext.actionView && cardType == GearCardType.mini
        ? () {
            galleryContext.registerOverlay(context,
                GearCard(editMode: false, cardType: GearCardType.overlay, galleryContext: galleryContext, gear: gear));
          }
        : null;

    //close card button
    Widget closeCardButton = cardType == GearCardType.overlay
        ? CloseButton(onPressed: () {
            galleryContext.unregisterOverlay();
          })
        : const SizedBox();

    //edit card button
    Widget editCardButton = EditCardButton(
        cardType: cardType,
        onEdit: () {
          //make some edits!
          toggleEditMode();
        },
        onSave: () {
          //save the edits!
          gear.name = editName;
          gear.description = editDescription;
          gear.weight = editWeight;
          gear.type = editType;
          gear.brand = editBrand;
          if (onGearAdd != null) {
            onGearAdd!(gear);
          }
          toggleEditMode();
        },
        editMode: editMode);

    //option buttons row
    Widget optionButtons = Row(children: [editCardButton, closeCardButton]);

    //gear name and icon row
    Widget gearName = Expanded(
        child: Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
            child: Row(children: [
      const Icon(Icons.circle, size: 25.0),
      const Padding(padding: EdgeInsets.all(3)),
      Expanded(
          child: GearCardTextField(
              style: Theme.of(context).textTheme.bodyLarge,
              editMode: editMode,
              text: gear.name,
              labelText: 'name',
              hintText: 'super cool piece of gear :)',
              onChanged: (value) {
                editName = value;
              })),
    ])));

    //title: icon and gear name
    Widget title = Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
        //decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 1)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [gearName, optionButtons]));

    //info trio: weight category and brand
    Widget infoTrio = InfoTrio(
        onWeightChanged: (weight) {
          editWeight = weight;
        },
        onTypeChanged: (type) {
          editType = type;
        },
        onBrandChanged: (brand) {
          editBrand = brand;
        },
        editMode: editMode,
        gear: gear,
        cardType: cardType);

    //description
    Widget description = cardType == GearCardType.overlay
        ? Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
            child: Row(children: [
            Expanded(
                child: GearCardTextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    editMode: editMode,
                    text: gear.description,
                    hintText: 'what is this gear?',
                    labelText: 'description',
                    keyBoardType: TextInputType.multiline,
                    onChanged: (value) {
                      editDescription = value;
                    }))
          ]))
        : const SizedBox();

    //overlay constained to 80% of screen size
    BoxConstraints overlayConstraints = BoxConstraints(maxWidth: min((MediaQuery.of(context).size.width * 0.90), 850));

    //bring it all together into the final gear card
    EdgeInsetsGeometry padding = cardType == GearCardType.mini ? const EdgeInsets.all(3) : const EdgeInsets.all(20);
    Widget gearCard = UnconstrainedBox(
        child: Card(
            shape: Constants.roundedRectanlgeBorder,
            margin: const EdgeInsets.all(0),
            child: InkWell(
                onTap: cardOnTap,
                borderRadius: Constants.borderRadius,
                child: Container(
                    padding: padding,
                    //decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
                    constraints: overlayConstraints,
                    child: IntrinsicWidth(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [title, infoTrio, description]))))));
    return gearCard;
  }
}
