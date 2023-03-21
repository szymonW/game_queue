import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Player extends HiveObject{

  @HiveField(0)
  int? idp;

  @HiveField(1)
  String? name;

}