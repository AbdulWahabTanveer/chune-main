import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get_cubit/get_cubit.dart';
import 'package:newapp/Useful_Code/entity.dart';
import 'package:newapp/models/profile_model.dart';

import 'constants.dart';
import 'ids_list/ids_list_cubit.dart';

class AppCubits {
  static registerCubits({@required FirebaseFirestore firestore}) {
    GetCubit.put<IDsListCubit<ProfileModel>>(
      IDsListCubit(
        getItemFromId: (id) async {
          final doc = await FirebaseFirestore.instance
              .collection(usersCollection)
              .doc(id)
              .get();
          return Right(ProfileModel.fromMap(doc.data()));
        },
        idsFieldNameInDoc: 'muted_users',
      ),
      id: 'muted_users',
    );

    GetCubit.put<IDsListCubit<ID>>(
      IDsListCubit(
        getItemFromId: (id) async {
          return Right(ID(id));
        },
        idsFieldNameInDoc: 'blocked_artists',
      ),
      id: 'blocked_artists',
    );

    GetCubit.put<IDsListCubit<ID>>(
      IDsListCubit(
        getItemFromId: (id) async {
          return Right(ID(id));
        },
        idsFieldNameInDoc: 'hidden_posts',
      ),
      id: 'hidden_posts',
    );
  }

  static IDsListCubit<ProfileModel> get mutedUsersCubit {
    return GetCubit.find<IDsListCubit<ProfileModel>>(id: 'muted_users');
  }

  static IDsListCubit<ID> get blockedArtistsCubit {
    return GetCubit.find<IDsListCubit<ID>>(id: 'blocked_artists');
  }

  static IDsListCubit<ID> get hiddenPostsCubit {
    return GetCubit.find<IDsListCubit<ID>>(id: 'hidden_posts');
  }
}


