
class LoginModel {
  final int guardId;
  final String firstname;
  final String lastname;
  final String username;
  final bool activeUser;
  final String role;
  final String profilePath;
  final String loginDateTime;
  final String createDateTime;
  final String token;

  const LoginModel({
    required this.guardId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.activeUser,
    required this.role,
    required this.profilePath,
    required this.loginDateTime,
    required this.createDateTime,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      guardId: json['guard_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      username: json['username'],
      activeUser: json['active_user'],
      role: json['role'],
      profilePath: json['profile_path'],
      loginDateTime: json['login_dateTime'],
      createDateTime: json['create_dateTime'],
      token: json['token'],
    );
  }
}
