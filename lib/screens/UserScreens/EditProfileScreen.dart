import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/screens/Player.dart';
import 'package:newapp/screens/UserScreens/ChangeUsername.dart';
import 'package:newapp/screens/UserScreens/UploadProfilePhoto.dart';
import 'package:newapp/screens/globalvariables.dart';
import 'package:newapp/screens/UserScreens/LikedChunes.dart';

import '../../auth_flow/app/bloc/app_bloc.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
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
      body: Stack(children: [
        Column(children: [
          InkWell(
            splashColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LikedChunes()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Liked chunes'),
                  Icon(Icons.chevron_right_outlined)
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangeUsername()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Change username'),
                  Icon(Icons.chevron_right_outlined)
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadProfilePhoto()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upload profile photo'),
                  Icon(Icons.chevron_right_outlined)
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.white,
            onTap: () {
              context.read<AppBloc>().add(AppLogoutRequested());
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Log out'),
                  Icon(Icons.exit_to_app)
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
