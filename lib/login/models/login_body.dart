import 'dart:convert';

class LoginBody {
  final String? username;
  final String? password;

  LoginBody({
    this.username,
    this.password,
  });

  factory LoginBody.fromRawJson(String str) =>
      LoginBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginBody.fromJson(Map<String, dynamic> json) => LoginBody(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
