import  'package:flutter/material.dart';
import 'package:game_queue/db/adapter/gamesAdapter.dart';
import 'package:game_queue/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/game.dart';



void main() async {
  //Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter<Game>(GamesAdapter());

  // Open a box
  var box = await Hive.openBox('playersbox');
  var games = await Hive.openBox('games');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: const TextTheme(bodyMedium:
          TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.black,
          ),
        )
    );
  }
}