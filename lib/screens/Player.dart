//To God be the Glory

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/screens/NavScreen.dart';
import 'package:newapp/screens/UserScreens/UserProfile.dart';
import 'package:newapp/screens/globalvariables.dart';

import '../core/bloc/music_player/music_player_bloc.dart';
import 'UserProfile.dart';
//import 'Widgets/SongPlaying.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreen createState() => _PlayerScreen();
}

class _PlayerScreen extends State<PlayerScreen> {
  bool liked = false;
  int likeCount =
  homePosts.map((post) => post.likeCount).elementAt(selectedPost);
  var likeColor = Colors.grey;

  isLiked() {
    setState(() {
      if (liked == false) {
        setState(() {
          liked = true;
          likeColor = Colors.red;
          likeCount++;
          //.add()
        });
      } else {
        setState(() {
          liked = false;
          likeColor = Colors.grey;
          likeCount--;
          //.remove()
        });
      }
    });
  }

  playpreviousSong() {
    setState(() {
      if (selectedPost == 0) {
        setState(() {
          selectedPost = (homePostListlength - 1);
        });
      } else {
        setState(() {
          selectedPost--;
        });
      }
      likeCount =
          homePosts.map((post) => post.likeCount).elementAt(selectedPost);
    });
    context
        .read<MusicPlayerBloc>()
        .add(SetAudioEvent(homePosts.elementAt(selectedPost)));
  }

  playnextSong() {
    setState(() {
      if (selectedPost == (homePostListlength - 1)) {
        setState(() {
          selectedPost = 0;
        });
      } else {
        setState(() {
          selectedPost++;
        });
      }
      likeCount =
          homePosts.map((post) => post.likeCount).elementAt(selectedPost);
      context
          .read<MusicPlayerBloc>()
          .add(SetAudioEvent(homePosts.elementAt(selectedPost)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        if (state is MusicPlayerLoaded) {
          return Scaffold(
              body: Column(
                children: [
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            if (selectedIndex == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavScreen()),
                              );
                            } else {
                              setState(() {
                                selectedIndex = 1;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavScreen()),
                                );
                              });
                            }
                          }),
                      Center(
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile()),
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage('${state.post.albumArt}'),
                              radius: 35,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '${state.post.artistName}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(width: 50)
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          '${state.post.albumArt}',
                          height: 370,
                          width: 370,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('${state.currentDuration}'.substring(2, 7)),
                        Flexible(
                          flex: 2,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.blue,
                              inactiveTrackColor: Colors.blue.withOpacity(0.3),
                              thumbColor: Colors.blue,
                              overlayColor: Colors.blue.withOpacity(0.3),
                              trackHeight: 2,
                              thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 4),
                            ),
                            child: Slider(
                              value: state.currentDuration.inSeconds.toDouble(),
                              max: state.totalDuration.inSeconds.toDouble(),
                              onChanged: (newPosition) {
                                context.read<MusicPlayerBloc>().add(
                                    SetPositionEvent(
                                        duration: Duration(
                                            seconds: newPosition.toInt())));
                              },
                            ),
                          ),
                        ),
                        Text('${state.totalDuration}'.substring(2, 7)),
                      ],
                    ),
                  ), //Album art
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.post.songName}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${state.post.artistName}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ), //Song Name/Artist

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$likeCount',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            IconButton(
                              icon: Icon(
                                  liked ? Icons.favorite : Icons.favorite_border,
                                  color: likeColor),
                              onPressed: () {
                                isLiked();
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: IconButton(
                          icon: Icon(
                            Icons.fast_rewind_rounded,
                            size: 80,
                          ),
                          onPressed: () {
                            playpreviousSong();
                          },
                        ),
                      ),
                      SizedBox(
                          child: InkWell(
                            onTap: () {
                              context.read<MusicPlayerBloc>().add(ChangeStateEvent());
                            },
                            child: Icon(
                              state.playing
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 80,
                            ),
                          )),
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: IconButton(
                          icon: Icon(
                            Icons.fast_forward_rounded,
                            size: 80,
                          ),
                          onPressed: () {
                            playnextSong();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ));
        }
        return Container();
      },
    );
  }
}
