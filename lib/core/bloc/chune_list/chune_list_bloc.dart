import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chune_list_event.dart';
part 'chune_list_state.dart';

class ChuneListBloc extends Bloc<ChuneListEvent, ChuneListState> {
  ChuneListBloc() : super(ChuneListInitial()) {
    on<ChuneListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
