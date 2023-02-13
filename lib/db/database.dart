import 'package:hive_flutter/hive_flutter.dart';

class PalyersDataBase {
  List playerList = [];
  List gamesList = [];
  //reference the hive box
  final _palyersBox = Hive.box('playersbox');

  void loadDB(String name) {
    playerList = _palyersBox.get(name);
  }

  void updateDB(String name, List listName) {
    _palyersBox.put(name, listName);
  }
}