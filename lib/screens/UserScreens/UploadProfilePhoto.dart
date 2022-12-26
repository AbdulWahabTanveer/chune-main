import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/Useful_Code/utils.dart';
import 'package:newapp/core/bloc/choose_photo_bloc/choose_photo_bloc.dart';
import 'package:newapp/core/bloc/profile/profile_bloc.dart';

import '../../auth_flow/app/bloc/app_bloc.dart';


class UploadProfilePhoto extends StatefulWidget {
  const UploadProfilePhoto({Key key}) : super(key: key);

  @override
  State<UploadProfilePhoto> createState() => _UploadProfilePhotoState();
}

class _UploadProfilePhotoState extends State<UploadProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'chune',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: BlocConsumer<ChoosePhotoBloc, ChoosePhotoState>(
        listener: (context, state) {
          if (state is ProfileImageUploadSuccess) {
            context
                .read<ProfileBloc>()
                .add(ProfileUpdatedEvent(imageUrl: state.file));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    fit: StackFit.loose,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.2),
                          image: DecorationImage(
                            image: state is PhotoSelectedState &&
                                    state.file != null
                                ? FileImage(state.file)
                                : state is ChoosePhotoInitial
                                    ? NetworkImage(state.image)
                                    : AssetImage('images/chune.jpeg'),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: -5,
                          right: -5,
                          child: Card(
                            margin: EdgeInsets.all(8),
                            child: IconButton(
                                onPressed: () {
                                  chooseImage();
                                },
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                icon: Icon(Icons.camera_alt)),
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              if (state is PhotoSelectedState && state.file != null)
                Center(
                    child: ElevatedButton(
                        onPressed: state.uploading
                            ? null
                            : () {
                                context
                                    .read<ChoosePhotoBloc>()
                                    .add(UploadPhotoEvent(state.file));
                              },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) =>
                                  state.uploading ? Colors.grey : primary),
                          foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state.uploading)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                    height: 16, width: 16, child: loader()),
                              ),
                            Text(state.uploading ? "Uploading" : "Upload"),
                          ],
                        ))),
              SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }

  void chooseImage() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Choose Photo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose profile photo from'),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context
                                  .read<ChoosePhotoBloc>()
                                  .add(ChoosePhoto(source: ImageSource.camera));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      Theme.of(context).primaryColor),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.white),
                            ),
                            child: Text("Camera")),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<ChoosePhotoBloc>().add(
                                  ChoosePhoto(source: ImageSource.gallery));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      Theme.of(context).primaryColor),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.white),
                            ),
                            child: Text("Gallery")),
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.black),
                      ),
                      child: Text("Close")),
                ),
              ],
            ));
  }
}
