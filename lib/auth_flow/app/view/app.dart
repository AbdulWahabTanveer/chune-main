import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../theme.dart';
import '../bloc/app_bloc.dart';
import '../routes/routes.dart';

class AuthApp extends StatelessWidget {
  const AuthApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(
        authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
      ),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
