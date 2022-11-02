part of 'notification_counter_bloc.dart';

abstract class NotificationCounterState extends Equatable {
  const NotificationCounterState();
}

class NotificationCounterInitial extends NotificationCounterState {
  @override
  List<Object> get props => [];
}
