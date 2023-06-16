import 'package:flutter/material.dart';
import 'Player.dart';
import 'Widgets/player_panel.dart';
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

      ]),
    );
  }
}