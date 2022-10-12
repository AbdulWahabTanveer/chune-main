import 'package:flutter/material.dart';

class ProfileModel {
  final String name;
  final String email;
  final String image;
  final String username;

  ProfileModel({this.name, this.email, this.image, @required this.username});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'image': this.image,
      'username': this.username,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      username: map['username'] as String,
    );
  }

  ProfileModel copyWith({
    String name,
    String email,
    String image,
    String username,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return 'ProfileModel{name: $name, email: $email, image: $image, username: $username}';
  }
}
