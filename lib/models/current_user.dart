enum UserType { spotify, apple }

class CurrentUser {
  final UserType type;
  final String token;

  CurrentUser({this.token, this.type});
}
