import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'choose_photo_event.dart';
part 'choose_photo_state.dart';

class ChoosePhotoBloc extends Bloc<ChoosePhotoEvent, ChoosePhotoState> {
  ChoosePhotoBloc() : super(ChoosePhotoInitial()) {
    on<ChoosePhotoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
