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

  bool checkDuplicatedName(newPlayer){
    for (var i in db.playerList){
      if (i[0] == newPlayer){return true;}
    }
    return false;
  }

  //Save new player
  void saveNewPlayer(){
    String newPlayer = _controller.text.trim();
    if (_controller.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertFieldDialog(
                alertText: "Can't save empty name field",
                onOK: () => Navigator.of(context).pop());
          });
    } else if (newPlayer.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertFieldDialog(
                alertText: "Can't add just a space",
                onOK: () => Navigator.of(context).pop());
          });
    } else if (checkDuplicatedName(newPlayer)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertFieldDialog(
                alertText: "This player already exists",
                onOK: () => Navigator.of(context).pop());
          });
    } else {
      setState(() {
        db.playerList.add([newPlayer.toString()]);
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

  //Start Game
  void startGame(){
    if (db.playerList.length <= 1) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertFieldDialog(
                alertText: "Add at least two players",
                onOK: () => Navigator.of(context).pop());
          });
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
            padding: const EdgeInsets.all(7.0),
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
            topLeft: Radius.circular(20)
          ),
        // color: Colors.cyan,
        color: Color(0xFFACFFFF),
        ),
        padding: const EdgeInsets.only(bottom: 50.0),
        //Build list of players
        child: ListView.builder(
          itemCount: db.playerList.length,
          itemBuilder: (context, index) {
            return PlayersList(
              playerName: db.playerList[index][0],
              deletePlayer: (context) => deleteField(index),
            );
          },
        )
      )
    );
  }
}