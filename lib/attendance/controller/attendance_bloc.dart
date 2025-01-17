import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../../login/models/login_model.dart';
import '../models/attendance_list_model.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    on<LoadAttendance>(_onLoadAttendance);
    on<LoadAttendanceApproval>(_onLoadAttendanceApproval);
    on<ApproveAttendance>(_onApproveAttendance);
    on<RejectAttendance>(_onRejectAttendance);
  }

  void _onLoadAttendance(
    LoadAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
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
        emit(
          AttendanceSuccess(
            attendanceListModel: AttendanceListModel.fromJson(data),
          ),
        );
      } else {
        emit(AttendanceFailure());
      }
    } catch (e) {
      emit(AttendanceFailure());
    }
  }

  void _onLoadAttendanceApproval(
    LoadAttendanceApproval event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceApprovalLoading());
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
        emit(
          AttendanceApprovalSuccess(
            attendanceListModel: AttendanceListModel.fromJson(data),
          ),
        );
      } else {
        emit(AttendanceApprovalFailure());
      }
    } catch (e) {
      emit(AttendanceApprovalFailure());
    }
  }

  void _onApproveAttendance(
    ApproveAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceActionLoading());
    try {
      // Do something
      emit(AttendanceActionSuccess());
    } catch (e) {
      emit(AttendanceActionFailure());
    }
  }

  _onRejectAttendance(
    RejectAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceActionLoading());
    try {
      // Do something
      emit(AttendanceActionSuccess());
    } catch (e) {
      emit(AttendanceActionFailure());
    }
  }
}
