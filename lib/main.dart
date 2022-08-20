///To God be the Glory

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newapp/screens/NavScreen.dart';
import 'core/bloc/music_player_bloc.dart';
import 'screens/LoginScreens/Login.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MusicPlayerBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavScreen(),
        // Login(),
      ),
    );
  }
} 