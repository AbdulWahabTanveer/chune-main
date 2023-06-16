import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../Useful_Code/utils.dart';
import '../../models/current_user.dart';
import '../Profile.dart';
import 'FollowCard.dart';

import '../../models/chune.dart';

class HomePostCard extends StatelessWidget {
  final Chune post;

  final VoidCallback likePost;

  final VoidCallback listenPost;

  const HomePostCard(this.post, {Key key, this.likePost, this.listenPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              pushTo(context, UserProfileScreen(post.userId));
            },
            child: Row(
              children: [
                AvatarImage(post.userImage, 17),
                SizedBox(
                  width: 10,
                ), //Profile Image
                Text(
                  post.username,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ), //Username
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: post.source == MusicSourceType.apple?shrink(post.albumArt):post.albumArt,
                //post.albumArt,
                height: 370,
                width: 370,
              ),
            ),
            onDoubleTap: likePost,
            onTap: listenPost,
          ), //Album art
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${post.songName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${post.artistName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ), //Song Name/Artist

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${post.likeCount}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(
                          post.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: post.isLiked ? Colors.red : Colors.black),
                      onPressed: likePost,
                      padding: EdgeInsets.all(0),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  String shrink(String albumArt) {
    final list = albumArt.split('/');
    final newL = list.removeLast().split('.');
    newL[0] = "600x600bb";
    list.add(newL.join('.'));
    return list.join("/");
  }
}
