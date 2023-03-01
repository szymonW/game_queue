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
        color: Colors.white,
        child: Text(buttonName),
    );
  }

}

class AppBarButtons extends StatelessWidget {
  final String buttonName;
  VoidCallback onPressed;

  AppBarButtons({super.key,
    required this.buttonName,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0), //Border.all
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: const LinearGradient(
                  colors: <Color>[
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              padding: const EdgeInsets.all(8.0),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: onPressed,
            child: Text(buttonName),
          ),
        ],
      ),
    );
  }
}

