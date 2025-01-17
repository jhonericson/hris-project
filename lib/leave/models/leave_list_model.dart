import 'dart:convert';

class LeaveListModel {
  final List<LeaveListResultModel>? result;

  LeaveListModel({
    this.result,
  });

  factory LeaveListModel.fromRawJson(String str) =>
      LeaveListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveListModel.fromJson(Map<String, dynamic> json) =>
      LeaveListModel(
        result: json["result"] == null
            ? []
            : List<LeaveListResultModel>.from(json["result"]!
                .map((x) => LeaveListResultModel.fromJson(x))),
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
  final String? datetime;
  final String? geolocation;
  final String? notes;
  final String? status;

  LeaveListResultModel({
    this.id,
    this.documentNumber,
    this.employeeNik,
    this.datetime,
    this.geolocation,
    this.notes,
    this.status,
  });

  factory LeaveListResultModel.fromRawJson(String str) =>
      LeaveListResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveListResultModel.fromJson(Map<String, dynamic> json) =>
      LeaveListResultModel(
        id: json["Id"],
        documentNumber: json["DocumentNumber"],
        employeeNik: json["EmployeeNik"],
        datetime: json["Datetime"],
        geolocation: json["Geolocation"],
        notes: json["Notes"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DocumentNumber": documentNumber,
        "EmployeeNik": employeeNik,
        "Datetime": datetime,
        "Geolocation": geolocation,
        "Notes": notes,
        "Status": status,
      };
}
