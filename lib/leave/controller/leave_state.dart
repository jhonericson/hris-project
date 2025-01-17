part of 'leave_bloc.dart';

sealed class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object> get props => [];
}

final class LeaveInitial extends LeaveState {}

final class LeaveLoading extends LeaveState {}

final class LeaveSuccess extends LeaveState {}

final class LeaveFailure extends LeaveState {}

final class LeaveApprovalInitial extends LeaveState {}

final class LeaveApprovalLoading extends LeaveState {}

final class LeaveApprovalSuccess extends LeaveState {}

final class LeaveApprovalFailure extends LeaveState {}
