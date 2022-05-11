class AccountModel {
  final int id;
  final String username;
  final String password;

  const AccountModel({
    required this.id,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, username: $username, password: $password}';
  }
}
