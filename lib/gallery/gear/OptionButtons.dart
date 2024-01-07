import 'package:flutter/material.dart';
import 'package:outdoor_gear/gallery/gear/CloseCardButton.dart';
import 'package:outdoor_gear/gallery/gear/DeleteCardButton.dart';
import 'package:outdoor_gear/gallery/gear/EditCardButton.dart';

import 'GearGallery.dart';

class OptionButtons extends StatelessWidget {
  final EditCardButton editCardButton;
  final CloseCardButton closeCardButton;
  final DeleteCardButton deleteCardButton;

  const OptionButtons({super.key, required this.editCardButton, required this.closeCardButton, required this.deleteCardButton});

  @override
  Widget build(BuildContext context) {
    Widget optionButtons = Row(children: [editCardButton, deleteCardButton, closeCardButton]);
    return optionButtons;
  }
}
