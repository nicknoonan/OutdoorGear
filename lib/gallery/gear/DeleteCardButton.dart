import 'package:flutter/material.dart';

import 'GearGallery.dart';

class DeleteCardButton extends StatelessWidget {
  final Function onDelete;
  final GearCardType cardType;
  final bool deleting;

  const DeleteCardButton({super.key, required this.onDelete, required this.cardType, required this.deleting});

  @override
  Widget build(BuildContext context) {
    double size = cardType == GearCardType.overlay ? 40 : 0;

    Widget button = cardType == GearCardType.overlay
        ? IconButton(icon: const Icon(Icons.delete), onPressed: () => onDelete())
        : const SizedBox();

    Widget progressIndicator = CircularProgressIndicator(
      strokeAlign: -4,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
    );

    Widget deleteCardButton = SizedBox(width: size, child: deleting ? progressIndicator : button);

    return deleteCardButton;
  }
}
