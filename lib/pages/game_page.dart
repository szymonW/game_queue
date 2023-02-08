import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../db/database.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({super.key});

  @override
  State<GameRoute> createState() => _GameRoute();
}

class _GameRoute extends State<GameRoute> {
  //reference to hive box
  final _playersBox = Hive.box('playersBox');
  PalyersDataBase db = PalyersDataBase();

  final List<String> entries = <String>[
    'Player 1 vs Palyer 2',
    'Player 3 vs Palyer 4',
    'Player 1 vs Palyer 3',
    'Player 2 vs Palyer 4',
    'Player 1 vs Palyer 4',
    'Player 2 vs Palyer 3',
  ];
  final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Game in progress'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20)
          ),
          color: Color(0xFFACFFFF),
        ),
        padding: const EdgeInsets.only(bottom: 50.0),
          child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 45,
                  color: Colors.cyan[colorCodes[index]],
                  child: Center(child: Text('Game ${entries[index]}')),
                );
              }
          )
        ),
    );
  }
}