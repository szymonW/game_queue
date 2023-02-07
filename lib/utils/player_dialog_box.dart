import 'package:flutter/material.dart';
import 'package:game_queue/utils/app_buttons.dart';

class PlayerDialogBox extends StatelessWidget {
  const PlayerDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Container(
        height: 120,
        child: Column(
          children: [
            //Add player name
            TextField(
              obscureText: true,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Player name',
              ),
            ),
            //Buttons (Cancel & Save)
            Row(
              children: [
                AppButton(buttonName: "Cancel", onPressed: (){}),
                AppButton(buttonName: "Save", onPressed: (){}),
              ],
            )
          ],
        ),
      ),
    );
  }

}