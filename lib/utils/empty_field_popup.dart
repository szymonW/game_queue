import 'package:flutter/material.dart';
import 'package:game_queue/utils/app_buttons.dart';

class AlertFieldDialog extends StatelessWidget {
  VoidCallback onOK;
  String alertText;

  AlertFieldDialog({
    super.key,
    required this.onOK,
    required this.alertText
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.grey[300],
        content: Container(
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(alertText, style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                  Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: AppButton(buttonName: 'OK', onPressed: onOK,))
                ],
              ),
            ))
    );
  }

}