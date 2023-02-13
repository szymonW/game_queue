import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class GamesList extends StatelessWidget {
  final String playersNames;
  final int index;
  final bool gameCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteGame;

  GamesList({
    super.key,
    required this.playersNames,
    required this.deleteGame,
    required this.index,
    required this.gameCompleted,
    required this.onChanged,
  });

  Color? colorCode(index, {rev = true}) {
    int startValue = rev ? 700 : 100;
    int indexSign = rev ? -1 : 1;
    num iReturn = startValue+indexSign*index*100;
    MaterialColor color;
    if (gameCompleted == false) {
      color = Colors.cyan;
    } else {
      color = Colors.red;
    }
    if (index <= 6) {
      return color[iReturn.toInt()];
    }else{
      return colorCode(index-6, rev: !rev);
    }
  }

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
        color: colorCode(index),
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