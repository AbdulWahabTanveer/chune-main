import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/Useful_Code/constants.dart';
import 'package:newapp/Useful_Code/utils.dart';
import 'package:newapp/core/bloc/nav_bloc/nav_bloc.dart';
import 'package:newapp/repositories/profile_repository.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../auth_flow/app/bloc/app_bloc.dart';
import '../core/bloc/profile/profile_bloc.dart';
import '../models/chune.dart';
import 'ShareAChune.dart';
import 'UserScreens/EditProfileScreen.dart';
import 'UserScreens/LikedChunes.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfileScreen> {
  var chuneCount = 0;
  int followersCount = 0;
  int followingCount = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navigator.canPop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: BackButton(
                color: Colors.black,
              ))
          : null,
      body: ListView(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadedState && state.profile != null) {
                print(">>>>>>>>>>>>>>>${state.profile}");
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AvatarImage(
                        state.profile.image,
                        35,
                      ),
                      SizedBox(height: 16),
                      Text('@${state.profile.username}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          )),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CountWidget(
                              value: state.profile.chunesShared ?? 0,
                              label: "Chunes",
                            ),
                            CountWidget(
                              value: state.profile.followersCount ?? 0,
                              label: "Followers",
                            ),
                            CountWidget(
                              value: state.profile.followingCount ?? 0,
                              label: "Following",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(100))),
                                child: TextButton(
                                  child: Text('Edit Profile',
                                      style: TextStyle(
                                          fontSize: 21, color: Colors.blue)),
                                  onPressed: () {
                                    context.read<NavBloc>().add(5);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Text("ERROR $state");
            },
          ),
          MyChunesList(),
          SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}

class MyChunesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = context.read<AppBloc>().state.user.id;
    return PaginateFirestore(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, documentSnapshots, index) {
        final chune = Chune.fromMap(documentSnapshots[index].data() as Map)
            .copyWith(id: documentSnapshots[index].id);

        return Dismissible(
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            if (direction == DismissDirection.endToStart) {
              return showDialog<bool>(
                  context: context,
                  builder: (c) => AlertDialog(
                        content: Text(
                          "Are you sure you want to delete this chune? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text("Delete"))
                        ],
                      ));
            }
            return Future.value(false);
          },
          background: Container(
            color: Colors.red,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: Container(),
              ),
              Text(
                "Delete",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
          onDismissed: (direction) async {
            context.read<ProfileBloc>().add(DeleteChuneEvent(chune.id));
          },
          key: ValueKey(chune.id),
          child: Container(
              color: Colors.white,
              child: ChuneRow(chune,
                  chunes: List<Chune>.from(documentSnapshots.map((e) =>
                      Chune.fromMap(e.data() as Map).copyWith(id: e.id))))),
        );
      },
      itemBuilderType: PaginateBuilderType.listView,
      onError: (e) => Text('$e'),
      onEmpty: Column(
        children: [
          InkWell(
            onTap: () {
              pushTo(context, ShareAChune());
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
              width: double.infinity,
              child: Material(
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.pink,
                      size: 80,
                    ),
                    Text(
                      "Share\na\nCHUNE",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.pink),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Click here",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            .copyWith(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      isLive: true,
      query: FirebaseFirestore.instance
          .collection(chunesCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true),
    );
  }
}

class CountWidget extends StatelessWidget {
  final int value;
  final String label;

  const CountWidget({Key key, this.value, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 10),
        Text(
          '$label',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
