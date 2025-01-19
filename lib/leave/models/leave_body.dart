import 'dart:convert';

class LeaveRequestBody {
  final String? startDate;
  final String? endDate;
  final String? leaveType;
  final String? notes;

  LeaveRequestBody({
    this.startDate,
    this.endDate,
    this.leaveType,
    this.notes,
  });

  factory LeaveRequestBody.fromRawJson(String str) =>
      LeaveRequestBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveRequestBody.fromJson(Map<String, dynamic> json) =>
      LeaveRequestBody(
        startDate: json["startDate"],
        endDate: json["endDate"],
        leaveType: json["leaveType"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "leaveType": leaveType,
        "notes": notes,
      };
}
