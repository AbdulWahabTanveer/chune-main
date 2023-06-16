import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Useful_Code/app_cubits.dart';
import '../Useful_Code/constants.dart';
import '../auth_flow/app/app.dart';
import '../core/bloc/login/login_bloc.dart';

import '../auth_flow/app/bloc/app_bloc.dart';
import '../auth_flow/login/view/login_page.dart';
import '../core/bloc/music_player/music_player_bloc.dart';
import '../core/bloc/profile/profile_bloc.dart';
import 'LoginScreens/Login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.status == AppStatus.unauthenticated) {
          context.read<ProfileBloc>().add(LogoutProfileEvent());
          context.read<LoginBloc>().add(ResetMusicSourceEvent());
          context.read<MusicPlayerBloc>().add(StopAudioEvent());
          AppCubits.mutedUsersCubit.stopListeningToIDs();
          AppCubits.blockedArtistsCubit.stopListeningToIDs();
          AppCubits.hiddenPostsCubit.stopListeningToIDs();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SplashScreen()),
            (route) => false,
          );
        }

        if (state.status == AppStatus.authenticated) {
          final ref = FirebaseFirestore.instance
              .collection(usersCollection)
              .doc(state.user.id);
          AppCubits.mutedUsersCubit.changeIdsDoc(ref);
          AppCubits.blockedArtistsCubit.changeIdsDoc(ref);
          AppCubits.hiddenPostsCubit.changeIdsDoc(ref);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case AppStatus.authenticated:
            return MusicSource();
          case AppStatus.unauthenticated:
            return LoginPage();
        }
        return Scaffold();
      },
    );
  }
}
