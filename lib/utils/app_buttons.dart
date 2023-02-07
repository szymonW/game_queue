import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonName;
  VoidCallback onPressed;
  AppButton({
    super.key,
    required this.buttonName,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        child: Text(buttonName),
    );
  }

}