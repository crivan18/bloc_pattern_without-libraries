class UserState {
  String _username = 'Guest';

  UserState._();

  static final UserState _instance = UserState._();

  factory UserState() => _instance;

  String get username => _username;

  void setUsername(String username) => _username = username;
}
