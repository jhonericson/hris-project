import 'dart:convert';

class AttendanceBody {
  final String? attachment;
  final String? geolocation;
  final String? notes;

  AttendanceBody({
    this.attachment,
    this.geolocation,
    this.notes,
  });

  factory AttendanceBody.fromRawJson(String str) =>
      AttendanceBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceBody.fromJson(Map<String, dynamic> json) => AttendanceBody(
        attachment: json["attachment"],
        geolocation: json["geolocation"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "attachment": attachment,
        "geolocation": geolocation,
        "notes": notes,
      };
}
