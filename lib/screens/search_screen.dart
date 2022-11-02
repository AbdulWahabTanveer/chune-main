import 'package:flutter/material.dart';
import 'package:newapp/screens/Player.dart';
import 'package:newapp/screens/Widgets/player_panel.dart';
import 'globalvariables.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: const Text('Search coming soon'),
        ),

      ]),
    );
  }
}
