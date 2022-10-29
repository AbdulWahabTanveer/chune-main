import 'package:newapp/models/current_user.dart';


class Chune {
  final String id;
  final String preview;
  final String playUri;
  final String albumArt;
  final String songName;
  final String artistName;
  final MusicSourceType source;

  final String userId;
  final String username;
  final String userImage;
  final int likeCount;
  final int timestamp;

  bool isLiked = false;

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
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chune &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          preview == other.preview &&
          playUri == other.playUri &&
          albumArt == other.albumArt &&
          songName == other.songName &&
          artistName == other.artistName &&
          source == other.source &&
          userId == other.userId &&
          username == other.username &&
          userImage == other.userImage &&
          likeCount == other.likeCount &&
          timestamp == other.timestamp &&
          isLiked == other.isLiked);

  @override
  int get hashCode =>
      id.hashCode ^
      preview.hashCode ^
      playUri.hashCode ^
      albumArt.hashCode ^
      songName.hashCode ^
      artistName.hashCode ^
      source.hashCode ^
      userId.hashCode ^
      username.hashCode ^
      userImage.hashCode ^
      likeCount.hashCode ^
      timestamp.hashCode ^
      isLiked.hashCode;

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
      'source': _sourceToString[this.source],
      'userId': this.userId,
      'username': this.username,
      'userImage': this.userImage,
      'likeCount': this.likeCount,
      'timestamp': this.timestamp,
      'isLiked': this.isLiked,
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
      source: _stringToSource[map['source']],
      userId: map['userId'] as String,
      username: map['username'] as String,
      userImage: map['userImage'] as String,
      likeCount: map['likeCount'] as int,
      timestamp: map['timestamp'] as int,
      isLiked: map['isLiked'] as bool,
    );
  }

//</editor-fold>
}

Map<String, MusicSourceType> _stringToSource = {
  "spotify": MusicSourceType.spotify,
  "apple": MusicSourceType.apple
};

Map<MusicSourceType, String> _sourceToString = {
  MusicSourceType.spotify: "spotify",
  MusicSourceType.apple: "apple"
};
