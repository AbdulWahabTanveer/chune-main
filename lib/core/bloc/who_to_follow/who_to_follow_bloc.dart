import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../repositories/home_page_repo.dart';
import '../../../services/cloud_functions_service.dart';

import '../../../models/profile_model.dart';

part 'who_to_follow_event.dart';

part 'who_to_follow_state.dart';

class WhoToFollowBloc extends Bloc<WhoToFollowEvent, WhoToFollowState> {
  final repo = GetIt.I.get<HomePageRepository>();

  WhoToFollowBloc() : super(WhoToFollowInitial()) {
    on<LoadWhoToFollowEvent>(_onLoadWhoToFollow);
    on<FollowUserEvent>(_onFollowUser);
    on<UndoFollowEvent>(_onUndoFollow);
  }

  FutureOr<void> _onLoadWhoToFollow(
      LoadWhoToFollowEvent event, Emitter<WhoToFollowState> emit) async {
    try {
      emit(WhoToFollowLoadingState());
      final users = await repo.loadUserSuggestions();
      emit(WhoToFollowSuccessState(users));
    } catch (e, t) {
      print(e);
      print(t);
      emit(WhoToFollowErrorState('$e'));
    }
  }

  FutureOr<void> _onFollowUser(
      FollowUserEvent event, Emitter<WhoToFollowState> emit) async {
    if (state is WhoToFollowSuccessState) {
      final cast = state as WhoToFollowSuccessState;
      final users = List<ProfileModel>.from(cast.users);
      repo.followUser(users[event.index].id).catchError((e) {
        add(UndoFollowEvent(event.index));
      });
      users[event.index].isFollowing = true;
      emit(WhoToFollowSuccessState(users));
    }
  }

  FutureOr<void> _onUndoFollow(
      UndoFollowEvent event, Emitter<WhoToFollowState> emit) async {
    if (state is WhoToFollowSuccessState) {
      final cast = state as WhoToFollowSuccessState;
      final users = List<ProfileModel>.from(cast.users);
      users[event.index].isFollowing = false;
      emit(WhoToFollowSuccessState(users));
    }
  }
}
