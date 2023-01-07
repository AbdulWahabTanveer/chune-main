import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/models/current_user.dart';
import 'package:newapp/repositories/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc(this.authRepo) : super(LoginInitial()) {
    on<LoginWithSpotifyEvent>(_onLoginWithSpotify);
    on<LoginWithAppleEvent>(_onLoginWithApple);
    on<LoginWithCachedUserEvent>(_onLoginWithCache);
    on<ResetMusicSourceEvent>((event, emit) async {
      authRepo.clearUser();
      emit(LoginInitial());
    });

    add(LoginWithCachedUserEvent());
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
    try {
      final user = await authRepo.loginWithApple();
      print("USer TOKEN +> ${user.token}");
      emit(LoginSuccessState(user));
    } catch (e, trace) {
      FirebaseFirestore.instance.collection('Logs').add({
        "Error": '$e',
        'trace': '$trace',
        'time': DateTime.now().toString()
      });
      emit(LoginErrorState("$e"));
    }
  }

  FutureOr<void> _onLoginWithCache(
      LoginWithCachedUserEvent event, Emitter<LoginState> emit) async {
    final user = authRepo.getLoggedInUser();
    if (user != null) {
      if (user.type == MusicSourceType.spotify) {
        add(LoginWithSpotifyEvent());
      } else {
        add(LoginWithAppleEvent());
      }
    }
  }
}
