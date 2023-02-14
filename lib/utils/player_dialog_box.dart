import 'package:flutter/material.dart';
import 'package:game_queue/utils/app_buttons.dart';

class PlayerDialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  PlayerDialogBox({super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: SizedBox(
        height: 120,
        child: Column(children: [
            //Add player name
            TextField(
              textCapitalization: TextCapitalization.words,
              autofocus: true,
              controller: controller,
              // obscureText: true, <- for password
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Player name',
              ),
            ),
            //Buttons (Cancel & Save)
          Padding(padding: const EdgeInsets.only(top: 5.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton(buttonName: "Cancel", onPressed: onCancel),
                AppButton(buttonName: "Save", onPressed: onSave),
              ],
            ),
          )
        ]),
      ),
    );
  }

}