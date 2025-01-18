import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_skripsi/leave/leave_detail_page.dart';
import 'package:hris_skripsi/leave/leave_request_page.dart';
import 'controller/leave_bloc.dart';

class LeaveListPage extends StatelessWidget {
  const LeaveListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveBloc()
        ..add(LoadLeave())
        ..add(LoadLeaveApproval()),
      child: LeaveListPageView(),
    );
  }
}

class LeaveListPageView extends StatelessWidget {
  const LeaveListPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Leave List'),
          bottom: const TabBar(tabs: [
            Tab(text: 'My Document'),
            Tab(text: 'Approval'),
          ]),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                if (state is LeaveSuccess) {
                  final datas = state.leaveListModel.result;
                  if (state.leaveListModel.result!.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: datas!.length,
                      itemBuilder: (context, index) {
                        final data = datas[index];
                        return ListTile(
                          title: Text(data.documentNumber ?? ""),
                          subtitle: Text("${data.startDate} - ${data.endDate}"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveDetailPage(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No Data'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                if (state is LeaveApprovalSuccess) {
                  final datas = state.leaveListModel.result;
                  if (state.leaveListModel.result!.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final data = datas![index];
                        return ListTile(
                          title: Text(data.documentNumber ?? ""),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.employeeName ?? ""),
                              Text("${data.startDate} - ${data.endDate}"),
                            ],
                          ),
                          trailing: Wrap(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () {
                                  showOkCancelAlertDialog(
                                    context: context,
                                    title: 'Approve',
                                    message:
                                        'Are you sure to approve this request?',
                                  ).then(
                                    (value) {
                                      if (value == OkCancelResult.ok) {
                                        // do something
                                      }
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  showOkCancelAlertDialog(
                                    context: context,
                                    title: 'Reject',
                                    message:
                                        'Are you sure to reject this request?',
                                  ).then(
                                    (value) {
                                      if (value == OkCancelResult.ok) {
                                        // do something
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveDetailPage(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No Data'));
                  }
                } else if (state is LeaveApprovalFailure) {
                  return const Center(child: Text("No Access"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LeaveRequestPage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
