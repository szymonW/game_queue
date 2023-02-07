import 'package:flutter/material.dart';
import 'package:game_queue/utils/players_list.dart';

import '../utils/player_dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //text controller
  final _controller = TextEditingController();

  var playerList = [];

  //Save new player
  void saveNewPlayer(){
    setState(() {
      playerList.add([_controller.text]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }
  //Add new player
  void addPlayer() {
    showDialog(
        context: context,
        builder: (context) {
          return PlayerDialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: saveNewPlayer,
          );
    });
  }

  //Delete Player
  void deleteField(int index){
    setState(() {
      playerList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Game Queue"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPlayer,
        child: const Icon(Icons.add),
      ),
      body: Container(
        // decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(40),
        //     topRight: Radius.circular(40))
        // ),
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ListView.builder(
          itemCount: playerList.length,
          itemBuilder: (context, index){
            return PlayersList(
              playerName: playerList[index][0],
              deletePlayer: (context) => deleteField(index),
            );
          },
        ),
      )
    );
  }
}