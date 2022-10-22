import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/core/bloc/profile/profile_bloc.dart';
import 'package:newapp/screens/LoginScreens/Login.dart';
import 'package:newapp/screens/NavScreen.dart';

import '../../../screens/LoginScreens/CreateUsername.dart';
import '../bloc/app_bloc.dart';

class AuthenticatedScreen extends StatelessWidget {
  const AuthenticatedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider.value(
      value: context.read<ProfileBloc>()..add(CheckProfileExistsEvent(user.id)),
      child: _AuthenticatedScreenContent(),
    );
  }
}

class _AuthenticatedScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          if (state.profile != null) {
            return NavScreen();
          } else {
            return CreateUsername();
          }
        }
        return Container();
      },
    );
  }
}
