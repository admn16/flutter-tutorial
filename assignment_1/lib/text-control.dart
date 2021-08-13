import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final VoidCallback onPressed;

  TextControl(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Change Text'),
    );
  }
}
