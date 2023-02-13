import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db/database.dart';
import '../utils/games_list.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({super.key});

  @override
  State<GameRoute> createState() => _GameRoute();
}

class _GameRoute extends State<GameRoute> {
  //reference to hive box
  final _playersBox = Hive.box('playersBox');
  PalyersDataBase db = PalyersDataBase();

  @override
  void initState() {
    if (_playersBox.get("players") != null) {
      db.loadDB("players");
      createList();
    }
    super.initState();
  }

  List createList () {
    List tempList = List.from(db.playerList);
    List tempEntries = [];
    var proIterGames = 0;
    var revIterGames = 1;

    for (var i in db.playerList) {
      tempList.removeAt(0);
      for (var j in tempList) {
        tempEntries.add('${i[0]} vs ${j[0]}');
      }
    }
    for (int i = 0; i < tempEntries.length; i++) {
      if (i % 2 == 0) {
        db.gamesList.add([tempEntries[proIterGames++], false]);
      }else{
        db.gamesList.add([tempEntries[tempEntries.length-revIterGames++], false]);
      }
    }
    return db.gamesList;
  }

  void checkBoxChange(bool? value, int index){
      setState(() {
        db.gamesList[index][1] = !db.gamesList[index][1];
      });
    }

  //Delete Game
  void deleteField(int index){
    setState(() {
      db.gamesList.removeAt(index);
    });
    db.updateDB("games", db.gamesList);
  }

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
              itemCount: db.gamesList.length,
              itemBuilder: (BuildContext context, int index) {
                return GamesList(
                  playersNames: db.gamesList[index][0],
                  deleteGame: (context) => deleteField(index),
                  index: index,
                  onChanged: (value) => checkBoxChange(value, index),
                  gameCompleted: db.gamesList[index][1],
                );
              }
          )
        ),
    );
  }
}