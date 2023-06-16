///import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/responsive.dart';
import 'package:newapp/screens/Player.dart';

//import 'package:newapp/screens/UserScreens/UserProfile.dart';
import 'package:newapp/screens/ViewAllAccounts.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:newapp/screens/Widgets/Post.dart';
import 'package:newapp/screens/globalvariables.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../core/bloc/music_player/music_player_bloc.dart';
import 'Widgets/AudioPlayer.dart';
import 'Widgets/chunes_list.dart';
import 'Widgets/player_panel.dart';
import 'Widgets/who_to_follow_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("STATE >>>>>>>>>>>> $state");
   if(state == AppLifecycleState.detached){
     context.read<MusicPlayerBloc>().add(StopAudioEvent());
   }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        RefreshIndicator(
          onRefresh: () async {
            GetIt.I.get<PaginateRefreshedChangeListener>().refreshed = true;
          },
          child: SingleChildScrollView(
            controller: GetIt.I.get<ScrollController>(),

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
        ),
      ]),
    );
  }
}



/*
*    ///The lists are declared one for the Home posts and one for the user accounts

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
    */
