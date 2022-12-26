import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';
import '../../../repositories/profile_repository.dart';

part 'choose_photo_event.dart';

part 'choose_photo_state.dart';

class ChoosePhotoBloc extends Bloc<ChoosePhotoEvent, ChoosePhotoState> {
  final profileRepo = GetIt.I.get<ProfileRepository>();
  ChoosePhotoBloc() : super(ChoosePhotoInitial(GetIt.I.get<ProfileRepository>().getMyCachedProfile().image)) {
    on<ChoosePhoto>(_choosePhoto);
    on<UploadPhotoEvent>(_uploadPhoto);
  }

  Future<FutureOr<void>> _choosePhoto(
      ChoosePhoto event, Emitter<ChoosePhotoState> emit) async {
    try {
      final ImagePicker _picker = ImagePicker();

      final XFile image = await _picker.pickImage(source: event.source);

      CroppedFile croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.pink,
              hideBottomControls: false,
              initAspectRatio: CropAspectRatioPreset.square,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      emit(PhotoSelectedState(file: File(croppedFile.path)));
    } catch (e) {
      print('Choose photo error $e');
      emit(PhotoSelectedState());
    }
  }

  FutureOr<void> _uploadPhoto(UploadPhotoEvent event, Emitter<ChoosePhotoState> emit)async {

    if(state is PhotoSelectedState){
      final cast = state as PhotoSelectedState;
      emit(PhotoSelectedState(file: cast.file,uploading: true));
      final path = await profileRepo.updateProfileImage(event.file);
      emit(ProfileImageUploadSuccess(path));
    }
  }
}
