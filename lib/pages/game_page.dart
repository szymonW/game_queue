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

  @override
  void initState() {
    if (_playersBox.get("players") != null) {
      db.loadDB();
    }
    super.initState();
  }

  List createList () {
    List tempList = List.from(db.playerList);
    var tempEntries = <dynamic>[];
      for (var i in db.playerList) {
        tempList.removeAt(0);
        for (var j in tempList) {
          tempEntries.add('${i[0]} vs ${j[0]}');
        }
      }
    // for mix_games in range(len(temp_games.keys())):
    // if (mix_games+1) % 2:
    // games[mix_games+1] = temp_games[pro_iter_games]
    // pro_iter_games += 1
    // else:
    // games[mix_games+1] = temp_games[len(temp_games.keys())-rev_iter_games]
    // rev_iter_games += 1
    // iter_games += 1
    return tempEntries;
  }

  int colorCode(index) {
    num ireturn = 700-index*100;
    if (index <= 6) {
      return ireturn.toInt();
    }else{
      return colorCode(index-6);
    }
  }

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
              itemCount: createList().length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 45,
                  color: Colors.cyan[colorCode(index)],
                  child: Center(child: Text('${createList()[index]}')),
                );
              }
          )
        ),
    );
  }
}