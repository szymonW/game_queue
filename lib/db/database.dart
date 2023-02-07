import 'package:hive_flutter/hive_flutter.dart';

class PalyersDataBase {
  List playerList = [];
  //reference the hive box
  final _palyersBox = Hive.box('playersbox');

  void loadDB() {
    playerList = _palyersBox.get("players");
  }

  void updateDB() {
    _palyersBox.put("players", playerList);
  }
}