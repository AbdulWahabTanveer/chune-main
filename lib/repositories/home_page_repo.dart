import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/Useful_Code/constants.dart';
import 'package:newapp/models/profile_model.dart';

abstract class HomePageRepository {
  Future<List<ProfileModel>> loadUserSuggestions();

  Query get homePageChunesQuery;

  Query get allUserAccountsQuery;
}

class HomePageRepositoryImpl extends HomePageRepository {
  final fireStore = FirebaseFirestore.instance;

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
}
