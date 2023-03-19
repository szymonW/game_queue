import 'package:hive_flutter/hive_flutter.dart';

// Todo: Refactor DB!
// https://gist.github.com/erdiizgi/df4504b60c949a34e27f00e2fab042c2#file-product-dart
// https://developerb2.medium.com/relationships-in-hive-flutter-cb8cadf05c06

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