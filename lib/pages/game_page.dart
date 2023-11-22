import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../db/database.dart';
import '../model/game.dart';
import '../utils/app_buttons.dart';
import '../utils/games_list.dart';
import "package:trotter/trotter.dart";

class GameRoute extends StatefulWidget {
  const GameRoute({super.key});

  @override
  State<GameRoute> createState() => _GameRoute();
}

class _GameRoute extends State<GameRoute> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  //reference to hive box
  final _playersBox = Hive.box('playersBox');
  final _gamesBox = Hive.box('games');
  PlayersDataBase db = PlayersDataBase();

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
      db.loadPlayers();
      if (_gamesBox.get("games") != null) {
        db.loadGames();
      } else {
        createList();
      }
    }
    super.initState();
  }

  List createList () {

    List<Game> games = [];
    List playerList = List.from(db.playerList);
    final playerPerms = String,
        permutations = Combinations(2, playerList);
    for(final pair in permutations()) {
      games.add(Game.newGame(pair[0][0], pair[1][0]));
    };
    games.sort((a, b) => a.id.compareTo(b.id));

    db.gamesList.addAll(games);

    db.updateGamesDB();

    return db.gamesList;
  }

  void checkBoxChange(int index){
    setState(() {
      Game game = db.gamesList[index];
        if (game.isFinished() == false) {
          game.setWinner(game.playerOne);
          db.gamesList.add(Game.addRevenge(game));
          db.updateGamesDB();
        } else {
          deleteGame(db.gamesList.indexOf(db.gamesList.firstWhere((element) => (element as Game).isRevenge(game))));
          game.resetWinner();
          }
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
  void deleteGame(int index){
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
  Color? colorCode(index, Game game, {rev = true, realIndex = -1}) {
    realIndex = realIndex == -1 ? index : realIndex;
    int startValue = rev ? 700 : 100;
    int indexSign = rev ? -1 : 1;
    num iReturn = startValue+indexSign*index*100;
    MaterialColor color;
    if (game.isFinished()) {
      color = Colors.red;
    } else {
      color = Colors.cyan;
    }
    // if ((index == 0 && !game.isFinished())
    //     || (!(db.gamesList[index] as Game).isFinished()&&(db.gamesList[index-1] as Game).isFinished())){
    //   return Colors.green;
    // }
    if (index <= 6) {
      return color[iReturn.toInt()];
    }else{
      return colorCode(index-6, game, rev: !rev, realIndex: realIndex);
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
                                playersNames: db.gamesList[index].toString(),
                                index: index,
                                colorCode: colorCode(index, db.gamesList[index]),
                                onChanged: (value) => checkBoxChange(index),
                                gameCompleted: (db.gamesList[index] as Game).isFinished(),
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