import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../db/database.dart';
import '../utils/app_buttons.dart';
import '../utils/games_list.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({super.key});

  @override
  State<GameRoute> createState() => _GameRoute();
}

class _GameRoute extends State<GameRoute> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  //reference to hive box
  final _playersBox = Hive.box('playersBox');
  PalyersDataBase db = PalyersDataBase();

  void _animateToIndex(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 3),
      curve: Curves.fastOutSlowIn,
    );
  }

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
        tempEntries.add('🎱${i[0]} vs ${j[0]}');
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
          var gamename = db.gamesList[index][0];
          if (gamename.substring(0, 2) == "🎱"){
            gamename = "${gamename.substring(2)}🎱";
          } else {
            gamename = "🎱${gamename.substring(0, gamename.length-2)}";
          }
          db.gamesList.add([gamename, false, false]);
          if (db.gamesList[index][2] == true) {
            for (var i = index + 1; i < db.gamesList.length; i++) {
              if (db.gamesList[i][1] == false) {
                _animateToIndex(i);
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
    _animateToIndex(0);
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
            padding: const EdgeInsets.only(
                top: 9,
                bottom: 6),
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
        backgroundColor: Colors.black,
        icon: const Icon(Icons.change_circle_outlined),
        onPressed: () => nextGame(),
      ),

      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 40.0, right: 10, left: 10, top: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  color: Colors.white,
                  child: ScrollablePositionedList.builder(
                            itemScrollController: _itemScrollController,
                            // padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                            itemCount: db.gamesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GamesList(
                                playersNames: db.gamesList[index][0],
                                index: index,
                                colorCode: colorCode(index, db.gamesList[index][1]),
                                onChanged: (value) => checkBoxChange(index),
                                gameCompleted: db.gamesList[index][1],
                              );
                            }),
                )
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              heroTag: "floatingArrowUp",
              mini: true,
              onPressed: () => _animateToIndex(0),
              child: const Icon(Icons.arrow_upward),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: "floatingArrowDown",
              mini: true,
              onPressed: () => _animateToIndex(db.gamesList.length),
              child: const Icon(Icons.arrow_downward),
            ),
          ),
        ]));
  }
}