import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../login/models/login_model.dart';
import '../models/leave_list_model.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial()) {
    on<LoadLeave>(_onLoadLeave);
    on<LoadLeaveApproval>(_onLoadLeaveApproval);
    on<ApproveLeave>(_onApproveLeave);
    on<RejectLeave>(_onRejectLeave);
  }

  void _onLoadLeave(
    LoadLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final response = await http.get(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/leave/u1'),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
      if (response.statusCode == 200) {
        emit(
          LeaveSuccess(
            leaveListModel: LeaveListModel.fromJson(data),
          ),
        );
      } else {
        emit(LeaveFailure());
      }
    } catch (e) {
      emit(LeaveFailure());
    }
  }

  void _onLoadLeaveApproval(
    LoadLeaveApproval event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveApprovalLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final response = await http.get(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/leave/u2'),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
      if (response.statusCode == 200) {
        emit(
          LeaveApprovalSuccess(
            leaveListModel: LeaveListModel.fromJson(data),
          ),
        );
      } else {
        emit(LeaveApprovalFailure());
      }
    } catch (e) {
      emit(LeaveApprovalFailure());
    }
  }

  void _onApproveLeave(
    ApproveLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveActionLoading());
    try {
      // Do something
      emit(LeaveActionSuccess());
    } catch (e) {
      emit(LeaveApprovalFailure());
    }
  }

  _onRejectLeave(
    RejectLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveActionLoading());
    try {
      // Do something
      emit(LeaveActionSuccess());
    } catch (e) {
      emit(LeaveActionFailure());
    }
  }
}
