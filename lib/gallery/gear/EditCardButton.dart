import 'package:flutter/material.dart';

import 'GearGallery.dart';

class EditCardButton extends StatelessWidget {
  final Function onEdit;
  final Function onSave;
  final bool editMode;
  final bool saving;
  final GearCardType cardType;

  const EditCardButton(
      {super.key,
      required this.onEdit,
      required this.onSave,
      required this.editMode,
      required this.cardType,
      required this.saving});

  @override
  Widget build(BuildContext context) {
    double size = cardType == GearCardType.overlay ? 40 : 0;
    Widget button = cardType == GearCardType.overlay
        ? IconButton(
            icon: editMode ? const Icon(Icons.save) : const Icon(Icons.edit),
            onPressed: () => editMode ? onSave() : onEdit())
        : const SizedBox();

    Widget progressIndicator = CircularProgressIndicator(
      strokeAlign: -4,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
    );

    Widget editCardButton = SizedBox(width: size, child: saving ? progressIndicator : button);

    return editCardButton;
  }
}
