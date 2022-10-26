import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/screens/Player.dart';
import 'package:newapp/screens/Widgets/player_panel.dart';
import 'package:newapp/screens/globalvariables.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../repositories/profile_repository.dart';
import 'UserScreens/Userprofile.dart';

class Notifications extends StatefulWidget {
  @override
  _Notifications createState() => _Notifications();
}

class _Notifications extends State<Notifications> {
  List notifications;

  void initState() {
    super.initState();
    notifications = <Notification>[];

    notifications.add(
      Notification(
        profilePic: 'images/Not3s.jpeg',
        userName: 'username',
        albumArt: 'images/PND.jpg',
      ),
    );

    notifications.add(
      Notification(
        profilePic: 'images/MUSIC.jpeg',
        userName: 'username',
        albumArt: 'images/PND.jpg',
      ),
    );

    notifications.add(
      Notification(
        profilePic: 'images/MUSIC.jpeg',
        userName: 'username',
        albumArt: 'images/PND.jpg',
      ),
    );
  }

  isliked() {
    ///coming soon
  }

  isFollowed() {
    ///coming soon
  }

  final repo = GetIt.I.get<ProfileRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, documentSnapshots, index) {
          return NotificationPost(
            notifications[index],
          );
        },
        query: repo.myNotificationsQuery,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}

class Notification {
  Notification({
    this.profilePic,
    this.userName,
    this.albumArt,
  });

  String profilePic;
  String userName;
  String albumArt;
}

class NotificationPost extends StatelessWidget {
  NotificationPost(this.post);

  final Notification post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(post.profilePic),
                                    radius: 17,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${post.userName} liked your chune',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              post.albumArt,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 390,
              height: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined,
                              color: Colors.blue),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(post.profilePic),
                                    radius: 17,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${post.userName} followed you',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 390,
              height: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.library_music, color: Colors.blue),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(post.profilePic),
                                    radius: 17,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${post.userName} listened to your chune',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 390,
              height: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
      ],
    );
  }
}

class SpotifyMiniPlayerTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
