import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:newapp/screens/Widgets/Post.dart';

bool audioPlaying = false;
bool homePage = false;
int selectedPost = 0;
int selectedIndex = 0;
int likeCount = homePosts.map((post) => post.likeCount).elementAt(selectedPost);
int whotoFollowlistlength = whoToFollowList.length;
int homePostListlength = homePosts.length;
// int chuneListLength = chuneList.length;

List homePosts=[];
List whoToFollowList;

