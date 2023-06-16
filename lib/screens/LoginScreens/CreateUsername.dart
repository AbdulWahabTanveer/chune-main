import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/create_username/create_username_bloc.dart';
import '../../core/bloc/nav_bloc/nav_bloc.dart';
import '../NavScreen.dart';

import '../../Useful_Code/utils.dart';
import '../../auth_flow/app/bloc/app_bloc.dart';
import '../../core/bloc/profile/profile_bloc.dart';
import '../../models/profile_model.dart';

class CreateUsername extends StatelessWidget {
  const CreateUsername({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUsernameBloc(),
      child: _CreateUsernameContent(),
    );
  }
}

class _CreateUsernameContent extends StatefulWidget {
  @override
  _CreateUsername createState() => _CreateUsername();
}

class _CreateUsername extends State<_CreateUsernameContent> {
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(56),
    ),
  );
  final username = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final _fieldDecor = InputDecoration(
      labelStyle: TextStyle(color: Colors.white),
      focusedBorder: border,
      enabledBorder: border,
      border: border,
    );
    final bloc = context.read<CreateUsernameBloc>();
    return BlocConsumer<CreateUsernameBloc, CreateUsernameState>(
      bloc: bloc,
      listener: (context, state) async {
        if (state is UsernameAvailableState) {
          bloc.add(
            CreateUserProfileEvent(
              user.id,
              ProfileModel(
                username: state.username,
                email: user.email,
                image: (user.photo == null || user.photo.isEmpty)
                    ? "https://cdn-icons-png.flaticon.com/512/1946/1946429.png"
                    : user.photo,
                fcmToken: await FirebaseMessaging.instance.getToken(),
                followers: [],
                followings: [],
                likedChunes: [],
                sharedChunes: [],
              ),
            ),
          );
        }
        if (state is UsernameCreateErrorState) {
          // toast(state.error);
        }
        if (state is UsernameCreateSuccessState) {
          context.read<ProfileBloc>().add(SetUserProfileEvent(state.profile));
        }
      },
      builder: (context, state) {
        if (state is UsernameCreateSuccessState) {
          context.read<NavBloc>().add(4);
          return NavScreen(index: 4);
        }
        return Scaffold(
          backgroundColor: Colors.pink,
          body: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).secondaryHeaderColor,
                ]),
              ),
              alignment: Alignment.center,
              child: ListView(
                children: [
                  Container(
                    height: 250,
                    width: 200,
                  ),
                  Text(
                    'chune',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 80.0,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: state is! UsernameLoadingState,
                      controller: username,
                      validator: (e) => e.isEmpty ? "Required" : null,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: _fieldDecor.copyWith(labelText: "Username"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: state is! UsernameLoadingState,
                      validator: (e) =>
                          e != username.text ? "Username does not match" : null,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration:
                          _fieldDecor.copyWith(labelText: "Confirm username"),
                    ),
                  ),
                  if (state is UsernameExistsState)
                    Container(
                      height: 56,
                      color: Colors.white,
                      child: Center(
                        child: Text('Username already exists'),
                      ),
                    ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: state is UsernameLoadingState
                            ? null
                            : () {
                                if (_formKey.currentState.validate()) {
                                  checkUsername();
                                }
                              },
                        child: state is UsernameLoadingState
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  loader(),
                                  if (state is UsernameLoadingState)
                                    Text(
                                      state is CheckingUsernameState
                                          ? 'Checking availability'
                                          : 'Creating username',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                ],
                              )
                            : Text("CREATE")),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  checkUsername() {
    context.read<CreateUsernameBloc>().add(CheckUsernameEvent(username.text));
  }
}
