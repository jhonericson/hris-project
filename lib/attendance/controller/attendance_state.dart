part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final ListStatus listStatus;
  final ApprovalStatus approvalStatus;
  final ActionStatus actionStatus;
  final List<AttendanceListResultModel> attendanceList;
  final List<AttendanceListResultModel> attendanceApproval;
  final AttendanceDetailModel? attendanceDetailModel;
  final ResultModel? result;

  const AttendanceState({
    this.listStatus = ListStatus.initial,
    this.approvalStatus = ApprovalStatus.initial,
    this.actionStatus = ActionStatus.initial,
    this.attendanceList = const <AttendanceListResultModel>[],
    this.attendanceApproval = const <AttendanceListResultModel>[],
    this.attendanceDetailModel,
    this.result,
  });
  AttendanceState copyWith({
    ListStatus? listStatus,
    ApprovalStatus? approvalStatus,
    ActionStatus? actionStatus,
    List<AttendanceListResultModel>? attendanceList,
    List<AttendanceListResultModel>? attendanceApproval,
    AttendanceDetailModel? attendanceDetailModel,
    ResultModel? result,
  }) {
    return AttendanceState(
      listStatus: listStatus ?? this.listStatus,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      actionStatus: actionStatus ?? this.actionStatus,
      attendanceList: attendanceList ?? this.attendanceList,
      attendanceApproval: attendanceApproval ?? this.attendanceApproval,
      attendanceDetailModel: attendanceDetailModel??this.attendanceDetailModel,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        listStatus,
        approvalStatus,
        actionStatus,
        attendanceList,
        attendanceApproval,
        attendanceDetailModel,
        result,
      ];
}
// sealed class AttendanceState extends Equatable {
//   const AttendanceState();

//   @override
//   List<Object> get props => [];
// }

// final class AttendanceInitial extends AttendanceState {}

// final class AttendanceLoading extends AttendanceState {}

// final class AttendanceSuccess extends AttendanceState {
//   final AttendanceListModel attendanceListModel;

//   const AttendanceSuccess({required this.attendanceListModel});
//   @override
//   List<Object> get props => [attendanceListModel];
// }

// final class AttendanceFailure extends AttendanceState {}

// final class AttendanceApprovalInitial extends AttendanceState {}

// final class AttendanceApprovalLoading extends AttendanceState {}

// final class AttendanceApprovalSuccess extends AttendanceState {
//     final AttendanceListModel attendanceListModel;

//   const AttendanceApprovalSuccess({required this.attendanceListModel});
//   @override
//   List<Object> get props => [attendanceListModel];
// }

// final class AttendanceApprovalFailure extends AttendanceState {}

// class AttendanceActionInitial extends AttendanceState {}

// class AttendanceActionLoading extends AttendanceState {}

// class AttendanceActionSuccess extends AttendanceState {}

// class AttendanceActionFailure extends AttendanceState {}
