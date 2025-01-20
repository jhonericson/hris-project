import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../constant/font_const.dart';
import '../core/enum.dart';
import '../widgets/button.dart';
import 'controller/leave_bloc.dart';

class LeaveDetailPage extends StatelessWidget {
  final int id;
  final String source;
  const LeaveDetailPage({
    super.key,
    required this.id,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveBloc()..add(LoadLeaveDetail(id: id)),
      child: LeaveDetailPageView(
        id: id,
        source: source,
      ),
    );
  }
}

class LeaveDetailPageView extends StatelessWidget {
  final int id;
  final String source;
  const LeaveDetailPageView({
    super.key,
    required this.id,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Leave Detail'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Field Tipe Cuti
              Text(
                'Tipe Cuti:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              BlocBuilder<LeaveBloc, LeaveState>(
                builder: (context, state) {
                  if (state.listStatus == ListStatus.success) {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            state.leaveDetailModel?.result?.type ?? "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Loading...",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),

              // Field Tanggal
              Text(
                'Tanggal:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              BlocBuilder<LeaveBloc, LeaveState>(
                builder: (context, state) {
                  if (state.listStatus == ListStatus.success) {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${state.leaveDetailModel?.result?.startDate} - ${state.leaveDetailModel?.result?.endDate}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Loading...",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),

              // Field Note
              Text(
                'Catatan:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              BlocBuilder<LeaveBloc, LeaveState>(
                builder: (context, state) {
                  if (state.listStatus == ListStatus.success) {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            state.leaveDetailModel?.result?.notes ?? "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Loading...",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocListener<LeaveBloc, LeaveState>(
          listener: (context, state) {
            print("${state.actionStatus} upi");
            if (state.actionStatus == ActionStatus.loading) {
              EasyLoading.show(
                status: "Please Wait...",
                dismissOnTap: true,
              );
              print("joko");
            } else if (state.actionStatus == ActionStatus.success) {
              EasyLoading.showSuccess("Success");
              EasyLoading.dismiss();
              Navigator.pop(context, "ok");
            } else if (state.actionStatus == ActionStatus.failure) {
              EasyLoading.showError("Failed");
              EasyLoading.dismiss();
            }
          },
          child: source == Source.approval.name
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonGradient(
                        height: kToolbarHeight,
                        borderRadius: BorderRadius.circular(10),
                        width: size.width * 0.4,
                        onPressed: () {
                          context.read<LeaveBloc>().add(
                                RejectLeave(
                                  id: id,
                                  status: "reject",
                                ),
                              );
                        },
                        child: Text(
                          "Reject",
                          style: kfWhite14Medium,
                        ),
                      ),
                      ButtonGradient(
                        height: kToolbarHeight,
                        borderRadius: BorderRadius.circular(10),
                        width: size.width * 0.4,
                        onPressed: () {
                          showOkCancelAlertDialog(
                            context: context,
                            title: 'Approve',
                            message: 'Are you sure to approve this request?',
                          ).then(
                            (value) {
                              if (value == OkCancelResult.ok) {
                                context.read<LeaveBloc>().add(
                                      ApproveLeave(
                                        id: id,
                                        status: "approve",
                                      ),
                                    );
                              }
                            },
                          );
                        },
                        child: Text(
                          "Approve",
                          style: kfWhite14Medium,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ));
  }
}
