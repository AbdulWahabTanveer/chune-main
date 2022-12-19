import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/core/bloc/choose_photo_bloc/choose_photo_bloc.dart';

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
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'Upload profile photo',
        ),
      ),
      body: BlocBuilder<ChoosePhotoBloc, ChoosePhotoState>(
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
                                    state.path != null
                                ? FileImage(File(state.path))
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
              if (state is PhotoSelectedState && state.path != null)
                Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => primary),
                          foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white),
                        ),
                        child: Text("Upload"))),
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
