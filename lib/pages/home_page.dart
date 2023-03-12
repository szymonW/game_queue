import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:game_queue/utils/players_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db/database.dart';
import '../utils/app_buttons.dart';
import '../utils/empty_field_popup.dart';
import '../utils/player_dialog_box.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference to hive box
  final _playersBox = Hive.box('playersBox');
  PalyersDataBase db = PalyersDataBase();

  //AppBar button name
  String startButtonName = "";

  @override
  void initState() {
    if (_playersBox.get("players") != null) {
      db.loadDB("players");
    }

    checkStartButtonName();

      super.initState();
  }

  //Check if AppBar button name is proper
  String checkStartButtonName() {
    startButtonName = _playersBox.get("games") == null ? "Start Game" : "Continue";
    return startButtonName;
  }

  //text controller
  final _controller = TextEditingController();

  bool checkDuplicatedName(newPlayer, {String? editPlayerName}){
    for (var i in db.playerList){
      if (i[0] == newPlayer && i[0] != editPlayerName){
        return true;
      }
    }
    return false;
  }

  //Raise information alert with OK button
  void okAlertDialog(String text){
    Flushbar(
      backgroundColor: Colors.red,
      message: text,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  //Save new player
  void saveNewPlayer({int index = -1, String? editPlayerName}){
    String newPlayer = _controller.text.trim();
    if (_controller.text.isEmpty) {
      okAlertDialog("Can't save empty name field");
    } else if (newPlayer.isEmpty) {
      okAlertDialog("Can't add just a space");
    } else if (checkDuplicatedName(newPlayer, editPlayerName: editPlayerName)) {
      okAlertDialog("This player already exists");
    } else {
      setState(() {
        if (index == -1) {
          db.playerList.add([newPlayer.toString()]);
        } else {
          db.playerList[index] = [newPlayer.toString()];
        }
        _controller.clear();
        checkStartButtonName();
      });
      Navigator.of(context).pop();
      db.updatePlayersDB();
    }
  }

  void cancelNewPlayer() {
    setState(() {
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //Add new player
  void addPlayer() {
    _controller.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return PlayerDialogBox(
            controller: _controller,
            onCancel: cancelNewPlayer,
            onSave: saveNewPlayer,
          );
    });
  }

  //Delete Player
  void deleteField(int index){
    setState(() {
      db.playerList.removeAt(index);
      checkStartButtonName();
    });
    db.updatePlayersDB();
  }

  //Edit Player Name
  void editField(int index){
    _controller.text = db.playerList[index][0];
    showDialog(
        context: context,
        builder: (context) {
          return PlayerDialogBox(
            controller: _controller,
            onCancel: cancelNewPlayer,
            onSave: () => saveNewPlayer(
                index: index,
                editPlayerName: db.playerList[index][0]
            ),
          );
        });
  }

  //Start Game
  void startGame(){
    if (db.playerList.length <= 1) {
      okAlertDialog("Add at least two players");
    } else {
      setState(() {
        checkStartButtonName();
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GameRoute()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Game Queue"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 9,
                bottom: 6),
            child: AppBarButtons(
              buttonName: checkStartButtonName(),
              onPressed: startGame,
            ),
          ),
        ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPlayer,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(bottom: 42.0),
        //Build list of players
        child: ListView.builder(
          itemCount: db.playerList.length,
          itemBuilder: (context, index) {
            return PlayersList(
              playerName: db.playerList[index][0],
              deletePlayer: (context) => deleteField(index),
              editPlayer: (context) => editField(index),
            );
          },
        )
      )
    );
  }
}