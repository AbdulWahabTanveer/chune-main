import 'package:flutter/material.dart';

Future<T> pushTo<T>(BuildContext context, Widget w,
    {bool replace = false, bool clear = false}) {
  if (clear) {
    return Navigator.of(context,rootNavigator: true).pushAndRemoveUntil<T>(
        MaterialPageRoute(builder: (c) => w), (route) => false);
  }
  if (replace) {
    return Navigator.of(context,rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (c) => w));
  }
  return Navigator.of(context,rootNavigator: true).push<T>(MaterialPageRoute(builder: (c) => w));
}

Widget loader() => Center(child: CircularProgressIndicator());
