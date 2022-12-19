import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/Useful_Code/utils.dart';

import '../../core/bloc/music_player/music_player_bloc.dart';
import '../Notifications.dart';
import '../Player.dart';

class PlayerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        if (state is MusicPlayerLoaded) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlayerScreen()));
            },
            child: AnimatedContainer(
              color: Colors.white,
              duration: Duration(seconds: 1),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                      child: SliderTheme(
                        child: Slider(
                          value: state.currentDuration.inSeconds.toDouble() >
                                  state.totalDuration.inSeconds.toDouble()
                              ? state.totalDuration.inSeconds.toDouble()
                              : state.currentDuration.inSeconds.toDouble(),
                          max: state.totalDuration.inSeconds.toDouble(),
                          onChanged: null,
                        ),
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.pink,
                          inactiveTrackColor: Colors.white.withOpacity(0.3),
                          trackShape: SpotifyMiniPlayerTrackShape(),
                          trackHeight: 2,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                '${state.post.albumArt}',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 5,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.post.songName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${state.post.artistName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: IconButton(
                                  padding: EdgeInsets.all(15),
                                  onPressed: () {
                                    context
                                        .read<MusicPlayerBloc>()
                                        .add(ChangeStateEvent(state.playing));
                                  },
                                  icon: Icon(
                                      state.playing
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.black),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is MusicPlayerLoading) {
          return Container(
            height: 70,
            color: Colors.white,
            child: loader(),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
