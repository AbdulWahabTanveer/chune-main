import 'package:flutter/material.dart';
import 'package:newapp/screens/Player.dart';
import 'package:newapp/screens/Widgets/player_panel.dart';
import 'globalvariables.dart';

class ChatScreen extends StatefulWidget {

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: const Text('Chats coming soon'),
        ),
           Positioned(
          bottom: 0,
          child: PlayerPanel(),
        )
      ]),
    );
  }
}