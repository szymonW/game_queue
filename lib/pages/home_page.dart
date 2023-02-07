import 'package:flutter/material.dart';
import 'package:game_queue/utils/players_list.dart';

import '../utils/player_dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var playerList = [["Wyder"],["Pyh"]];
//Add new player
  void addPlayer() {
    showDialog(context: context, builder: (context) {
      return PlayerDialogBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Game Queue"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPlayer,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: playerList.length,
        itemBuilder: (context, index){
          return PlayersList(playerName: playerList[index][0]);
        },
      )
    );
  }
}