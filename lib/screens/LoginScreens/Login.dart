import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/models/current_user.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newapp/screens/NavScreen.dart';
import 'package:newapp/services/player/audio_player.dart';

import '../../Useful_Code/utils.dart';
import '../../core/bloc/login/login_bloc.dart';
import '../../services/player/apple_player.dart';
import '../../services/player/spotify_player.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<Login> {
  // var varName = dotenv.env['VAR_NAME'];

  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 500,
      height: 1000,
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
                fontSize: 90,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            // onTap: getAuth,
            onTap: () {},

            child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Color(0xff00d157))),
                onPressed: () {
                  context.read<LoginBloc>().add(LoginWithSpotifyEvent());
                },
                icon: Image.asset(
                  'images/spotify.png',
                  height: 24,
                ),
                label: Text('LOGIN WITH SPOTIFY')),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.black),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.white)),
            onPressed: () {
              context.read<LoginBloc>().add(LoginWithAppleEvent());
            },
            icon: Icon(Icons.apple_outlined),
            label: Text('LOGIN WITH APPLE'),
          )
        ],
      ),
    );
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          final get = GetIt.I;
          if (get.isRegistered<BaseAudioPlayer>()) {
            get.unregister<BaseAudioPlayer>();
          }
          if (state.user.type == UserType.spotify) {
            get.registerSingleton<BaseAudioPlayer>(SpotifyPlayer());
          } else if (state.user.type == UserType.apple) {
            get.registerSingleton<BaseAudioPlayer>(ApplePlayer());
          }
          pushTo(context, NavScreen(), clear: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: container,
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
