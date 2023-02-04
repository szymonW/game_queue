import 'package:flutter/material.dart';
import 'package:game_queue/utils/players_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Game Queue"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          PlayersList(),
        ],
      )
    );
  }
}