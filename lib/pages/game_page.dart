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
    List tempEntries = [];
    List entries = [];
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
        entries.add(tempEntries[proIterGames++]);
      }else{
        entries.add(tempEntries[tempEntries.length-revIterGames++]);
      }
    }
    return entries;
  }

  int colorCode(index, {rev = true}) {
    int startValue = rev ? 700 : 100;
    int indexSign = rev ? -1 : 1;
    num iReturn = startValue+indexSign*index*100;
    if (index <= 6) {
      return iReturn.toInt();
    }else{
      return colorCode(index-6, rev: !rev);
    }
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