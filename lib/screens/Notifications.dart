import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../Useful_Code/utils.dart';
import 'Profile.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../models/notification_model.dart';
import '../repositories/profile_repository.dart';
import 'Widgets/FollowCard.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _Notifications createState() => _Notifications();
}

class _Notifications extends State<NotificationsScreen> {
  @override
  void initState() {
    repo.resetNotifications();
    super.initState();
  }

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
        isLive: true,
        onEmpty: Text('No Notifications found'),
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
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                if (post.type == 'like')
                  Icon(Icons.favorite, color: Colors.red),
                if (post.type == 'follow')
                  Icon(Icons.account_circle_outlined, color: Colors.blue),
                if (post.type == 'listen')
                  Icon(Icons.library_music, color: Colors.blue),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          pushTo(
                            context,
                            UserProfileScreen(post.userId),
                          );
                        },
                        child: AvatarImage(
                          post.userImage,
                          17,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '@${post.message}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                if (post.chuneImage != null && post.chuneImage.isNotEmpty)
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
          ),
        ],
      ),
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
