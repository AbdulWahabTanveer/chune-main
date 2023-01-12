import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/core/bloc/music_player/music_player_bloc.dart';
import 'package:newapp/core/bloc/nav_bloc/nav_bloc.dart';
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
import 'UserScreens/EditProfileScreen.dart';
import 'Widgets/player_panel.dart';

class NavScreen extends StatefulWidget {
  final int index;

  const NavScreen({Key key, this.index = 0}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreen();
}

class _NavScreen extends State<NavScreen> {
  // int selectedIndex;
  var iconCOlor = Colors.grey;
  final homeC = ScrollController();
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    NotificationsScreen(),
    SearchScreen(),
    ChatScreen(),
    MyProfileScreen(),
    EditProfile(),
  ];

  @override
  void initState() {
    context.read<MusicPlayerBloc>().add(GetAudioEvent());
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      GetIt.I.get<ScrollController>().animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    }
    context.read<NavBloc>().add(index);
  }

  @override
  Widget build(BuildContext context) {
    // final profile = context.read<ProfileBloc>().state;
    return BlocBuilder<NavBloc, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
            toolbarHeight: 70,
            title: Text(
              'chune',
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          body: _widgetOptions.elementAt(selectedIndex),
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
              ),
              PlayerPanel()
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
            backgroundColor: Colors.pink,
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
                icon: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profile) {
                    return AvatarImage(
                        (profile is ProfileLoadedState)
                            ? profile.profile?.image
                            : 'https://media.vogue.co.uk/photos/6041f07c107e7ce55db43e7d/2:3/w_1600,c_limit/wiz.jpg',
                        13);
                  },
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex <= 4 ? selectedIndex : 4,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
