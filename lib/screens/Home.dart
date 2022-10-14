///import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/screens/Player.dart';

//import 'package:newapp/screens/UserScreens/UserProfile.dart';
import 'package:newapp/screens/ViewAllAccounts.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:newapp/screens/Widgets/Post.dart';
import 'package:newapp/screens/globalvariables.dart';

import '../core/bloc/music_player/music_player_bloc.dart';
import 'Widgets/AudioPlayer.dart';
import 'Widgets/player_panel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    ///The lists are declared one for the Home posts and one for the user accounts

    whoToFollowList = [];
    homePosts = [];

    whoToFollowList.add(
      Follow(
        profilePic: 'images/chune.jpeg',
        userName: 'chuneapp',
        chuneCount: '1000 chunes shared',
        isFollowing: false,
      ),
    );

    whoToFollowList.add(
      Follow(
        profilePic: 'images/chune.jpeg',
        userName: 'chuneapp',
        chuneCount: '1000 chunes shared',
        //
        isFollowing: false,
      ),
    );

    whoToFollowList.add(
      Follow(
        profilePic: 'images/MUSIC.jpeg',
        userName: 'ComplexMUSIC',
        chuneCount: '123 Chunes Shared',
        //
        isFollowing: false,
      ),
    );
    whoToFollowList.add(
      Follow(
        profilePic: 'images/Skepta.jpeg',
        userName: 'Skepta',
        chuneCount: '891 Chunes Shared',
        isFollowing: false,
      ),
    );
    whoToFollowList.add(
      Follow(
        profilePic: 'images/MUSIC.jpeg',
        userName: 'ComplexMUSIC',
        chuneCount: '123 Chunes Shared',
        isFollowing: false,
      ),
    );
    whoToFollowList.add(
      Follow(
        profilePic: 'images/MUSIC.jpeg',
        userName: 'ComplexMUSIC',
        chuneCount: '123 Chunes Shared',
        isFollowing: false,
      ),
    );
    whoToFollowList.add(
      Follow(
        profilePic: 'images/MUSIC.jpeg',
        userName: 'ComplexMUSIC',
        chuneCount: '123 Chunes Shared',
        isFollowing: false,
      ),
    );

    homePosts.add(
      PostDetails(
        profilePic:
            'https://static.independent.co.uk/2021/11/11/09/Screenshot%202021-11-11%20at%202.59.20%20PM.png?quality=75&width=990&auto=webp&crop=982:726,smart',
        userName: 'jaden',
        albumArt:
            'https://images.genius.com/fadacd1c3ee9294c29861feee8812ffa.1000x1000x1.jpg',
        url:
            'https://open.spotify.com/track/1lxs63LaZX1wHBr0qIt5oK?si=1bdea75cf58c4748',
        songName: 'Rainbow Bap',
        artistName: 'Jaden Smith',
        likeCount: 234,
        isLiked: false,
      ),
    );

    homePosts.add(
      PostDetails(
        profilePic:
            'https://static.standard.co.uk/s3fs-public/thumbnails/image/2020/09/11/09/wdl-screen-big-mike-100920-945pm.jpg?width=1200',
        userName: 'stormzy',
        albumArt: 'https://m.media-amazon.com/images/I/71tqDp4Za8L._SS500_.jpg',
        url:
            'https://open.spotify.com/track/1lxs63LaZX1wHBr0qIt5oK?si=1bdea75cf58c4748',
        songName: 'SURF',
        artistName: 'Xavier',
        likeCount: 234,
        isLiked: false,
      ),
    );

    homePosts.add(
      PostDetails(
        profilePic:
            'https://static.standard.co.uk/s3fs-public/thumbnails/image/2020/09/11/09/wdl-screen-big-mike-100920-945pm.jpg?width=1200',
        userName: 'stormzy',
        albumArt: 'https://m.media-amazon.com/images/I/71OHttWfTuL._SS500_.jpg',
        url: '',
        songName: 'Greaze Mode',
        artistName: 'Skepta, Nafe Smallz',
        likeCount: 1011,
        isLiked: false,
      ),
    );

    //https://pbs.twimg.com/media/EbMPslEXsAQER_U.jpg
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WhoToFollowList(),
              ChunesListWidget(),
              SizedBox(height: 100)
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: PlayerPanel(),
        )
      ]),
    );
  }

  isFollowing(int index) {
    final card = whoToFollowList[index];
    setState(() {
      card.isFollowing = !card.isFollowing;
    });
  }
}

class ChunesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: homePosts.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              HomePostWidget(
                homePosts[index],
                () => isLiked(index),
                () => isSelected(index),
              ),
            ],
          );
        },
      ),
    );
  }

  isSelected(int index) {
    audioPlaying = true;
    selectedPost = index;
  }

  isLiked(int index) {
    final post = homePosts[index];

    post.isLiked = !post.isLiked;

    if (post.isLiked) {
      post.likeCount++;
      post.likeColor = Colors.red;
    } else {
      post.likeCount--;
      post.likeColor = Colors.grey;
    }
  }
}

class WhoToFollowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              GestureDetector(
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewAllAccounts(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 350,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: whoToFollowList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  FollowCard(
                    whoToFollowList[index],
                    () => isFollowing(index),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  isFollowing(int index) {}
}
