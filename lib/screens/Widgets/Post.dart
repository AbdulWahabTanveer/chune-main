import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/Useful_Code/utils.dart';
import 'package:newapp/models/chune.dart';
import 'package:provider/provider.dart';

import '../../core/bloc/home_post/home_post_bloc.dart';
import '../../core/bloc/music_player/music_player_bloc.dart';

typedef Widget ChuneCardBuilder(
    Chune post, VoidCallback likePost, VoidCallback listenPost);

class HomePostWidget extends StatelessWidget {
  final Chune post;
  final ChuneCardBuilder builder;

  const HomePostWidget(this.post, this.builder, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePostBloc()..add(LoadHomePost(post)),
      child: _HomePostWidgetContent(
        builder: builder,
      ),
    );
  }
}

class _HomePostWidgetContent extends StatelessWidget {
  final ChuneCardBuilder builder;

  const _HomePostWidgetContent({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePostBloc>();
    return BlocBuilder<HomePostBloc, HomePostState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is HomePostLoaded) {
          final post = state.post;
          final VoidCallback likePost = () => bloc.add(
                LikeHomePost(post),
              );
          final VoidCallback listenPost =
              () => context.read<MusicPlayerBloc>().add(SetAudioEvent(post));

          return builder(post, likePost, listenPost);
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
