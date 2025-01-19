import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../../core/enum.dart';
import '../../core/result_model.dart';
import '../../login/models/login_model.dart';
import '../models/attachment_body.dart';
import '../models/attendance_detail_model.dart';
import '../models/attendance_list_model.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceState()) {
    on<LoadAttendance>(_onLoadAttendance);
    on<LoadAttendanceApproval>(_onLoadAttendanceApproval);
    on<LoadAttendanceDetail>(_onLoadAttendanceDetail);
    on<ApproveAttendance>(_onApproveAttendance);
    on<RejectAttendance>(_onRejectAttendance);
    on<UploadAttendance>(_onUploadAttendance);
  }

  void _onLoadAttendance(
    LoadAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(listStatus: ListStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final response = await http.get(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/attendance/u1'),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
      if (response.statusCode == 200) {
        emit(state.copyWith(
          listStatus: ListStatus.success,
          attendanceList: AttendanceListModel.fromJson(data).result,
        ));
      } else {
        emit(state.copyWith(listStatus: ListStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _onLoadAttendanceApproval(
    LoadAttendanceApproval event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(approvalStatus: ApprovalStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final response = await http.get(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/attendance/u2'),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
      if (response.statusCode == 200) {
        emit(state.copyWith(
          approvalStatus: ApprovalStatus.success,
          attendanceApproval: AttendanceListModel.fromJson(data).result,
        ));
      } else {
        emit(state.copyWith(approvalStatus: ApprovalStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(approvalStatus: ApprovalStatus.failure));
    }
  }

  void _onApproveAttendance(
    ApproveAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    print("start");
    emit(state.copyWith(actionStatus: ActionStatus.loading));
    try {
      print("starting");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      print("startingxxxxx");
      final response = await http.patch(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/attendance'),
        body: {
          "id": event.id.toString(),
          "status": event.status,
        },
      );
      print("startingyyyyyy");
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
      if (response.statusCode == 200) {
        emit(state.copyWith(actionStatus: ActionStatus.success));
      } else {
        emit(state.copyWith(actionStatus: ActionStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(actionStatus: ActionStatus.failure));
    }
  }

  void _onRejectAttendance(
    RejectAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(actionStatus: ActionStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final response = await http.patch(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/attendance'),
        body: {
          "id": event.id.toString(),
          "status": event.status,
        },
      );
      // final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
      if (response.statusCode == 200) {
        emit(state.copyWith(actionStatus: ActionStatus.success));
      } else {
        emit(state.copyWith(actionStatus: ActionStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(actionStatus: ActionStatus.failure));
    }
  }

  void _onLoadAttendanceDetail(
    LoadAttendanceDetail event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(listStatus: ListStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final response = await http.get(
        headers: {
          "Nik": "${user.result?.nik}",
        },
        Uri.parse('$apiUrl/hris/v1/attendance/${event.id}'),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
      if (response.statusCode == 200) {
        emit(state.copyWith(
          listStatus: ListStatus.success,
          attendanceDetailModel: AttendanceDetailModel.fromJson(data),
        ));
      } else {
        emit(state.copyWith(listStatus: ListStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _onUploadAttendance(
    UploadAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    print("start");
    emit(state.copyWith(actionStatus: ActionStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      print("proses");
      final response = await http.post(
        headers: {
          "Nik": "${user.result?.nik}",
        },
        Uri.parse('$apiUrl/hris/v1/attendance'),
        body: AttendanceBody(
          attachment: event.base64image,
          geolocation: event.location,
          notes: event.notes,
        ).toJson(),
      );
      // final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} joko");
      if (response.statusCode == 200) {
        emit(state.copyWith(actionStatus: ActionStatus.success));
      } else {
        emit(state.copyWith(actionStatus: ActionStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(actionStatus: ActionStatus.loading));
    }
  }
}
