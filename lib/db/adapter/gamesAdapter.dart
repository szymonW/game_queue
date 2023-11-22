import 'dart:ffi';

import 'package:game_queue/model/game.dart';
import 'package:hive/hive.dart';

class GamesAdapter extends TypeAdapter<Game>{
  @override
  Game read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game(
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  final typeId = 0;

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.playerOne)
      ..writeByte(3)
      ..write(obj.playerTwo)
      ..writeByte(4)
      ..write(obj.winner)
    ;  }

}