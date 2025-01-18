import 'dart:convert';

class ResultModel {
  final Result? result;

  ResultModel({
    this.result,
  });

  factory ResultModel.fromRawJson(String str) =>
      ResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      ResultModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class Result {
  final String? message;
  final int? id;

  Result({
    this.message,
    this.id,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        message: json["message"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
      };
}
