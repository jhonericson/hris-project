import 'dart:convert';

class AttendanceDetailModel {
  final Result? result;

  AttendanceDetailModel({
    this.result,
  });

  factory AttendanceDetailModel.fromRawJson(String str) =>
      AttendanceDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) =>
      AttendanceDetailModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class Result {
  final int? id;
  final String? documentNumber;
  final String? employeeNik;
  final String? employeeName;
  final String? datetime;
  final String? geolocation;
  final String? notes;
  final String? attachment;
  final String? status;

  Result({
    this.id,
    this.documentNumber,
    this.employeeNik,
    this.employeeName,
    this.datetime,
    this.geolocation,
    this.notes,
    this.attachment,
    this.status,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["Id"],
        documentNumber: json["DocumentNumber"],
        employeeNik: json["EmployeeNik"],
        employeeName: json["EmployeeName"],
        datetime: json["Datetime"],
        geolocation: json["Geolocation"],
        notes: json["Notes"],
        attachment: json["Attachment"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DocumentNumber": documentNumber,
        "EmployeeNik": employeeNik,
        "EmployeeName": employeeName,
        "Datetime": datetime,
        "Geolocation": geolocation,
        "Notes": notes,
        "Attachment": attachment,
        "Status": status,
      };
}
