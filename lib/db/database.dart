import 'package:hive_flutter/hive_flutter.dart';

class PalyersDataBase {
  List playerList = [];
  List gamesList = [];
  //reference the hive box
  final _palyersBox = Hive.box('playersbox');

  void loadDB(String name) {
    if (name == "players") {
      playerList = _palyersBox.get(name);
    } if (name == "games") {
      gamesList = _palyersBox.get(name);
    }
  }

  void updatePlayersDB() {
    _palyersBox.put("players", playerList);
    if (_palyersBox.get("games") != null) {
      gamesList.clear();
      _palyersBox.put("games", null);
    }
  }

  void updateGamesDB() {
    _palyersBox.put("games", gamesList);
  }
}