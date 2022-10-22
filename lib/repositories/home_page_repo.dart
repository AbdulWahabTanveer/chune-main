import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/Useful_Code/constants.dart';
import 'package:newapp/models/chune.dart';
import 'package:newapp/models/profile_model.dart';

import '../services/cloud_functions_service.dart';

abstract class HomePageRepository {
  Future<List<ProfileModel>> loadUserSuggestions();

  Query get homePageChunesQuery;

  Query get allUserAccountsQuery;

  Future followUser(ProfileModel user);

  Future unFollowUser(ProfileModel user);

  Future likeChune(Chune user);

  Future unLikeChune(Chune user);
}

class HomePageRepositoryImpl extends HomePageRepository {
  final fireStore = FirebaseFirestore.instance;
  final functions = GetIt.I.get<CloudFunctionsService>();

  Query get homePageChunesQuery => FirebaseFirestore.instance
      .collection(chunesCollection)
      .orderBy('timestamp', descending: true);

  Query get allUserAccountsQuery => FirebaseFirestore.instance
      .collection(usersCollection)
      .orderBy('chunesShared', descending: true);

  @override
  Future<List<ProfileModel>> loadUserSuggestions() async {
    final result = await fireStore
        .collection(usersCollection)
        .orderBy('chunesShared', descending: true)
        .limit(7)
        .get();
    return List<ProfileModel>.from(
      result.docs.map((e) {
        return ProfileModel.fromMap(e.data()).copyWith(id: e.id);
      }),
    );
  }

  @override
  Future followUser(ProfileModel user) async {
    return functions.followUser(user.id);
  }

  @override
  Future unFollowUser(ProfileModel user) {
    return functions.unfollowUser(user.id);
  }

  @override
  Future likeChune(Chune post) {
    return functions.likeChune(post.id);
  }

  @override
  Future unLikeChune(Chune user) {
    return functions.unlikeChune(user.id);
  }
}
