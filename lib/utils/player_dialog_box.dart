import 'package:flutter/material.dart';
import 'package:game_queue/utils/app_buttons.dart';

class PlayerDialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  PlayerDialogBox({super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white70,
      content: SizedBox(
        height: 140,
        child: Column(
            children: [
            //Add player name
              TextField(
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                autofocus: true,
                maxLength: 12,
                textAlign: TextAlign.center,
                // controller: controller..text = initialValue,
                controller: controller,
                onEditingComplete: onSave,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  hintText: 'Player name',
              ),
            ),
            //Buttons (Cancel & Save)
          Padding(padding: const EdgeInsets.only(top: 7.0),
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