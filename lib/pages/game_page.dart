import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db/database.dart';
import '../utils/app_buttons.dart';
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
        db.gamesList.add([tempEntries[proIterGames++], false, false]);
      }else{
        db.gamesList.add([tempEntries[tempEntries.length-revIterGames++], false, false]);
      }
    }
    db.gamesList[0][2] = true;
    db.updateGamesDB();
    return db.gamesList;
  }

  void checkBoxChange(int index){
      setState(() {
        if (db.gamesList[index][1] == false) {
          db.gamesList.add([db.gamesList[index][0], false, false]);
          if (db.gamesList[index][2] == true) {
            for (var i = index + 1; i < db.gamesList.length; i++) {
              if (db.gamesList[i][1] == false) {
                db.gamesList[i][2] = true;
                break;
              }
            }
            db.gamesList[index][2] = false;
          }
        } else {
          for (var i = 0; i < db.gamesList.length; i++) {
            if (db.gamesList[i][2] == true) {
              db.gamesList[i][2] = false;
              break;
            }
          }
            db.gamesList[index][2] = true;
          for (var i = index + 1; i < db.gamesList.length; i++) {
            if (db.gamesList[i][0] == db.gamesList[index][0] && db.gamesList[i][1]==false) {
              deleteField(i);
              break;
            }
          }
          }
          db.gamesList[index][1] = !db.gamesList[index][1];
      });
      db.updateGamesDB();
    }

    void nextGame(){
      for (int i = 0; i < db.gamesList.length; i++) {
        if (db.gamesList[i][2] == true) {
          checkBoxChange(i);
          break;
        }
      }
    }

  //Delete game
  void deleteField(int index){
    setState(() {
      db.gamesList.removeAt(index);
    });
    db.updateGamesDB();
  }

  //Delete all games
  void deleteAll() {
    setState(() {
      db.gamesList.clear();
      createList();
    });
    db.updateGamesDB();
  }

  // Add colors to tame list
  Color? colorCode(index, gameCompleted, {rev = true, realIndex = -1}) {
    realIndex = realIndex == -1 ? index : realIndex;
    int startValue = rev ? 700 : 100;
    int indexSign = rev ? -1 : 1;
    num iReturn = startValue+indexSign*index*100;
    MaterialColor color;
    if (gameCompleted == false) {
      color = Colors.cyan;
    } else {
      color = Colors.red;
    }
    if (db.gamesList[realIndex][2]){
      return Colors.green;
    } if (index <= 6) {
      return color[iReturn.toInt()];
    }else{
      return colorCode(index-6, gameCompleted, rev: !rev, realIndex: realIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('In progress'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: AppBarButtons(
              buttonName: "Reset Game",
              onPressed: deleteAll,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Next"),
        backgroundColor: Colors.red[800],
        icon: const Icon(Icons.change_circle_outlined),
        onPressed: () => nextGame(),
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
        padding: const EdgeInsets.only(bottom: 50.0),
          child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: db.gamesList.length,
              itemBuilder: (BuildContext context, int index) {
                return GamesList(
                  playersNames: db.gamesList[index][0],
                  index: index,
                  colorCode: colorCode(index, db.gamesList[index][1]),
                  onChanged: (value) => checkBoxChange(index),
                  gameCompleted: db.gamesList[index][1],
                );
              }
          )
        ),
    );
  }
}