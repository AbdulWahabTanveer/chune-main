import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/models/spotify_model.dart';
import 'package:newapp/repositories/spotify_repo.dart';

part 'share_a_chune_event.dart';

part 'share_a_chune_state.dart';

class ShareAChuneBloc extends Bloc<ShareAChuneEvent, ShareAChuneState> {
  final spotifyRepo = GetIt.I.get<SpotifyRepository>();

  ShareAChuneBloc() : super(ShareAChuneInitial()) {
    on<SearchChuneEvent>(_onSearchChune);
  }

  FutureOr<void> _onSearchChune(
      SearchChuneEvent event, Emitter<ShareAChuneState> emit) async {
    emit(ChunesLoadingState());
    final model = await spotifyRepo.search(event.s);
    emit(ChunesLoadSuccess(model));
  }
}
