import 'package:flutter/widgets.dart';

import '../../../screens/LoginScreens/Login.dart';
import '../../home/view/home_page.dart';
import '../../login/view/login_page.dart';
import '../bloc/app_bloc.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [MusicSource.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
