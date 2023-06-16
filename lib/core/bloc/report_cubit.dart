import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/Useful_Code/constants.dart';

class ReportCubit extends Cubit<String> {
  final FirebaseFirestore firestore;
  ReportCubit(this.firestore) : super(null);

  Future<bool> reportPost({
    @required String postId,
    @required String myID,
  }) async {
    try {
      await firestore.collection(reportsCollection).add({
        'reportedPostId': postId,
        'userId': myID,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> reportUser({
    @required String reportedUserId,
    @required String myID,
  }) async {
    try {
      await firestore.collection(reportsCollection).add({
        'reportedUserId': reportedUserId,
        'userId': myID,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
