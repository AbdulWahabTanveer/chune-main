import 'package:equatable/equatable.dart';

import '../entity.dart';

// import '../../models/lists/list_fetch_result.dart';

import '../error/failure.dart';

// part 'ids_list_state.freezed.dart';

// @Freezed(makeCollectionsUnmodifiable: false,)
// class IDsListState<Item extends Entity> with _$IDsListState<Item> {
//   const factory IDsListState.initLoading({
//     required List<String> allIDs,
//   }) = _InitLoadingList;

//   const factory IDsListState.loaded({
//     required List<String> allIDs,
//     required List<Item> loaded,
//   }) = _LoadedList;

//   const factory IDsListState.loadingError({
//     required List<String> allIDs,
//     required Failure error,
//   }) = _FailedLoadingList;

// }

abstract class IDsListState<Item extends Entity> extends Equatable {
  List<String> ids;

  changeIds(List<String> newIds) {
    ids = newIds;
  }

  IDsListState(this.ids);
}

class IDsDataLoading<T extends Entity> extends IDsListState<T> {
  IDsDataLoading(List<String> ids) : super(ids);

  @override
  List<Object> get props => [ids];
}

class IDsDataLoadingError<T extends Entity> extends IDsListState<T> {
  final Failure error;
  IDsDataLoadingError(
    List<String> ids,
    this.error,
  ) : super(ids);

  @override
  List<Object> get props => [ids, error];
}

class IDsDataLoaded<T extends Entity> extends IDsListState<T> {
  final List<T> list;
  IDsDataLoaded(
    List<String> ids,
    this.list,
  ) : super(ids);

  @override
  List<Object> get props => [ids, list];
}
