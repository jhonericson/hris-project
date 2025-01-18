part of 'leave_bloc.dart';

sealed class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class LoadLeave extends LeaveEvent {}

class LoadLeaveApproval extends LeaveEvent {}

class RejectLeaveDetail extends LeaveEvent {
  final int id;

  const RejectLeaveDetail({required this.id});
  @override
  List<Object> get props => [id];
}

class ApproveLeave extends LeaveEvent {
  final int id;

  const ApproveLeave({required this.id});
  @override
  List<Object> get props => [id];
}

class RejectLeave extends LeaveEvent {
  final int id;

  const RejectLeave({required this.id});
  @override
  List<Object> get props => [id];
}

class LoadLeaveDetail extends LeaveEvent {
  final int id;

  const LoadLeaveDetail({required this.id});
  @override
  List<Object> get props => [id];
}
