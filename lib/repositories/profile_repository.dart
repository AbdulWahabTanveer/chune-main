import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/models/profile_model.dart';

import '../Useful_Code/constants.dart';

abstract class ProfileRepository {
  Future<bool> isNewUser(String userId);

  Future<bool> usernameExists(String userName);

  Future<ProfileModel> getUserProfile(String userId);

  Future<ProfileModel> createProfile(String userId, ProfileModel profile);
}

class ProfileRepositoryImpl extends ProfileRepository {
  final fireStore = FirebaseFirestore.instance;

  @override
  Future<bool> isNewUser(String userId) async {
    final user = await fireStore.collection(usersCollection).doc(userId).get();
    return !user.exists;
  }

  @override
  Future<ProfileModel> getUserProfile(String userId) async {
    final user = await fireStore.collection(usersCollection).doc(userId).get();
    return ProfileModel.fromMap(user.data()).copyWith(id: user.id);
  }

  @override
  Future<bool> usernameExists(String userName) async {
    final user = await fireStore
        .collection(usersCollection)
        .where('username', isEqualTo: '$userName')
        .get();
    return user.size > 0;
  }

  @override
  Future<ProfileModel> createProfile(
      String userId, ProfileModel profile) async {
    try {
      await fireStore
          .collection(usersCollection)
          .doc(userId)
          .set(profile.toMap());
      return profile.copyWith(id: userId);
    } catch (e) {
      return null;
    }
  }
}
