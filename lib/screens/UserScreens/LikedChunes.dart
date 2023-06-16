import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import '../../repositories/profile_repository.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../models/chune.dart';
import '../Widgets/Post.dart';
import '../Widgets/player_panel.dart';

class LikedChunes extends StatefulWidget {
  @override
  _LikedChunes createState() => _LikedChunes();
}

class _LikedChunes extends State<LikedChunes> {
  int page = 1;

  Widget build(BuildContext context) {
    final repo = GetIt.I.get<ProfileRepository>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          'chune',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
          ),
          PlayerPanel()
        ],
      ),
      body: SingleChildScrollView(
        child: PaginateFirestore(
          onLoaded: (pl) {
            // Fluttertoast.showToast(msg: "${page++}");
          },
          itemBuilder: (context, documentSnapshots, index) {
            final chune = Chune.fromMap(documentSnapshots[index].data() as Map)
                .copyWith(id: documentSnapshots[index].id);
            return Container(
              child: ChuneRow(chune,
                  chunes: List<Chune>.from(
                    documentSnapshots.map(
                      (e) => Chune.fromMap(e.data() as Map).copyWith(id: e.id),
                    ),
                  ),
                  filter: (c) =>
                      repo.getMyCachedProfile().likedChunes.contains(c.id)),
            );
          },
          // shrinkWrap: true,
          isLive: true,
          itemsPerPage: 200,
          onEmpty: Text('No liked chunes'),
          onError: (p0) => Text('$p0'),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          query: repo.likedChunesQuery,
          itemBuilderType: PaginateBuilderType.listView,
        ),
      ),
    );
  }
}

class ChuneRow extends StatelessWidget {
  final Chune post;

  final List<Chune> chunes;
  final bool Function(Chune c) filter;

  const ChuneRow(this.post, {Key key, this.chunes, this.filter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePostWidget(
        post,
        chunes,
        (chune, likePost, listenPost) => InkWell(
              splashColor: Colors.white,
              onTap: listenPost,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        chune.albumArt,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${chune.songName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            chune.artistName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: likePost,
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        chune.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: chune.isLiked
                            ? Colors.red
                            : Colors.grey.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        filter);
  }
}
