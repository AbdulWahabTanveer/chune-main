import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newapp/core/bloc/profile/profile_bloc.dart';
import '../../auth_flow/app/bloc/app_bloc.dart';
import '../../repositories/profile_repository.dart';
import 'package:get_it/get_it.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({Key key}) : super(key: key);

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final confirmUsernameC = TextEditingController();
  final usernameC = TextEditingController();
  final profileRepo = GetIt.I.get<ProfileRepository>();
  final formKey = GlobalKey<FormState>();

  bool updating = false;

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: primary, width: 2),
      borderRadius: BorderRadius.all(
        Radius.circular(100),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'chune',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title:Text("Current username:",style: TextStyle(color: Colors.black),),
              subtitle:Text('@${profileRepo.getMyCachedProfile().username}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              enabled: !updating,
              cursorColor: primary,
              controller: usernameC,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Required";
                }
                return null;
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle_outlined),
                hintText: 'Enter username',
                focusColor: Colors.grey,
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                focusedErrorBorder: border,
                errorBorder: border,
                errorStyle:
                    TextStyle(color: Colors.white, backgroundColor: Colors.red),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: confirmUsernameC,
              enabled: !updating,
              cursorColor: primary,
              validator: (value) {
                if (value == usernameC.text) {
                  return null;
                }
                return "Username does not match";
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle_outlined),
                hintText: 'Confirm username',
                focusColor: Colors.grey,
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                focusedErrorBorder: border,
                errorBorder: border,
                errorStyle:
                    TextStyle(color: Colors.white, backgroundColor: Colors.red),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: updating
                        ? null
                        : () async {
                            if (formKey.currentState.validate()) {
                              setState(() {
                                updating = true;
                              });
                              final result = await profileRepo
                                  .updateUsername(usernameC.text);
                              if (result == null) {
                                Fluttertoast.showToast(
                                    msg: "Username updated successfully");
                                context.read<ProfileBloc>().add(
                                    ProfileUpdatedEvent(
                                        username: usernameC.text));
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Username already exists");
                              }
                              setState(() {
                                updating = false;
                              });
                            }
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => primary),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                    ),
                    child: Text("Update"))),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
