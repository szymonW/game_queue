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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.cyan,
                    Color(0xFF4DD0E1),
                    Color(0xFFACFFFF),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: onPressed,
            child: Text(buttonName),
          ),
        ],
      ),
    );
  }
}

