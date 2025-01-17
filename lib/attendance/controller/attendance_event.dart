part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendance extends AttendanceEvent {}

class LoadAttendanceApproval extends AttendanceEvent {}

class RejectAttendanceDetail extends AttendanceEvent {
  final int id;

  const RejectAttendanceDetail({required this.id});
  @override
  List<Object> get props => [id];
}

class ApproveAttendance extends AttendanceEvent {
  final int id;

  const ApproveAttendance({required this.id});
  @override
  List<Object> get props => [id];
}

class RejectAttendance extends AttendanceEvent {
  final int id;

  const RejectAttendance({required this.id});
  @override
  List<Object> get props => [id];
}


