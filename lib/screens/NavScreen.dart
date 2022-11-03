import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/screens/Home.dart';
import 'package:newapp/screens/Notifications.dart';
import 'package:newapp/screens/ShareAChune.dart';
import 'package:newapp/screens/UserProfile.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:newapp/screens/chat_screen.dart';
import 'package:newapp/screens/search_screen.dart';

import '../auth_flow/app/bloc/app_bloc.dart';
import '../core/bloc/notification_counter/notification_counter_bloc.dart';
import '../core/bloc/profile/profile_bloc.dart';
import 'Widgets/player_panel.dart';

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
    NotificationsScreen(),
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
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'chune',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(children: [
        Expanded(child: _widgetOptions.elementAt(selectedIndex)),
        Positioned(bottom: 0, child: PlayerPanel())
      ]),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          // GetIt.I.get<CloudFunctionsService>().sendNotification();
          // return;
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
            icon: Stack(
              children: [
                Icon(Icons.notifications),
                if (selectedIndex != 1)
                  BlocBuilder<NotificationCounterBloc, int>(
                    builder: (context, state) {
                      if (state > 0) {
                        return Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 14,
                            width: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              '$state',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  )
              ],
            ),
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
            label: 'Profile',
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
