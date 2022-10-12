import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/auth_flow/app/app.dart';

import '../auth_flow/app/bloc/app_bloc.dart';
import '../auth_flow/login/view/login_page.dart';
import 'LoginScreens/Login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        switch (state.status) {
          case AppStatus.authenticated:
            return AuthenticatedScreen();
          case AppStatus.unauthenticated:
            return LoginPage();
        }
        return Scaffold();
      },
    );
  }
}
