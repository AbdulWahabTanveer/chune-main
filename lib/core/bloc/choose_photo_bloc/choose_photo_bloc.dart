import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'choose_photo_event.dart';

part 'choose_photo_state.dart';

class ChoosePhotoBloc extends Bloc<ChoosePhotoEvent, ChoosePhotoState> {
  ChoosePhotoBloc() : super(ChoosePhotoInitial()) {
    on<ChoosePhoto>(_choosePhoto);
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

      emit(PhotoSelectedState(path: croppedFile.path));
    } catch (e) {
      print('Choose photo error $e');
      emit(PhotoSelectedState());
    }
  }
}
