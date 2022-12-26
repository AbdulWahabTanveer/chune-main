import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class NavBloc extends Bloc<int, int> {
  NavBloc() : super(0) {
    on<int>((event, emit) {
      emit(event);
    });
  }
}
