part of 'choose_photo_bloc.dart';

abstract class ChoosePhotoState extends Equatable {
  const ChoosePhotoState();
}

class ChoosePhotoInitial extends ChoosePhotoState {
  final String image;

  ChoosePhotoInitial(this.image);

  @override
  List<Object> get props => [image];
}

class PhotoSelectedState extends ChoosePhotoState {
  final File file;
  final bool uploading;
  PhotoSelectedState({this.file,this.uploading=false});

  @override
  List<Object> get props => [file,uploading];
}


class UploadProfileImageLoading extends ChoosePhotoState {

  UploadProfileImageLoading();

  @override
  List<Object> get props => [];
}


class ProfileImageUploadSuccess extends ChoosePhotoState {
  final String file;

  ProfileImageUploadSuccess(this.file);

  @override
  List<Object> get props => [file];
}


