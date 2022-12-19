import 'dart:ui';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/firebase_options.dart';
import 'package:newapp/repositories/apple_repo.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/repositories/home_page_repo.dart';
import 'package:newapp/repositories/share_a_chune_repo.dart';
import 'package:newapp/services/http_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_flow/app/bloc_observer.dart';
import '../repositories/profile_repository.dart';
import '../repositories/spotify_repo.dart';
import 'audio_service.dart';
import 'cloud_functions_service.dart';

class Injector {
  static Future<void> init(VoidCallback appRunner) async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppBlocObserver();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // FlutterError.onError = (errorDetails) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    // };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    final authenticationRepository = AuthenticationRepository();
    await authenticationRepository.user.first;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(prefs);

    GetIt.I.registerSingleton<HttpService>(HttpService());
    GetIt.I.registerSingleton<AuthRepository>(AuthRepoImpl());
    GetIt.I.registerSingleton<SpotifyRepository>(SpotifyRepoImpl());
    GetIt.I.registerSingleton<AppleRepository>(AppleRepoImpl());
    GetIt.I.registerSingleton<AudioHandler>(AudioHandler());
    GetIt.I.registerSingleton<CloudFunctionsService>(CloudFunctionsService());
    GetIt.I.registerSingleton<ProfileRepository>(ProfileRepositoryImpl());
    GetIt.I.registerSingleton<HomePageRepository>(HomePageRepositoryImpl());
    GetIt.I.registerSingleton<AuthenticationRepository>(
        AuthenticationRepository());
    GetIt.I.registerSingleton<ProfileRepositoryImpl>(ProfileRepositoryImpl());
    GetIt.I.registerSingleton<ShareAChuneRepository>(ShareAChuneRepoImpl());
    GetIt.I.registerSingleton<PaginateRefreshedChangeListener>(
        PaginateRefreshedChangeListener());
    GetIt.I.registerSingleton<ScrollController>(ScrollController());

    appRunner();
  }
}
