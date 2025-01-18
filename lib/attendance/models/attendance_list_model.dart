import 'dart:convert';

class AttendanceListModel {
  final List<AttendanceListResultModel>? result;

  AttendanceListModel({
    this.result,
  });

  factory AttendanceListModel.fromRawJson(String str) =>
      AttendanceListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) =>
      AttendanceListModel(
        result: json["result"] == null
            ? []
            : List<AttendanceListResultModel>.from(json["result"]!
                .map((x) => AttendanceListResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class AttendanceListResultModel {
  final int? id;
  final String? documentNumber;
  final String? employeeName;
  final String? employeeNik;
  final String? datetime;
  final String? geolocation;
  final String? notes;
  final String? status;

  AttendanceListResultModel({
    this.id,
    this.documentNumber,
    this.employeeName,
    this.employeeNik,
    this.datetime,
    this.geolocation,
    this.notes,
    this.status,
  });

  factory AttendanceListResultModel.fromRawJson(String str) =>
      AttendanceListResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceListResultModel.fromJson(Map<String, dynamic> json) =>
      AttendanceListResultModel(
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
