import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/auth_flow/app/app.dart';
import 'package:newapp/core/bloc/login/login_bloc.dart';

import '../auth_flow/app/bloc/app_bloc.dart';
import '../auth_flow/login/view/login_page.dart';
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
