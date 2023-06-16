import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../models/profile_model.dart';

import '../../../repositories/profile_repository.dart';

part 'user_profile_event.dart';

part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final profileRepo = GetIt.I.get<ProfileRepository>();

  UserProfileBloc() : super(UserProfileInitial()) {
    on<LoadUserProfileEvent>(_onLoadUserProfile);
  }

  FutureOr<void> _onLoadUserProfile(
      LoadUserProfileEvent event, Emitter<UserProfileState> emit) async {
    try {
      emit(UserProfileLoadingState());
      final profile = await profileRepo.loadUserProfile(event.userId);
      emit(UserProfileLoadedState(profile));
    } catch (e, t) {
      emit(UserProfileErrorState('$e'));
      print(e);
      print(t);
    }
  }
}
