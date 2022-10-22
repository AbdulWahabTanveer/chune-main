import 'package:flutter/material.dart';

class ProfileModel {
  final String id;

  // final String name;
  final String email;
  final String image;
  final String username;
  final int chunesShared;
  final int followerCount;
  final int followingCount;
  final String fcmToken;
  bool isFollowing;

  final List<String> followers;
  final List<String> followings;
  final List<String> likedChunes;
  final List<String> sharedChunes;

//<editor-fold desc="Data Methods">

  ProfileModel({
    this.id,
    this.email,
    this.image,
    this.username,
    this.chunesShared,
    this.followerCount,
    this.followingCount,
    this.fcmToken,
    this.isFollowing,
    this.followers,
    this.followings,
    this.likedChunes,
    this.sharedChunes,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          image == other.image &&
          username == other.username &&
          chunesShared == other.chunesShared &&
          followerCount == other.followerCount &&
          followingCount == other.followingCount &&
          fcmToken == other.fcmToken &&
          isFollowing == other.isFollowing &&
          followers == other.followers &&
          followings == other.followings &&
          likedChunes == other.likedChunes &&
          sharedChunes == other.sharedChunes);

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      image.hashCode ^
      username.hashCode ^
      chunesShared.hashCode ^
      followerCount.hashCode ^
      followingCount.hashCode ^
      fcmToken.hashCode ^
      isFollowing.hashCode ^
      followers.hashCode ^
      followings.hashCode ^
      likedChunes.hashCode ^
      sharedChunes.hashCode;

  @override
  String toString() {
    return 'ProfileModel{' +
        ' id: $id,' +
        ' email: $email,' +
        ' image: $image,' +
        ' username: $username,' +
        ' chunesShared: $chunesShared,' +
        ' followerCount: $followerCount,' +
        ' followingCount: $followingCount,' +
        ' fcmToken: $fcmToken,' +
        ' isFollowing: $isFollowing,' +
        ' followers: $followers,' +
        ' followings: $followings,' +
        ' likedChunes: $likedChunes,' +
        ' sharedChunes: $sharedChunes,' +
        '}';
  }

  ProfileModel copyWith({
    String id,
    String email,
    String image,
    String username,
    int chunesShared,
    int followerCount,
    int followingCount,
    String fcmToken,
    bool isFollowing,
    List<String> followers,
    List<String> followings,
    List<String> likedChunes,
    List<String> sharedChunes,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      image: image ?? this.image,
      username: username ?? this.username,
      chunesShared: chunesShared ?? this.chunesShared,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      fcmToken: fcmToken ?? this.fcmToken,
      isFollowing: isFollowing ?? this.isFollowing,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      likedChunes: likedChunes ?? this.likedChunes,
      sharedChunes: sharedChunes ?? this.sharedChunes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'image': this.image,
      'username': this.username,
      'chunesShared': this.chunesShared,
      'followerCount': this.followerCount,
      'followingCount': this.followingCount,
      'fcmToken': this.fcmToken,
      'isFollowing': this.isFollowing,
      'followers': this.followers,
      'followings': this.followings,
      'likedChunes': this.likedChunes,
      'sharedChunes': this.sharedChunes,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      username: map['username'] as String,
      chunesShared: map['chunesShared'] as int,
      followerCount: map['followerCount'] as int,
      followingCount: map['followingCount'] as int,
      fcmToken: map['fcmToken'] as String,
      isFollowing: map['isFollowing'] as bool,
      followers: List<String>.from((map['followers'] ?? <String>[])),
      followings: List<String>.from((map['following'] ?? <String>[])),
      likedChunes: List<String>.from((map['likedChunes'] ?? <String>[])),
      sharedChunes: List<String>.from((map['chunes'] ?? <String>[])),
    );
  }

//</editor-fold>
}
