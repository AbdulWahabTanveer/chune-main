import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import '../../auth_flow/app/app.dart';
import '../../models/current_user.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newapp/services/player/audio_player.dart';

import '../../core/bloc/login/login_bloc.dart';
import '../../services/player/apple_player.dart';
import '../../services/player/spotify_player.dart';

class MusicSource extends StatefulWidget {
  const MusicSource({Key key}) : super(key: key);

  @override
  _MusicSourceState createState() => _MusicSourceState();

  static Page<void> page() => MaterialPage<void>(child: MusicSource());
}

class _MusicSourceState extends State<MusicSource> {
  // var varName = dotenv.env['VAR_NAME'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          final get = GetIt.I;
          if (get.isRegistered<BaseAudioPlayer>()) {
            get.unregister<BaseAudioPlayer>();
          }
          if (state.user.type == MusicSourceType.spotify) {
            get.registerSingleton<BaseAudioPlayer>(SpotifyPlayer());
          } else if (state.user.type == MusicSourceType.apple) {
            get.registerSingleton<BaseAudioPlayer>(ApplePlayer());
          }
        }

        if (state is LoginErrorState) {
          Fluttertoast.showToast(
            msg: state.user,
            textColor: Colors.white,
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG,
          );
        }
      },
      builder: (context, state) {
        if (state is LoginSuccessState) {
        return AuthenticatedScreen();

        }
        final isLoading = state is LoginLoading;
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).secondaryHeaderColor,
              ]),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'chune',
                  style: TextStyle(
                      fontFamily: '',
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Color(0xff00d157)),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                    ),
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginWithSpotifyEvent());
                    },
                    icon: Image.asset(
                      'images/spotify.png',
                      height: 24,
                    ),
                    label: Text('LOGIN WITH SPOTIFY')),
                SizedBox(
                  height: 16,
                ),
                Opacity(
                  opacity: isLoading ? 0.5 : 1,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.black),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.white)),
                    onPressed: isLoading
                        ? null
                        : () {
                            context
                                .read<LoginBloc>()
                                .add(LoginWithAppleEvent());
                          },
                    icon: Icon(Icons.apple_outlined),
                    label: Text('SIGN IN WITH APPLE'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

// void getAuth() {

//   getAuthenticationToken().then((screen) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => screen),
//     );
//   });

// }
}
