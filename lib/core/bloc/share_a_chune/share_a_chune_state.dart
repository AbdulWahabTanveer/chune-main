part of 'share_a_chune_bloc.dart';

abstract class ShareAChuneState extends Equatable {
  const ShareAChuneState();
}

class ShareAChuneInitial extends ShareAChuneState {
  @override
  List<Object> get props => [];
}

class ChunesLoadSuccess extends ShareAChuneState {
  final List<Chune> chunes;

  ChunesLoadSuccess(this.chunes);

  @override
  List<Object> get props => [chunes];
}

class ChunesLoadingState extends ShareAChuneState {
  @override
  List<Object> get props => [];
}

class ChuneSharingState extends ShareAChuneState {
  @override
  List<Object> get props => [];
}

class ChuneShareSuccessState extends ShareAChuneState {
  @override
  List<Object> get props => [];
}

class ChuneShareErrorState extends ShareAChuneState {
  @override
  List<Object> get props => [];
}
