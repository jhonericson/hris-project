part of 'leave_bloc.dart';

class LeaveState extends Equatable {
  final ListStatus listStatus;
  final ApprovalStatus approvalStatus;
  final ActionStatus actionStatus;
  final List<LeaveListResultModel> leaveList;
  final List<LeaveListResultModel> leaveApproval;
  final LeaveDetailModel? leaveDetailModel;
  final ResultModel? result;

  const LeaveState({
    this.listStatus = ListStatus.initial,
    this.approvalStatus = ApprovalStatus.initial,
    this.actionStatus = ActionStatus.initial,
    this.leaveList = const <LeaveListResultModel>[],
    this.leaveApproval = const <LeaveListResultModel>[],
    this.leaveDetailModel,
    this.result,
  });
  LeaveState copyWith({
    ListStatus? listStatus,
    ApprovalStatus? approvalStatus,
    ActionStatus? actionStatus,
    List<LeaveListResultModel>? leaveList,
    List<LeaveListResultModel>? leaveApproval,
    LeaveDetailModel? leaveDetailModel,
    ResultModel? result,
  }) {
    return LeaveState(
      listStatus: listStatus ?? this.listStatus,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      actionStatus: actionStatus ?? this.actionStatus,
      leaveList: leaveList ?? this.leaveList,
      leaveApproval: leaveApproval ?? this.leaveApproval,
      leaveDetailModel:
          leaveDetailModel ?? this.leaveDetailModel,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        listStatus,
        approvalStatus,
        actionStatus,
        leaveList,
        leaveApproval,
        leaveDetailModel,
        result,
      ];
}
// sealed class LeaveState extends Equatable {
//   const LeaveState();

//   @override
//   List<Object> get props => [];
// }

// final class LeaveInitial extends LeaveState {}

// final class LeaveLoading extends LeaveState {}

// final class LeaveSuccess extends LeaveState {
//   final LeaveListModel leaveListModel;

//   const LeaveSuccess({required this.leaveListModel});
//     @override
//   List<Object> get props => [leaveListModel];
// }

// final class LeaveFailure extends LeaveState {}

// final class LeaveApprovalLoading extends LeaveState {}

// final class LeaveApprovalSuccess extends LeaveState {
//   final LeaveListModel leaveListModel;

//   const LeaveApprovalSuccess({required this.leaveListModel});
//    @override
//   List<Object> get props => [leaveListModel];
// }

// final class LeaveApprovalFailure extends LeaveState {}

// final class LeaveActionLoading extends LeaveState {}

// final class LeaveActionSuccess extends LeaveState {}

// final class LeaveActionFailure extends LeaveState {}
