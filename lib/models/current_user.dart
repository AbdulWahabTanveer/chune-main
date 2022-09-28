enum UserType { spotify, apple }

class CurrentUser {
  final UserType type;
  final String token;
  final String storeFront;
  final String appleDevToken;

  CurrentUser({this.token, this.type, this.storeFront,this.appleDevToken});
}
