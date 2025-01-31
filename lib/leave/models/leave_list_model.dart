import 'dart:convert';

class LeaveListModel {
  final List<LeaveListResultModel>? result;

  LeaveListModel({
    this.result,
  });

  factory LeaveListModel.fromRawJson(String str) =>
      LeaveListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveListModel.fromJson(Map<String, dynamic> json) => LeaveListModel(
        result: json["result"] == null
            ? []
            : List<LeaveListResultModel>.from(json["result"]!.map((x) => LeaveListResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class LeaveListResultModel {
  final int? id;
  final String? documentNumber;
  final String? employeeNik;
  final String? startDate;
  final String? endDate;
  final String? employeeName;
  final String? status;

  LeaveListResultModel({
    this.id,
    this.documentNumber,
    this.employeeNik,
    this.startDate,
    this.endDate,
    this.employeeName,
    this.status,
  });

  factory LeaveListResultModel.fromRawJson(String str) => LeaveListResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveListResultModel.fromJson(Map<String, dynamic> json) => LeaveListResultModel(
        id: json["Id"],
        documentNumber: json["DocumentNumber"],
        employeeNik: json["EmployeeNik"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        employeeName: json["EmployeeName"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DocumentNumber": documentNumber,
        "EmployeeNik": employeeNik,
        "StartDate": startDate,
        "EndDate": endDate,
        "EmployeeName": employeeName,
        "Status": status,
      };
}
