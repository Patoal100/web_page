class User {
  String login;
  String password;

  User({required this.login, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}
