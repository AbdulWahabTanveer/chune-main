import 'package:flutter/material.dart';

class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String image;
  final String username;
  final int chunesShared;
  final int followerCount;
  final int followingCount;
  final String fcmToken;
  bool isFollowing;

//<editor-fold desc="Data Methods">

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.username,
    this.chunesShared = 0,
    this.followerCount = 0,
    this.followingCount = 0,
    this.fcmToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          image == other.image &&
          username == other.username &&
          chunesShared == other.chunesShared &&
          followerCount == other.followerCount &&
          followingCount == other.followingCount &&
          fcmToken == other.fcmToken);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      image.hashCode ^
      username.hashCode ^
      chunesShared.hashCode ^
      followerCount.hashCode ^
      followingCount.hashCode ^
      fcmToken.hashCode;

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
        ' followingCount: $followingCount,' +
        ' fcmToken: $fcmToken,' +
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
    int followingCount,
    String fcmToken,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      username: username ?? this.username,
      chunesShared: chunesShared ?? this.chunesShared,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      fcmToken: fcmToken ?? this.fcmToken,
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
      'followingCount': this.followingCount,
      'fcmToken': this.fcmToken,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      username: map['username'] as String,
      chunesShared: (map['chunesShared'] ?? 0) as int,
      followerCount: (map['followerCount'] ?? 0) as int,
      followingCount: (map['followingCount'] ?? 0) as int,
      fcmToken: map['fcmToken'] as String,
    );
  }

//</editor-fold>
}
