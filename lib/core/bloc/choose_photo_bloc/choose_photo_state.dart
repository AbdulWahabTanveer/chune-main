part of 'choose_photo_bloc.dart';

abstract class ChoosePhotoState extends Equatable {
  const ChoosePhotoState();
}

class ChoosePhotoInitial extends ChoosePhotoState {
  ChoosePhotoInitial();

  @override
  List<Object> get props => [];
}

class PhotoSelectedState extends ChoosePhotoState {
  final String path;

  PhotoSelectedState({this.path});

  @override
  List<Object> get props => [path];
}
