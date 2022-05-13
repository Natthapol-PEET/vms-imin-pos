class AccountModel {
  final int id;
  final String username;
  final String password;
  final int isLogin;

  const AccountModel({
    required this.id,
    required this.username,
    required this.password,
    required this.isLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'isLogin': isLogin,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, username: $username, password: $password, isLogin: $isLogin}';
  }
}
