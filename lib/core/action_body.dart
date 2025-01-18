import 'dart:convert';

class ActionBody {
  final int? id;
  final String? status;

  ActionBody({
    this.id,
    this.status,
  });

  factory ActionBody.fromRawJson(String str) =>
      ActionBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionBody.fromJson(Map<String, dynamic> json) => ActionBody(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}
