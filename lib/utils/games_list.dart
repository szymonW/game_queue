import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class GamesList extends StatelessWidget {
  final String playersNames;
  final int index;
  final bool gameCompleted;
  Color? colorCode;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteGame;

  GamesList({
    super.key,
    required this.playersNames,
    required this.deleteGame,
    required this.index,
    required this.colorCode,
    required this.gameCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              onPressed: deleteGame,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400),
        ],
      ),
      child: Container(
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
                    child: Text(playersNames)
            )),

            Expanded(
              flex: 1, child: Container(),
            )

          ],
        ),
    )
    );
  }
}