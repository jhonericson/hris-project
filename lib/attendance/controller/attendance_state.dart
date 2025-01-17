part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {
  final AttendanceListModel attendanceListModel;

  const AttendanceSuccess({required this.attendanceListModel});
  @override
  List<Object> get props => [attendanceListModel];
}

final class AttendanceFailure extends AttendanceState {}

final class AttendanceApprovalInitial extends AttendanceState {}

final class AttendanceApprovalLoading extends AttendanceState {}

final class AttendanceApprovalSuccess extends AttendanceState {
    final AttendanceListModel attendanceListModel;

  const AttendanceApprovalSuccess({required this.attendanceListModel});
  @override
  List<Object> get props => [attendanceListModel];
}

final class AttendanceApprovalFailure extends AttendanceState {}

class AttendanceActionInitial extends AttendanceState {}

class AttendanceActionLoading extends AttendanceState {}

class AttendanceActionSuccess extends AttendanceState {}

class AttendanceActionFailure extends AttendanceState {}
