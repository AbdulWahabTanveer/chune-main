import 'package:flutter/foundation.dart';

abstract class Failure implements Exception {
  final String errorMassage;

  const Failure(this.errorMassage);
}


