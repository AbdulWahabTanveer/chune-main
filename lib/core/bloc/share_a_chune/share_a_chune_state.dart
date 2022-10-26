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

  final bool end;

  final String search;

  ChunesLoadSuccess(this.chunes, {this.end = false, this.search = '',});

  @override
  List<Object> get props => [chunes,end,search];
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
