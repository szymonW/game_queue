import  'package:flutter/material.dart';
import 'package:game_queue/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
  //Initialize Hive
  await Hive.initFlutter();

  // Open a box
  var box = await Hive.openBox('playersbox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.cyan)
    );
  }
}