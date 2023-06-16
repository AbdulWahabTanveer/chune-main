import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Useful_Code/constants.dart';

class DeleteAccountCubit extends Cubit<String> {
  final AuthenticationRepository authRepo;

  DeleteAccountCubit(String initialState, this.authRepo) : super(initialState);

  Future<String> deleteMyAccount(String myID) async {
    final result = await authRepo.deleteMyAccount();
     if (result == null) {
      try {
        final firestore = FirebaseFirestore.instance;
        await firestore.collection(usersCollection).doc(myID).delete();
        await firestore
            .collection(chunesCollection)
            .where('userId', isEqualTo: myID)
            .get()
            .then((value) async {
          Future.wait(value.docs
              .map(
                (e) async => await e.reference.delete(),
              )
              .toList());
        });
      } catch (e) {}
    }

    return result;
  }
}
