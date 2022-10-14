import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/models/spotify_model.dart';
import 'package:newapp/repositories/share_a_chune_repo.dart';
import 'package:newapp/repositories/spotify_repo.dart';

import '../../../models/chune.dart';

part 'share_a_chune_event.dart';

part 'share_a_chune_state.dart';

class ShareAChuneBloc extends Bloc<ShareAChuneEvent, ShareAChuneState> {
  final chuneRepo = GetIt.I.get<ShareAChuneRepository>();

  ShareAChuneBloc() : super(ShareAChuneInitial()) {
    on<SearchChuneEvent>(_onSearchChune);
    on<ShareChuneEvent>(_onShareChune);
  }

  FutureOr<void> _onSearchChune(
      SearchChuneEvent event, Emitter<ShareAChuneState> emit) async {
    emit(ChunesLoadingState());
    final chunes = await chuneRepo.search(event.s);
    emit(ChunesLoadSuccess(chunes));
  }

  FutureOr<void> _onShareChune(
      ShareChuneEvent event, Emitter<ShareAChuneState> emit) async {
    emit(ChuneSharingState());
    final result = await chuneRepo.shareChune(event.chune.copyWith(
        userId: event.publishedBy.id,
        username: event.publishedBy.name,
        userImage: event.publishedBy.photo));
    if (result) {
      emit(ChuneShareSuccessState());
    } else {
      emit(ChuneShareErrorState());
    }
  }
}
