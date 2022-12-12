import 'package:equatable/equatable.dart';
import 'package:newapp/models/current_user.dart';

class Chune extends Equatable {
  final String id;
  final String preview;
  final String playUri;
  final String albumArt;
  final String songName;
  final String artistName;
  final MusicSourceType source;
  final int durationInMills;
  final String userId;
  final String username;
  final String userImage;
  final int likeCount;
  final int timestamp;

  bool isLiked = false;

  Map<String, dynamic> appleObj;

//<editor-fold desc="Data Methods">

  Chune({
    this.id,
    this.preview,
    this.playUri,
    this.albumArt,
    this.songName,
    this.artistName,
    this.source,
    this.userId,
    this.username,
    this.userImage,
    this.likeCount,
    this.timestamp,
    this.isLiked = false,
    this.appleObj,
    this.durationInMills
  });



  @override
  String toString() {
    return 'Chune{' +
        ' id: $id,' +
        ' preview: $preview,' +
        ' playUri: $playUri,' +
        ' albumArt: $albumArt,' +
        ' songName: $songName,' +
        ' artistName: $artistName,' +
        ' source: $source,' +
        ' userId: $userId,' +
        ' username: $username,' +
        ' userImage: $userImage,' +
        ' likeCount: $likeCount,' +
        ' timestamp: $timestamp,' +
        ' isLiked: $isLiked,' +
        ' durationInMills: $durationInMills,' +
        '}';
  }

  Chune copyWith({
    String id,
    String preview,
    String playUri,
    String albumArt,
    String songName,
    String artistName,
    MusicSourceType source,
    String userId,
    String username,
    String userImage,
    int likeCount,
    int timestamp,
    bool isLiked,
    int durationInMills,
  }) {
    return Chune(
      id: id ?? this.id,
      preview: preview ?? this.preview,
      playUri: playUri ?? this.playUri,
      albumArt: albumArt ?? this.albumArt,
      songName: songName ?? this.songName,
      artistName: artistName ?? this.artistName,
      source: source ?? this.source,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userImage: userImage ?? this.userImage,
      likeCount: likeCount ?? this.likeCount,
      timestamp: timestamp ?? this.timestamp,
      isLiked: isLiked ?? this.isLiked,
      durationInMills: durationInMills ?? this.durationInMills,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'preview': this.preview,
      'playUri': this.playUri,
      'albumArt': this.albumArt,
      'songName': this.songName,
      'artistName': this.artistName,
      'source': sourceToString[this.source],
      'userId': this.userId,
      'username': this.username,
      'userImage': this.userImage,
      'likeCount': this.likeCount,
      'timestamp': this.timestamp,
      'isLiked': this.isLiked,
      'appleObj': this.appleObj,
      'durationInMills': this.durationInMills
    };
  }

  factory Chune.fromMap(Map<String, dynamic> map) {
    return Chune(
        id: map['id'] as String,
        preview: map['preview'] as String,
        playUri: map['playUri'] as String,
        albumArt: map['albumArt'] as String,
        songName: map['songName'] as String,
        artistName: map['artistName'] as String,
        source: stringToSource[map['source']],
        userId: map['userId'] as String,
        username: map['username'] as String,
        userImage: map['userImage'] as String,
        likeCount: map['likeCount'] as int,
        timestamp: map['timestamp'] as int,
        durationInMills: map['durationInMills'] as int,
        isLiked: map['isLiked'] as bool,
        appleObj: map['appleObj']);
  }

  @override
  List<Object> get props => [id, playUri,likeCount,isLiked];

//</editor-fold>
}
