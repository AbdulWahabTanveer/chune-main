enum MusicSourceType { spotify, apple }

class MusicSourceModel {
  final MusicSourceType type;
  final String token;
  final String storeFront;
  final String appleDevToken;

//<editor-fold desc="Data Methods">

  const MusicSourceModel({
    this.type,
    this.token,
    this.storeFront,
    this.appleDevToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MusicSourceModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          token == other.token &&
          storeFront == other.storeFront &&
          appleDevToken == other.appleDevToken);

  @override
  int get hashCode =>
      type.hashCode ^
      token.hashCode ^
      storeFront.hashCode ^
      appleDevToken.hashCode;

  @override
  String toString() {
    return 'MusicSourceModel{' +
        ' type: $type,' +
        ' token: $token,' +
        ' storeFront: $storeFront,' +
        ' appleDevToken: $appleDevToken,' +
        '}';
  }

  MusicSourceModel copyWith({
    MusicSourceType type,
    String token,
    String storeFront,
    String appleDevToken,
  }) {
    return MusicSourceModel(
      type: type ?? this.type,
      token: token ?? this.token,
      storeFront: storeFront ?? this.storeFront,
      appleDevToken: appleDevToken ?? this.appleDevToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': sourceToString[this.type],
      'token': this.token,
      'storeFront': this.storeFront,
      'appleDevToken': this.appleDevToken,
    };
  }

  factory MusicSourceModel.fromMap(Map<String, dynamic> map) {
    return MusicSourceModel(
      type: stringToSource[map['type']],
      token: map['token'] as String,
      storeFront: map['storeFront'] as String,
      appleDevToken: map['appleDevToken'] as String,
    );
  }

//</editor-fold>
}
Map<String, MusicSourceType> stringToSource = {
  "spotify": MusicSourceType.spotify,
  "apple": MusicSourceType.apple
};

Map<MusicSourceType, String> sourceToString = {
  MusicSourceType.spotify: "spotify",
  MusicSourceType.apple: "apple"
};