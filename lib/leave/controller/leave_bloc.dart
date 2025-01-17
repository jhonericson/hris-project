import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial()) {
    on<LoadLeave>(_onLoadLeave);
    on<LoadLeaveApproval>(_onLoadLeaveApproval);
    on<ApproveLeave>(_onApproveLeave);
    on<RejectLeave>(_onRejectLeave);
  }

  void _onLoadLeave(
    LoadLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveLoading());
    try {
      
      emit(LeaveSuccess());
    } catch (e) {
      emit(LeaveFailure());
    }
  }

  void _onLoadLeaveApproval(
    LoadLeaveApproval event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveApprovalLoading());
    try {
      // Do something
      emit(LeaveApprovalSuccess());
    } catch (e) {
      emit(LeaveApprovalFailure());
    }
  }

  void _onApproveLeave(
    ApproveLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveApprovalLoading());
    try {
      // Do something
      emit(LeaveApprovalSuccess());
    } catch (e) {
      emit(LeaveApprovalFailure());
    }
  }

  _onRejectLeave(
    RejectLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveApprovalLoading());
    try {
      // Do something
      emit(LeaveApprovalSuccess());
    } catch (e) {
      emit(LeaveApprovalFailure());
    }
  }
}
