import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class PlayersList extends StatelessWidget {
  final String playerName;
  Function(BuildContext)? deletePlayer;

  PlayersList({
    super.key,
    required this.playerName,
    required this.deletePlayer,
  });

  @override
  Widget build(BuildContext context) {
    var outsidePadding = 15.0;
    var insidePadding = 24.0;

    return Padding(
      padding: EdgeInsets.only(
          top:outsidePadding,
          right: outsidePadding,
          left: outsidePadding),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                onPressed: deletePlayer,
                icon: Icons.delete,
                backgroundColor: Colors.red),
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(insidePadding),
          decoration: BoxDecoration(
              color: Colors.green[300],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(outsidePadding),
                  bottomLeft: Radius.circular(outsidePadding)
              )),
          child: Text(playerName),
        ),
      )
    );
  }
}