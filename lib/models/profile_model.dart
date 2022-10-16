import 'package:flutter/material.dart';

class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String image;
  final String username;
  final int chunesShared;
  final int followerCount;

  bool isFollowing;

//<editor-fold desc="Data Methods">

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.username,
    this.chunesShared,
    this.followerCount,
    this.isFollowing=false
  });

  @override
  String toString() {
    return 'ProfileModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' email: $email,' +
        ' image: $image,' +
        ' username: $username,' +
        ' chunesShared: $chunesShared,' +
        ' followerCount: $followerCount,' +
        '}';
  }

  ProfileModel copyWith({
    String id,
    String name,
    String email,
    String image,
    String username,
    int chunesShared,
    int followerCount,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      username: username ?? this.username,
      chunesShared: chunesShared ?? this.chunesShared,
      followerCount: followerCount ?? this.followerCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'image': this.image,
      'username': this.username,
      'chunesShared': this.chunesShared,
      'followerCount': this.followerCount,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      username: map['username'] as String,
      chunesShared: map['chunesShared'] as int,
      followerCount: map['followerCount'] as int,
    );
  }

//</editor-fold>
}
