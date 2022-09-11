part of 'share_a_chune_bloc.dart';

abstract class ShareAChuneEvent {
  const ShareAChuneEvent();
}

class SearchChuneEvent extends ShareAChuneEvent {
  final String s;

  SearchChuneEvent(this.s);
}
