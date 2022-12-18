part of 'choose_photo_bloc.dart';

@immutable
abstract class ChoosePhotoEvent extends Equatable {}

class ChoosePhoto extends ChoosePhotoEvent {
  final ImageSource source;

  ChoosePhoto({this.source});

  @override
  List<Object> get props => [source];
}
