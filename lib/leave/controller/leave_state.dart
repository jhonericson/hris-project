part of 'leave_bloc.dart';

sealed class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object> get props => [];
}

final class LeaveInitial extends LeaveState {}

final class LeaveLoading extends LeaveState {}

final class LeaveSuccess extends LeaveState {
  final LeaveListModel leaveListModel;

  const LeaveSuccess({required this.leaveListModel});
    @override
  List<Object> get props => [leaveListModel];
}

final class LeaveFailure extends LeaveState {}

final class LeaveApprovalLoading extends LeaveState {}

final class LeaveApprovalSuccess extends LeaveState {
  final LeaveListModel leaveListModel;

  const LeaveApprovalSuccess({required this.leaveListModel});
   @override
  List<Object> get props => [leaveListModel];
}

final class LeaveApprovalFailure extends LeaveState {}

final class LeaveActionLoading extends LeaveState {}

final class LeaveActionSuccess extends LeaveState {}

final class LeaveActionFailure extends LeaveState {}
