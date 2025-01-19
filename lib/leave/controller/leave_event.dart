part of 'leave_bloc.dart';

sealed class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class LoadLeave extends LeaveEvent {}

class LoadLeaveApproval extends LeaveEvent {}

class ApproveLeave extends LeaveEvent {
  final int id;
  final String status;

  const ApproveLeave({
    required this.id,
    required this.status,
  });
  @override
  List<Object> get props => [
        id,
        status,
      ];
}

class RejectLeave extends LeaveEvent {
  final int id;
  final String status;

  const RejectLeave({
    required this.id,
    required this.status,
  });
  @override
  List<Object> get props => [
        id,
        status,
      ];
}

class LoadLeaveDetail extends LeaveEvent {
  final int id;

  const LoadLeaveDetail({required this.id});
  @override
  List<Object> get props => [id];
}

class SubmitLeave extends LeaveEvent {
  final String startDate;
  final String endDate;
  final String leaveType;
  final String notes;

  const SubmitLeave({
    required this.startDate,
    required this.endDate,
    required this.leaveType,
    required this.notes,
  });

  @override
  List<Object> get props => [
        startDate,
        endDate,
        leaveType,
        notes,
      ];
}
