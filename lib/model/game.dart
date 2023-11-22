import 'dart:math';

import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Game extends HiveObject{

  static int maxInt = 2^16;

  @HiveField(1,defaultValue: 0)
  late int id;
  @HiveField(2, defaultValue: '')
  late String playerOne;
  @HiveField(3, defaultValue: '')
  late String playerTwo;
  @HiveField(4, defaultValue: '')
  late String winner = '';

  Game.newGame(String playerOne, String playerTwo) {
    this.playerOne = playerOne;
    this.playerTwo = playerTwo;
    this.id = new Random().nextInt(maxInt);
  }


  static Game addRevenge(Game game) {
    var newGame = Game.newGame(game.playerTwo, game.playerOne);
    game.id = new Random().nextInt(maxInt);
    return newGame;
  }

  setWinner(String playerName) {
    winner = playerName;
  }

  Game (this.id, this.playerOne, this.playerTwo, this.winner){
    this.id = id;
    this.playerOne = playerOne;
    this.playerTwo = playerTwo;
    this.winner = winner;
  }

  @override
  String toString(){
    return'🎱${playerOne} vs ${playerTwo}';
  }

  bool isFinished(){
    return winner == playerOne || winner == playerTwo;
  }

  void resetWinner(){
    winner = "";
  }

  bool isRevenge(Game game) {
    return game.playerTwo == playerOne && game.playerOne == playerTwo && !isFinished();
  }

}