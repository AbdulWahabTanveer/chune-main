import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../models/notification_model.dart';
import '../repositories/profile_repository.dart';
import 'Widgets/FollowCard.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _Notifications createState() => _Notifications();
}

class _Notifications extends State<NotificationsScreen> {
  final repo = GetIt.I.get<ProfileRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, documentSnapshots, index) {
          final notification =
              NotificationModel.fromMap(documentSnapshots[index].data() as Map);
          return NotificationPost(
            notification,
          );
        },
        query: repo.myNotificationsQuery,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}

class NotificationPost extends StatelessWidget {
  NotificationPost(this.post);

  final NotificationModel post;

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
                          if (post.type == 'like')
                            Icon(Icons.favorite, color: Colors.red),
                          if (post.type == 'follow')
                            Icon(Icons.account_circle_outlined,
                                color: Colors.blue),
                          if (post.type == 'listen')
                            Icon(Icons.library_music, color: Colors.blue),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AvatarImage(
                                    post.userImage,
                                    17,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '@${post.message}',
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
                          if (post.chuneImage != null &&
                              post.chuneImage.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                post.chuneImage,
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
