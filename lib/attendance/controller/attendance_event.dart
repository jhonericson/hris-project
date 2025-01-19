part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class LoadAttendance extends AttendanceEvent {}

class LoadAttendanceApproval extends AttendanceEvent {}

class ApproveAttendance extends AttendanceEvent {
  final int id;
  final String status;

  const ApproveAttendance({
    required this.id,
    required this.status,
  });
  @override
  List<Object> get props => [
        id,
        status,
      ];
}

class RejectAttendance extends AttendanceEvent {
  final int id;
  final String status;

  const RejectAttendance({
    required this.id,
    required this.status,
  });
  @override
  List<Object> get props => [
        id,
        status,
      ];
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
