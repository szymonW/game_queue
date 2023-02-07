import 'package:flutter/material.dart';


class PlayersList extends StatelessWidget {
  final String playerName;

  PlayersList({super.key, required this.playerName});

  @override
  Widget build(BuildContext context) {
    var outsidePadding = 15.0;
    var insidePadding = 12.0;

    return Padding(
      padding: EdgeInsets.only(
          top:outsidePadding,
          right: outsidePadding,
          left: outsidePadding),
      child: Container(
        padding: EdgeInsets.all(insidePadding),
        decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.circular(12)),
        child: Text(playerName),
      )
    );
  }
}