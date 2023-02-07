import 'package:flutter/material.dart';
import 'package:game_queue/utils/players_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../db/database.dart';
import '../utils/player_dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference to hive box
  final _playersBox = Hive.box('playersBox');
  PalyersDataBase db = PalyersDataBase();

  @override
  void initState() {
    if (_playersBox.get("players") != null) {
      db.loadDB();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //Save new player
  void saveNewPlayer(){
    setState(() {
      db.playerList.add([_controller.text]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDB();
  }
  //Add new player
  void addPlayer() {
    showDialog(
        context: context,
        builder: (context) {
          return PlayerDialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: saveNewPlayer,
          );
    });
  }

  //Delete Player
  void deleteField(int index){
    setState(() {
      db.playerList.removeAt(index);
    });
    db.updateDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Game Queue"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPlayer,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20)
          ),
        // color: Colors.cyan,
        color: Color(0xFFACFFFF),
        ),
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ListView.builder(
          itemCount: db.playerList.length,
          itemBuilder: (context, index){
            return PlayersList(
              playerName: db.playerList[index][0],
              deletePlayer: (context) => deleteField(index),
            );
          },
        ),
      )
    );
  }
}