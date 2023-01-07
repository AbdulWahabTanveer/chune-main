///To God be the Glory

import 'package:authentication_repository/authentication_repository.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/auth_flow/app/app.dart';
import 'package:newapp/core/bloc/choose_photo_bloc/choose_photo_bloc.dart';
import 'package:newapp/core/bloc/login/login_bloc.dart';
import 'package:newapp/core/bloc/music_player/music_player_bloc.dart';
import 'package:newapp/core/bloc/nav_bloc/nav_bloc.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/responsive.dart';
import 'package:newapp/screens/splash_screen.dart';
import 'package:newapp/services/injector.dart';
import 'core/bloc/notification_counter/notification_counter_bloc.dart';
import 'core/bloc/profile/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');
  await Injector.init(() {
    runApp(DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(GetIt.I.get<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => MusicPlayerBloc(),
        ),
        BlocProvider(
          create: (context) => NavBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationCounterBloc(),
        ),
        BlocProvider(
          create: (context) => ChoosePhotoBloc(),
        ),
        BlocProvider(
          create: (_) => AppBloc(
            authenticationRepository: GetIt.I.get<AuthenticationRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // useMaterial3: true,
            textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white,
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.transparent
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent.shade100)),
              errorStyle:
                  TextStyle(color: Colors.white, backgroundColor: Colors.red),
            ),
            primarySwatch: Colors.pink,
            secondaryHeaderColor: Colors.blue),
        locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        builder: (context, child) {
          child = myResponsiveBuilder(context, child);
          return child;
        },
        home: SplashScreen(),
      ),
    );
  }
}
