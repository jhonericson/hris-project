import 'dart:convert';

class AttendanceDetailModel {
  final AttendanceDetailResultModel? result;

  AttendanceDetailModel({
    this.result,
  });

  factory AttendanceDetailModel.fromRawJson(String str) =>
      AttendanceDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) =>
      AttendanceDetailModel(
        result: json["result"] == null ? null : AttendanceDetailResultModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class AttendanceDetailResultModel {
  final int? id;
  final String? documentNumber;
  final String? employeeName;
  final String? employeeNik;
  final String? datetime;
  final String? geolocation;
  final String? notes;
  final String? status;

  AttendanceDetailResultModel({
    this.id,
    this.documentNumber,
    this.employeeName,
    this.employeeNik,
    this.datetime,
    this.geolocation,
    this.notes,
    this.status,
  });

  factory AttendanceDetailResultModel.fromRawJson(String str) => AttendanceDetailResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceDetailResultModel.fromJson(Map<String, dynamic> json) => AttendanceDetailResultModel(
        id: json["Id"],
        documentNumber: json["DocumentNumber"],
        employeeName: json["EmployeeName"],
        employeeNik: json["EmployeeNik"],
        datetime: json["Datetime"],
        geolocation: json["Geolocation"],
        notes: json["Notes"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DocumentNumber": documentNumber,
        "EmployeeName": employeeName,
        "EmployeeNik": employeeNik,
        "Datetime": datetime,
        "Geolocation": geolocation,
        "Notes": notes,
        "Status": status,
      };
}
