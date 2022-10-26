part of 'share_a_chune_bloc.dart';

abstract class ShareAChuneEvent {
  const ShareAChuneEvent();
}

class SearchChuneEvent extends ShareAChuneEvent {
  final String s;

  final bool force;

  SearchChuneEvent(this.s, {this.force = false});
}

class ShareChuneEvent extends ShareAChuneEvent {
  final Chune chune;
  final ProfileModel publishedBy;

  ShareChuneEvent(this.chune, this.publishedBy);
}
