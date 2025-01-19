import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_skripsi/core/enum.dart';
import 'package:hris_skripsi/leave/leave_detail_page.dart';
import 'package:hris_skripsi/leave/leave_request_page.dart';
import 'controller/leave_bloc.dart';

// class LeaveListPage extends StatelessWidget {
//   const LeaveListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LeaveBloc()
//         ..add(LoadLeave())
//         ..add(LoadLeaveApproval()),
//       child: LeaveListPageView(),
//     );
//   }
// }

class LeaveListPage extends StatelessWidget {
  const LeaveListPage({super.key});

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
            LeaveListTab(),
            LeaveApprovalTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LeaveRequestPage(),
              ),
            ).then((value) {
              if (value == "ok") {
                context.read<LeaveBloc>().add(LoadLeave());
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class LeaveApprovalTab extends StatelessWidget {
  const LeaveApprovalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveBloc()..add(LoadLeaveApproval()),
      child: LeaveApprovalTabView(),
    );
  }
}

class LeaveApprovalTabView extends StatelessWidget {
  const LeaveApprovalTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        if (state.approvalStatus == ApprovalStatus.success) {
          final datas = state.leaveApproval;
          if (datas.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<LeaveBloc>().add(LoadLeaveApproval());
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  final data = datas[index];
                  return ListTile(
                    title: Text(data.documentNumber ?? ""),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.employeeName ?? ""),
                        Text("${data.startDate} - ${data.endDate}"),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeaveDetailPage(
                            id: data.id!,
                            source: Source.approval.name,
                          ),
                        ),
                      ).then((value) {
                        if (value == "ok") {
                          context.read<LeaveBloc>().add(LoadLeaveApproval());
                        }
                      });
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        } else if (state.approvalStatus == ApprovalStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.approvalStatus == ApprovalStatus.failure) {
          return const Center(child: Text('Error'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class LeaveListTab extends StatelessWidget {
  const LeaveListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveBloc()..add(LoadLeave()),
      child: LeaveListTabView(),
    );
  }
}

class LeaveListTabView extends StatelessWidget {
  const LeaveListTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        if (state.listStatus == ListStatus.success) {
          final datas = state.leaveList;
          if (datas.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<LeaveBloc>().add(LoadLeave());
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: datas.length,
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
                          builder: (context) => LeaveDetailPage(
                            id: data.id!,
                            source: Source.detail.name,
                          ),
                        ),
                      ).then((value) {
                        if (value == "ok") {
                          context.read<LeaveBloc>().add(LoadLeave());
                        }
                      });
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        } else if (state.listStatus == ListStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.listStatus == ListStatus.failure) {
          return const Center(child: Text('Error'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
