import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Game extends HiveObject{

  @HiveField(0)
  int? idg;

  @HiveField(1)
  String? idPlayer1;

  @HiveField(2)
  String? idPlayer2;

  @HiveField(3)
  bool? played;

}