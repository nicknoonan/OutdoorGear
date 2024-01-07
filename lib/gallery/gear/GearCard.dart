import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/CloseCardButton.dart';
import 'package:outdoor_gear/gallery/gear/DeleteCardButton.dart';
import 'package:outdoor_gear/gallery/gear/InfoTrio.dart';
import 'package:outdoor_gear/gallery/gear/OptionButtons.dart';

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
  final Future<void> Function(Gear)? updateGear;
  final Future<void> Function(Gear)? deleteGear;
  final Function()? onTap;

  const GearCard(
      {super.key,
      required this.cardType,
      required this.galleryContext,
      required this.gear,
      required this.editMode,
      this.updateGear,
      this.deleteGear,
      this.onTap});

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
  late Future<void> Function(Gear)? updateGear;
  late Future<void> Function(Gear)? deleteGear;
  late Function()? onTap;
  bool saving = false;
  bool deleting = false;

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
    updateGear = widget.updateGear;
    deleteGear = widget.deleteGear;
    onTap = widget.onTap;
  }

  void toggleEditMode() {
    setState(() {
      editMode = !editMode;
    });
  }

  void toggleSaving() {
    setState(() {
      saving = !saving;
    });
  }

  void toggleDeleting() {
    setState(() {
      deleting = !deleting;
    });
  }

  // void cardOnTap() {
  //   galleryContext.registerOverlay(
  //       context,
  //       GearCard(
  //           editMode: false,
  //           cardType: GearCardType.overlay,
  //           galleryContext: galleryContext,
  //           gear: gear,
  //           updateGear: updateGear));
  // }

  @override
  Widget build(BuildContext context) {
    //close card button
    CloseCardButton closeCardButton = CloseCardButton(cardType: cardType, galleryContext: galleryContext);

    DeleteCardButton deleteCardButton = DeleteCardButton(
      onDelete: () {
        toggleDeleting();
        deleteGear!(gear).whenComplete(() {
          toggleDeleting();
          galleryContext.unregisterOverlay();
        });
      },
      cardType: cardType,
      deleting: deleting,
    );

    //edit card button
    EditCardButton editCardButton = EditCardButton(
        saving: saving,
        cardType: cardType,
        onEdit: () {
          //make some edits!
          toggleEditMode();
        },
        onSave: () {
          //save the edits!
          toggleSaving();
          gear.name = editName;
          gear.description = editDescription;
          gear.weight = editWeight;
          gear.type = editType;
          gear.brand = editBrand;
          Future<void> updateGearFuture = updateGear != null ? updateGear!(gear) : Future.delayed(Duration.zero);
          updateGearFuture.whenComplete(() {
            toggleSaving();
            toggleEditMode();
          });
        },
        editMode: editMode);

    //option buttons row
    Widget optionButtons = OptionButtons(
        deleteCardButton: deleteCardButton, editCardButton: editCardButton, closeCardButton: closeCardButton);

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
                onTap: onTap, //!galleryContext.actionView && cardType == GearCardType.mini ? cardOnTap : null,
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
