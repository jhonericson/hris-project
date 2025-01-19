import 'dart:convert';

class LeaveDetailModel {
  final Result? result;

  LeaveDetailModel({
    this.result,
  });

  factory LeaveDetailModel.fromRawJson(String str) =>
      LeaveDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveDetailModel.fromJson(Map<String, dynamic> json) =>
      LeaveDetailModel(
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
  final String? startDate;
  final String? endDate;
  final String? employeeName;
  final String? notes;
  final String? status;
  final String? type;

  Result({
    this.id,
    this.documentNumber,
    this.employeeNik,
    this.startDate,
    this.endDate,
    this.employeeName,
    this.notes,
    this.status,
    this.type,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["Id"],
        documentNumber: json["DocumentNumber"],
        employeeNik: json["EmployeeNik"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        employeeName: json["EmployeeName"],
        notes: json["Notes"],
        status: json["Status"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DocumentNumber": documentNumber,
        "EmployeeNik": employeeNik,
        "StartDate": startDate,
        "EndDate": endDate,
        "EmployeeName": employeeName,
        "Notes": notes,
        "Status": status,
        "Type": type,
      };
}
