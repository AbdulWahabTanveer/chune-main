import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../models/spotify_model.dart';
import '../../../repositories/share_a_chune_repo.dart';
import '../../../repositories/spotify_repo.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

import '../../../models/chune.dart';
import '../../../models/profile_model.dart';

part 'share_a_chune_event.dart';

part 'share_a_chune_state.dart';

class ShareAChuneBloc extends Bloc<ShareAChuneEvent, ShareAChuneState> {
  final chuneRepo = GetIt.I.get<ShareAChuneRepository>();

  int page = 0;

  bool end = false;

  ShareAChuneBloc() : super(ShareAChuneInitial()) {
    on<SearchChuneEvent>(_onSearchChune);
    on<ShareChuneEvent>(_onShareChune);
  }

  FutureOr<void> _onSearchChune(
      SearchChuneEvent event, Emitter<ShareAChuneState> emit) async {
    if (state is ChunesLoadingState) {
      return;
    }
    List<Chune> chunes = [];
    var s = event.s;
    if (!event.force && state is ChunesLoadSuccess) {
      if (end) {
        return;
      }
      final cast = state as ChunesLoadSuccess;
      page++;
      chunes = List<Chune>.from(cast.chunes);
      s = cast.search;
    } else {
      page = 0;
      end = false;
      emit(ChunesLoadingState());
    }
    try {
      final newChunes = await chuneRepo.search(s, page: page);
      if (newChunes.isEmpty) {
        end = true;
      }
      emit(ChunesLoadSuccess(chunes..addAll(newChunes), end: end, search: s));
    } catch (e, t) {
      print(e);
      print(t);
      emit(ChunesLoadSuccess(chunes, end: true, search: s));
    }
  }

  FutureOr<void> _onShareChune(
      ShareChuneEvent event, Emitter<ShareAChuneState> emit) async {
    emit(ChuneSharingState());
    final result = await chuneRepo.shareChune(event.chune.copyWith(
        userId: event.publishedBy.id,
        username: event.publishedBy.username,
        userImage: event.publishedBy.image));
    if (result) {
      GetIt.I.get<PaginateRefreshedChangeListener>().refreshed = true;
      emit(ChuneShareSuccessState());
    } else {
      emit(ChuneShareErrorState());
    }
  }
}
