import 'package:flutter/material.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({Key key}) : super(key: key);

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
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
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'Change username',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          SizedBox(
            height: 30,
          ),
          TextField(
            cursorColor: primary,
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
          Center(
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) => primary),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white),
                  ),
                  child: Text("Update"))),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
