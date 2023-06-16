import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../Useful_Code/constants.dart';

import '../../../repositories/profile_repository.dart';

part 'notification_counter_event.dart';

part 'notification_counter_state.dart';

class NotificationCounterBloc extends Bloc<int, int> {
  final profileRepo = GetIt.I.get<ProfileRepository>();

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> counterStream;

  NotificationCounterBloc() : super(0) {
    on<int>((event, emit) => emit(event));
    counterStream = profileRepo.myNotificationsCount.listen((event) {
      add(event.data()['unreadNotifications'] ?? 0);
    });
  }

  @override
  Future<void> close() {
    counterStream?.cancel();
    return super.close();
  }
}
