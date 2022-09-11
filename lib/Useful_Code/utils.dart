import 'package:flutter/material.dart';

Future<T> pushTo<T>(BuildContext context, Widget w,
    {bool replace = false, bool clear = false}) {
  if (clear) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
        MaterialPageRoute(builder: (c) => w), (route) => false);
  }
  if (replace) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (c) => w));
  }
  return Navigator.of(context).push<T>(MaterialPageRoute(builder: (c) => w));
}

Widget loader() => Center(child: CircularProgressIndicator());
