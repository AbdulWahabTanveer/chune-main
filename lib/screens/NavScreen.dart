import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/core/bloc/login/login_bloc.dart';
import 'package:newapp/screens/Home.dart';
import 'package:newapp/screens/Notifications.dart';
import 'package:newapp/screens/Profile.dart';
import 'package:newapp/screens/ShareAChune.dart';
import 'package:newapp/screens/UserProfile.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:newapp/screens/chat_screen.dart';
import 'package:newapp/screens/search_screen.dart';

import '../core/bloc/profile/profile_bloc.dart';

class NavScreen extends StatefulWidget {
  final int index;

  const NavScreen({Key key, this.index = 0}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreen();
}

class _NavScreen extends State<NavScreen> {
  int selectedIndex;
  var iconCOlor = Colors.grey;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Notifications(),
    SearchScreen(),
    ChatScreen(),
    MyProfileScreen()
  ];

  @override
  void initState() {
    selectedIndex = widget.index;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileBloc>().state;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 70,
        title: Center(
          child: Text(
            'chune',
            style: TextStyle(
                color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShareAChune(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.teal),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: AvatarImage(
                (profile is ProfileLoadedState)
                    ? profile.profile?.image
                    : 'https://media.vogue.co.uk/photos/6041f07c107e7ce55db43e7d/2:3/w_1600,c_limit/wiz.jpg',
                18),
            label: 'Profie',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
