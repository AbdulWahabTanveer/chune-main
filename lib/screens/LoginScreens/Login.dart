import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newapp/screens/NavScreen.dart';

import '../../Useful_Code/utils.dart';
import '../../core/bloc/login/login_bloc.dart';

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

            child: Container(
              width: 300,
              height: 100,
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Color(0xff00d157))),
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginWithSpotifyEvent());
                  },
                  icon: Image.asset('images/spotify.png'),
                  label: Text('LOGIN WITH SPOTIFY')),
            ),
          ),
        ],
      ),
    );
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
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
