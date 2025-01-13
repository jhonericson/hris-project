import 'dart:convert';

class LoginModel {
  final Result? result;

  LoginModel({
    this.result,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class Result {
  final bool? isAtasan;
  final bool? isHr;
  final String? nik;

  Result({
    this.isAtasan,
    this.isHr,
    this.nik,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        isAtasan: json["isAtasan"],
        isHr: json["isHr"],
        nik: json["nik"],
      );

  Map<String, dynamic> toJson() => {
        "isAtasan": isAtasan,
        "isHr": isHr,
        "nik": nik,
      };
}
