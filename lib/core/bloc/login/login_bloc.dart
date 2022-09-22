import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/models/current_user.dart';
import 'package:newapp/repositories/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final authRepo = GetIt.I.get<AuthRepository>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithSpotifyEvent>(_onLoginWithSpotify);
    on<LoginWithAppleEvent>(_onLoginWithApple);
  }

  FutureOr<void> _onLoginWithSpotify(
      LoginWithSpotifyEvent event, Emitter<LoginState> emit) async {
    try {
      final user = await authRepo.loginWithSpotify();
      emit(LoginSuccessState(user));
    } catch (e) {}
  }

  FutureOr<void> _onLoginWithApple(
      LoginWithAppleEvent event, Emitter<LoginState> emit) async {
    final user = await authRepo.loginWithApple();
    print("USer TOKEN +> ${user.token}");
    emit(LoginSuccessState(user));
  }
}
