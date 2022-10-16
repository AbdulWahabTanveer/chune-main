import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/screens/UserProfile.dart';

import '../../../models/profile_model.dart';
import '../../../repositories/profile_repository.dart';

part 'create_username_event.dart';

part 'create_username_state.dart';

class CreateUsernameBloc
    extends Bloc<CreateUsernameEvent, CreateUsernameState> {
  final profileRepo = GetIt.I.get<ProfileRepository>();

  CreateUsernameBloc() : super(CreateUsernameInitial()) {
    on<CheckUsernameEvent>(_onCheckUsername);
    on<CreateUserProfileEvent>(_onCreateUsername);
  }

  FutureOr<void> _onCheckUsername(
      CheckUsernameEvent event, Emitter<CreateUsernameState> emit) async {
    emit(CheckingUsernameState());
    final exists = await profileRepo.usernameExists(event.username);
    if (exists) {
      emit(UsernameExistsState());
    } else {
      emit(UsernameAvailableState(event.username));
    }
  }

  FutureOr<void> _onCreateUsername(
      CreateUserProfileEvent event, Emitter<CreateUsernameState> emit) async {
    emit(CreatingUsernameState());
    final success =
        await profileRepo.createProfile(event.userId, event.profile);
    if (success) {
      emit(UsernameCreateSuccessState(event.profile));
    } else {
      emit(UsernameCreateErrorState(
          "Failed to create username\n please try again later."));
    }
  }
}
