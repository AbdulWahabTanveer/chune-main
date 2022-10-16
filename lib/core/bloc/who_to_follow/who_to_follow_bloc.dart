import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/repositories/home_page_repo.dart';

import '../../../models/profile_model.dart';

part 'who_to_follow_event.dart';

part 'who_to_follow_state.dart';

class WhoToFollowBloc extends Bloc<WhoToFollowEvent, WhoToFollowState> {
  final repo = GetIt.I.get<HomePageRepository>();

  WhoToFollowBloc() : super(WhoToFollowInitial()) {
    on<LoadWhoToFollowEvent>(_onLoadWhoToFollow);
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
}
