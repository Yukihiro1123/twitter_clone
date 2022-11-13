import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? iconData;
  final String label;

  const ButtonWithIcon(
      {super.key, this.onPressed, this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: FaIcon(iconData),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
