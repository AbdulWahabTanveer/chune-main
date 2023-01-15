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
    on<LoadProfileEvent>(_onLoadProfile);
    on<DeleteChuneEvent>(_onDeleteProfile);
    on<AddChuneEvent>(_onAddChune);
    on<ProfileUpdatedEvent>(_onProfileUpdated);
    on<SetUserProfileEvent>(
      (event, emit) => emit(
        ProfileLoadedState(event.profile),
      ),
    );
    on<LogoutProfileEvent>((event, emit) => emit(ProfileInitial()));
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

  FutureOr<void> _onLoadProfile(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    final userProfile = await profileRepo.getUserProfile(event.userId);
    emit(ProfileLoadedState(userProfile));
  }

  FutureOr<void> _onProfileUpdated(
      ProfileUpdatedEvent event, Emitter<ProfileState> emit) {
    if (state is ProfileLoadedState) {
      final cast = state as ProfileLoadedState;
      emit(ProfileLoadedState(cast.profile
          .copyWith(image: event.imageUrl, username: event.username)));
    }
  }

  FutureOr<void> _onDeleteProfile(DeleteChuneEvent event, Emitter<ProfileState> emit)async {
    await profileRepo.deleteChune(event.chuneId);
    emit(ProfileLoadedState(profileRepo.getMyCachedProfile()));

  }

  FutureOr<void> _onAddChune(AddChuneEvent event, Emitter<ProfileState> emit)async {
    await profileRepo.addNewChune();
    emit(ProfileLoadedState(profileRepo.getMyCachedProfile()));

  }
}
