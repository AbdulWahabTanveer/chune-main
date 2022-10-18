import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/models/profile_model.dart';
import 'package:newapp/repositories/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final profileRepo = GetIt.I.get<ProfileRepository>();

  ProfileBloc() : super(ProfileInitial()) {
    on<CheckProfileExistsEvent>(_onCheckProfileExists);
    on<SetUserProfileEvent>((event, emit) => ProfileLoadedState(event.profile));
  }

  FutureOr<void> _onCheckProfileExists(
      CheckProfileExistsEvent event, Emitter<ProfileState> emit) async {
    final newUser = await profileRepo.isNewUser(event.userId);
    if (newUser) {
      emit(ProfileLoadedState(null));
    } else {
      final userProfile = await profileRepo.getUserProfile(event.userId);
      emit(ProfileLoadedState(userProfile));
    }
  }
}
