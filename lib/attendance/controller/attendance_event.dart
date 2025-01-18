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
  final ActionBody body;

  const ApproveAttendance({required this.body});
  @override
  List<Object> get props => [body];
}

class RejectAttendance extends AttendanceEvent {
    final ActionBody body;

  const RejectAttendance({required this.body});
  @override
  List<Object> get props => [body];
}

class LoadAttendanceDetail extends AttendanceEvent {
  final int id;

  const LoadAttendanceDetail({required this.id});
  @override
  List<Object> get props => [id];
}

class UploadAttendance extends AttendanceEvent {
  final String base64image;
  final String location;
  final String notes;

  const UploadAttendance({
    required this.base64image,
    required this.location,
    required this.notes,
  });
  @override
  List<Object> get props => [
        base64image,
        location,
        notes,
      ];
}
