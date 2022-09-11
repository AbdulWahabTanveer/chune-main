part of 'share_a_chune_bloc.dart';

abstract class ShareAChuneState extends Equatable {
  const ShareAChuneState();
}

class ShareAChuneInitial extends ShareAChuneState {
  @override
  List<Object> get props => [];
}

class ChunesLoadSuccess extends ShareAChuneState {
  final SpotifyModel model;

  ChunesLoadSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class ChunesLoadingState extends ShareAChuneState {
  @override
  List<Object> get props => [];
}
