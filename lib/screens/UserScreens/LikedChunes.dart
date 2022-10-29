import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/repositories/profile_repository.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../models/chune.dart';
import '../Widgets/Post.dart';

class LikedChunes extends StatefulWidget {
  @override
  _LikedChunes createState() => _LikedChunes();
}

class _LikedChunes extends State<LikedChunes> {
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
      body: PaginateFirestore(
        itemBuilder: (context, documentSnapshots, index) {
          final chune = Chune.fromMap(documentSnapshots[index].data() as Map)
              .copyWith(id: documentSnapshots[index].id);
          return Container(
            child: ChuneRow(
              chune,
            ),
          );
        },
        shrinkWrap: true,
        onError: (p0) => Text('$p0'),
        query: repo.likedChunesQuery,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}

class ChuneRow extends StatelessWidget {
  final Chune post;

  const ChuneRow(this.post, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePostWidget(
      post,
      (chune, likePost, listenPost) => InkWell(
        splashColor: Colors.white,
        onTap: listenPost,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      chune.albumArt,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chune.songName,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        chune.artistName.length > 24
                            ? "${chune.artistName.substring(0, 23)}.."
                            : chune.artistName,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
