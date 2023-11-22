import 'package:hive_flutter/hive_flutter.dart';

import '../model/game.dart';

// Todo: Refactor DB!
// https://gist.github.com/erdiizgi/df4504b60c949a34e27f00e2fab042c2#file-product-dart
// https://developerb2.medium.com/relationships-in-hive-flutter-cb8cadf05c06

class PlayersDataBase {
  List playerList = [];
  List gamesList = [];
  //reference the hive box
  final _playersBox = Hive.box('playersbox');
  final _gamesBox = Hive.box('games');

  void loadPlayers() {
      playerList = _playersBox.get("players");
  }

  void loadGames(){
    gamesList = _gamesBox.values.toList();
  }

  void updatePlayersDB() {
    _playersBox.put("players", playerList);
  }

  void addGame(Game game) {
    _gamesBox.put(game.id, game);
  }

  void updateGamesDB(){
    gamesList.forEach((element) { addGame(element);});
  }
}