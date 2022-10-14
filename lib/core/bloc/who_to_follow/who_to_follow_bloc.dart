import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'who_to_follow_event.dart';
part 'who_to_follow_state.dart';

class WhoToFollowBloc extends Bloc<WhoToFollowEvent, WhoToFollowState> {
  WhoToFollowBloc() : super(WhoToFollowInitial()) {
    on<WhoToFollowEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
