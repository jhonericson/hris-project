import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../core/enum.dart';
import '../../core/result_model.dart';
import '../../login/models/login_model.dart';
import '../models/leave_body.dart';
import '../models/leave_detail_model.dart';
import '../models/leave_list_model.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveState()) {
    on<LoadLeave>(_onLoadLeave);
    on<LoadLeaveApproval>(_onLoadLeaveApproval);
    on<ApproveLeave>(_onApproveLeave);
    on<RejectLeave>(_onRejectLeave);
    on<LoadLeaveDetail>(_onLoadLeaveDetail);
    on<SubmitLeave>(_onSubmitLeave);
  }

  Future<void> _onLoadLeaveDetail(
      LoadLeaveDetail event, Emitter<LeaveState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dataLogin = prefs.getString("login");
    final user = LoginModel.fromJson(jsonDecode(dataLogin!));
    final response = await http.get(
      headers: {"Nik": "${user.result?.nik}"},
      Uri.parse('$apiUrl/hris/v1/leave/${event.id}'),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(
        "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} xxx");
    if (response.statusCode == 200) {
      emit(
        state.copyWith(
          listStatus: ListStatus.success,
          leaveDetailModel: LeaveDetailModel.fromJson(data),
        ),
      );
    } else {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _onLoadLeave(
    LoadLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(listStatus: ListStatus.loading));
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
          state.copyWith(
            listStatus: ListStatus.success,
            leaveList: LeaveListModel.fromJson(data).result,
          ),
        );
      } else {
        emit(state.copyWith(listStatus: ListStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _onLoadLeaveApproval(
    LoadLeaveApproval event,
    Emitter<LeaveState> emit,
  ) async {
    emit(
      state.copyWith(
        approvalStatus: ApprovalStatus.loading,
      ),
    );
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
          state.copyWith(
            approvalStatus: ApprovalStatus.success,
            leaveApproval: LeaveListModel.fromJson(data).result,
          ),
        );
      } else {
        emit(
          state.copyWith(
            approvalStatus: ApprovalStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          approvalStatus: ApprovalStatus.failure,
        ),
      );
    }
  }

  void _onApproveLeave(
    ApproveLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(actionStatus: ActionStatus.loading));
    try {
      print("starting");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      print("startingxxxxx");
      final response = await http.patch(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/leave'),
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

  void _onRejectLeave(
    RejectLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(actionStatus: ActionStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final response = await http.patch(
        headers: {"Nik": "${user.result?.nik}"},
        Uri.parse('$apiUrl/hris/v1/leave'),
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

  Future<void> _onSubmitLeave(
    SubmitLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(actionStatus: ActionStatus.loading));

    emit(state.copyWith(actionStatus: ActionStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataLogin = prefs.getString("login");
      final user = LoginModel.fromJson(jsonDecode(dataLogin!));
      final body = LeaveRequestBody(
        startDate: event.startDate,
        endDate: event.endDate,
        leaveType: event.leaveType,
        notes: event.notes,
      ).toJson();
      print("proses");
      final response = await http.post(
        headers: {
          "Nik": "${user.result?.nik}",
        },
        Uri.parse('$apiUrl/hris/v1/leave'),
        body: body,
      );
      print(jsonEncode(body));
      // final Map<String, dynamic> data = jsonDecode(response.body);
      print(
          "${response.headers},${response.statusCode},${response.body} , ${user.result?.nik} joko");
      if (response.statusCode == 200) {
        emit(state.copyWith(actionStatus: ActionStatus.success));
      } else {
        emit(state.copyWith(actionStatus: ActionStatus.failure));
      }
      emit(state.copyWith(actionStatus: ActionStatus.success));
    } catch (e) {
      emit(state.copyWith(actionStatus: ActionStatus.failure));
    }
  }
}
