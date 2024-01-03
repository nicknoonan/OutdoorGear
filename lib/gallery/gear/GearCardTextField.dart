import 'package:flutter/material.dart';

class GearCardTextField extends StatelessWidget {
  final bool editMode;
  final Function(String) onChanged;
  final String text;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final TextStyle? style;
  final Function()? onTap;
  final int? maxLength;
  final String labelText;
  final String hintText;

  const GearCardTextField(
      {super.key,
      required this.editMode,
      required this.onChanged,
      required this.text,
      required this.labelText,
      required this.hintText,
      this.minLines,
      this.maxLines,
      this.keyBoardType,
      this.style,
      this.onTap,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return editMode
        ? TextField(
            maxLength: maxLength,
            onTap: onTap,
            onChanged: onChanged,
            readOnly: !editMode,
            style: style,
            controller: TextEditingController.fromValue(TextEditingValue(text: text)),
            decoration: InputDecoration(
                hintText: hintText,
                isDense: false,
                labelText: labelText,
                contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 4)),
            minLines: minLines,
            maxLines: maxLines,
            keyboardType: keyBoardType)
        : Text(text, style: style);
  }
}
