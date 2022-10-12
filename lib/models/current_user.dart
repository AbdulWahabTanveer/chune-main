enum MusicSourceType { spotify, apple }

class MusicSourceModel {
  final MusicSourceType type;
  final String token;
  final String storeFront;
  final String appleDevToken;

  MusicSourceModel({this.token, this.type, this.storeFront,this.appleDevToken});
}
