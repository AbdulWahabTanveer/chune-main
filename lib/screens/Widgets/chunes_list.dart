import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../core/bloc/music_player/music_player_bloc.dart';
import '../../models/chune.dart';
import '../../repositories/home_page_repo.dart';
import 'Post.dart';
import 'home_post.dart';

class ChunesListWidget extends StatelessWidget {
  final repo = GetIt.I.get<HomePageRepository>();

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (context, documentSnapshots, index) {
        final chune = Chune.fromMap(documentSnapshots[index].data() as Map)
            .copyWith(id: documentSnapshots[index].id);
        return Container(
          child: HomePostWidget(
            chune,
            (post, likePost, listenPost) => HomePostCard(
              post,
              listenPost: listenPost,
              likePost: likePost,
            ),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      query: repo.homePageChunesQuery,
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}
