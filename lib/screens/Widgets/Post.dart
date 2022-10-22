import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/Useful_Code/utils.dart';
import 'package:newapp/models/chune.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:provider/provider.dart';

import '../../core/bloc/home_post/home_post_bloc.dart';
import '../../core/bloc/music_player/music_player_bloc.dart';

class HomePostWidget extends StatelessWidget {
  final Chune post;

  const HomePostWidget(this.post, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePostBloc()..add(LoadHomePost(post)),
      child: _HomePostWidgetContent(),
    );
  }
}

class _HomePostWidgetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePostBloc>();
    return BlocBuilder<HomePostBloc, HomePostState>(
bloc:bloc,
      builder: (context, state) {
        if (state is HomePostLoaded) {
          final post = state.post;
          return Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: <Widget>[
                Row(
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
                          fontSize: 16),
                    ), //Username
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      post.albumArt,
                      // ignore: missing_return
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Text('Your error widget...');
                      },
                      //post.albumArt,
                      height: 370,
                      width: 370,
                    ),
                  ),
                  onDoubleTap: () => bloc.add(LikeHomePost(post)),
                  onTap: () =>
                      context.read<MusicPlayerBloc>().add(SetAudioEvent(post)),
                ), //Album art
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        post.songName,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                                post.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    post.isLiked ? Colors.red : Colors.black),
                            onPressed: () {
                              bloc.add(LikeHomePost(post));
                            },
                            padding: EdgeInsets.all(0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      post.artistName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ), //Song Name/Artist
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        }
        return loader();
      },
    );
  }

}

class PostDetails {
  PostDetails(
      {this.profilePic,
      this.userName,
      this.albumArt,
      this.songName,
      this.artistName,
      this.likeCount,
      this.isLiked,
      this.isSelected,
      this.likeColor,
      this.url});

  String profilePic;
  String userName;
  String albumArt;
  String songName;
  String artistName;
  String url;
  int likeCount;
  bool isLiked;
  bool isSelected;
  var likeColor = Colors.grey;
}
