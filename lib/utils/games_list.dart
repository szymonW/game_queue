import 'package:flutter/material.dart';

class GamesList extends StatelessWidget {
  final String playersNames;
  final int index;
  final bool gameCompleted;
  Color? colorCode;
  Function(bool?)? onChanged;

  GamesList({
    super.key,
    required this.playersNames,
    required this.index,
    required this.colorCode,
    required this.gameCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: colorCode,
      child: Row(

        children: [

          Expanded(
              flex: 1,
              child: Checkbox(
                value: gameCompleted,
                onChanged: onChanged,
          )),

          Expanded(
            flex: 6,
              child: Center(
                  child: Text(playersNames, style: const TextStyle(color: Colors.black),)
          )),

          Expanded(
            flex: 1, child: Container(),
          )

        ],
      ),
    );
  }
}