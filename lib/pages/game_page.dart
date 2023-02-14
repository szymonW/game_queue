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
      if (_playersBox.get("games") != null) {
        db.loadDB("games");
      } else {
        createList();
      }
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
    db.updateGamesDB();
    return db.gamesList;
  }

  void checkBoxChange(int index){
      setState(() {
        if (db.gamesList[index][1] == false) {
          db.gamesList.add([db.gamesList[index][0], false]);
        } else {
          deleteField(db.gamesList.length-1);
        }
        db.gamesList[index][1] = !db.gamesList[index][1];
      });
      db.updateGamesDB();
    }

    void nextGame(){
      for (int i = 0; i < db.gamesList.length; i++) {
        if (db.gamesList[i][1] == false) {
          checkBoxChange(i);
          break;
        }
      }
    }

  //Delete Game
  void deleteField(int index){
    setState(() {
      db.gamesList.removeAt(index);
    });
    db.updateGamesDB();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Next"),
        backgroundColor: Colors.red[300],
        icon: const Icon(Icons.change_circle_outlined),
        onPressed: () => nextGame(),
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
                  onChanged: (value) => checkBoxChange(index),
                  gameCompleted: db.gamesList[index][1],
                );
              }
          )
        ),
    );
  }
}