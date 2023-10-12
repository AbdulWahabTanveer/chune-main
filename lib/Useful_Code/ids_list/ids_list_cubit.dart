import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:newapp/Useful_Code/lists.dart';
import '../error/failure.dart';
import '../error/server_failure.dart';

import '../entity.dart';

// import 'ids_list_state/ids_list_state.dart';
import 'ids_list_state.dart';

class IDsListCubit<Item extends Entity> extends Cubit<IDsListState<Item>> {
  IDsListCubit({
    // IDsListState<Item> initState,
    @required this.getItemFromId,
    @required this.idsFieldNameInDoc,
  }) : super(IDsDataLoading(const []));

  final Future<Either<Failure, Item>> Function(String id) getItemFromId;
  DocumentReference idsDocument;
  final String idsFieldNameInDoc;
  StreamSubscription _IDsSub;

  changeIdsDoc(DocumentReference newIdsDoc) {
    stopListeningToIDs();
    idsDocument = newIdsDoc;
    emit(IDsDataLoading([]));
    _startListeningToIDs();
  }

  Future<bool> addId({@required String id}) async {
    try {
      await idsDocument.update({
        idsFieldNameInDoc: FieldValue.arrayUnion([id])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeId({@required String id}) async {
    try {
      await idsDocument.update({
        idsFieldNameInDoc: FieldValue.arrayRemove([id])
      });

      _removeItem(id: id);
      return true;
    } catch (e) {
      return false;
    }
  }

  _removeItem({@required String id}) {
    if (state is IDsDataLoaded) {
      final list = (state as IDsDataLoaded).list.toList();
      if (list.hasId(id)) {
        list.removeWhere((element) => element.getId == id);

        emit(IDsDataLoaded(state.ids, list));
      }
    }
  }

  bool isIdAdded(String id) => state.ids.contains(id);

  _startListeningToIDs() {
    _IDsSub = idsDocument.snapshots(includeMetadataChanges: true).listen(
      (doc) {
        if (doc.exists == false) {
          emit(IDsDataLoaded([], []));
          return;
        }

        final ids = Set<String>.from(
                (doc.data() as Map<String, dynamic>)[idsFieldNameInDoc] ?? [])
            .toList();

        // emit(state.changeIds(ids));
        emit(IDsDataLoading(ids));
      },
      onError: (error) {
        emit(
          IDsDataLoadingError(state.ids, ServerFailure(error.toString())),
        );
      },
    );
  }

  stopListeningToIDs() {
    _IDsSub?.cancel();
  }

  getNextItems(List<Item> currItems) async {
    final nextItemsIds = _getUnviewedIDs;

    List<Item> items = [];

    await Future.wait(nextItemsIds.map((e) async {
      final itemResult = await getItemFromId(e);

      itemResult.fold((l) => null, (r) => items.add(r));
    }).toList());

    emit(IDsDataLoaded(state.ids, [...currItems, ...items]));
  }

  List<String> get _getUnviewedIDs {
    return [];
    // List<String> getItemsIds(List<Item> items) =>
    //     items.map((e) => e.getId).toList();

    // final List<String> viewedIDs = state.map(
    //   initLoading: (value) => [],
    //   loaded: (value) => getItemsIds(value.loaded),
    //   loadingError: (value) => [],
    // );

    // final allIDs = state.allIDs.toList();

    // return allIDs.where((e) => !viewedIDs.contains(e)).toList();
  }

  pageOpened() {
    // state.mapOrNull(
    //   initLoading: (_) => getNextItems([]),
    //   loaded: (value) {
    //     final loadedItems = value.loaded;
    //     final diffrence = value.allIDs.length - loadedItems.length;

    //     if (diffrence > 0 && loadedItems.length < fetchLimit) {
    //       getNextItems(loadedItems);
    //     }
    //   },
    //   loadingError: (value) {
    //     final error = value.error;
    //     if (error is RetrivableFailure) {
    //       error.onTryAgain();
    //     }
    //   },
    // );
  }
}
