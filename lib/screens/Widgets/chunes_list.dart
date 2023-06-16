import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../responsive.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../models/chune.dart';
import '../../repositories/home_page_repo.dart';
import '../../repositories/profile_repository.dart';
import 'Post.dart';
import 'home_post.dart';

class ChunesListWidget extends StatefulWidget {
  @override
  State<ChunesListWidget> createState() => _ChunesListWidgetState();
}

class _ChunesListWidgetState extends State<ChunesListWidget> {
  static int keyL = 0;
  final repo = GetIt.I.get<HomePageRepository>();
  final profileRepo = GetIt.I.get<ProfileRepository>();

  final refreshChangeListener = GetIt.I.get<PaginateRefreshedChangeListener>();

  @override
  void initState() {
    refreshChangeListener.addListener(_onRefresh);
    super.initState();
  }

  @override
  void dispose() {
    refreshChangeListener.removeListener(_onRefresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      key: ValueKey(keyL),
      onLoaded: (p0) {},
      listeners: [
        refreshChangeListener,
      ],
      itemBuilder: (context, documentSnapshots, index) {
        final chune = Chune.fromMap(documentSnapshots[index].data() as Map)
            .copyWith(id: documentSnapshots[index].id);
        return Container(
          child: HomePostWidget(
            chune,
            List<Chune>.from(
              documentSnapshots.map(
                (e) => Chune.fromMap(e.data() as Map).copyWith(id: e.id),
              ),
            ),
            (post, likePost, listenPost) => HomePostCard(
              post,
              listenPost: listenPost,
              likePost: likePost,
            ),
            (c) =>
                profileRepo
                    .getMyCachedProfile()
                    .followings
                    .contains(c.userId) ||
                c.userId == profileRepo.getMyCachedProfile().id,
          ),
        );
      },
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
          horizontal: largerThan(context, layout: TABLET) ? 150 : 0),
      physics: const NeverScrollableScrollPhysics(),
      query: repo.homePageChunesQuery,
      itemBuilderType: PaginateBuilderType.listView,
    );
  }

  void _onRefresh() {
    setState(() {
      keyL = DateTime.now().millisecondsSinceEpoch;
    });
  }
}
