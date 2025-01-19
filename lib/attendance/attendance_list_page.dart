import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hris_skripsi/attendance/attendance_detail_page.dart';
import 'package:hris_skripsi/core/enum.dart';
import 'controller/attendance_bloc.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(),
      child: const AttendanceListPageView(),
    );
  }
}

class AttendanceListPageView extends StatelessWidget {
  const AttendanceListPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance List'),
          bottom: const TabBar(tabs: [
            Tab(text: 'My Document'),
            Tab(text: 'Approval'),
          ]),
        ),
        body: BlocListener<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            if (state.actionStatus == ActionStatus.loading) {
              EasyLoading.show(
                status: "Please Wait...",
                dismissOnTap: true,
              );
              EasyLoading.dismiss();
              print("joko");
            } else if (state.actionStatus == ActionStatus.success) {
              EasyLoading.showSuccess("Success");
              EasyLoading.dismiss();
              context.read<AttendanceBloc>().add(LoadAttendanceApproval());
            } else if (state.actionStatus == ActionStatus.failure) {
              EasyLoading.showError("Failed");
              EasyLoading.dismiss();
            }
          },
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AttendanceListTab(),
              AttendanceApprovalTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceApprovalTab extends StatelessWidget {
  const AttendanceApprovalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc()..add(LoadAttendanceApproval()),
      child: const AttendanceApprovalTabView(),
    );
  }
}

class AttendanceApprovalTabView extends StatelessWidget {
  const AttendanceApprovalTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state.approvalStatus == ApprovalStatus.success) {
          final datas = state.attendanceApproval;
          if (datas.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AttendanceBloc>().add(LoadAttendanceApproval());
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<AttendanceBloc>().add(LoadAttendanceApproval());
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
                          Text(data.datetime ?? ""),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttendanceDetailPage(
                              id: data.id!,
                              source: Source.approval.name,
                            ),
                          ),
                        ).then(
                          (value) {
                            if (value == "ok") {
                              context
                                  .read<AttendanceBloc>()
                                  .add(LoadAttendanceApproval());
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        } else if (state.approvalStatus == ApprovalStatus.failure) {
          return const Center(child: Text("Please refresh"));
        } else if (state.approvalStatus == ApprovalStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("Wait..."));
        }
      },
    );
  }
}

class AttendanceListTab extends StatelessWidget {
  const AttendanceListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc()..add(LoadAttendance()),
      child: AttendanceListTabView(),
    );
  }
}

class AttendanceListTabView extends StatelessWidget {
  const AttendanceListTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state.listStatus == ListStatus.success) {
          final datas = state.attendanceList;
          if (datas.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AttendanceBloc>().add(LoadAttendance());
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  final data = datas[index];
                  return ListTile(
                    title: Text(data.documentNumber ?? ""),
                    subtitle: Text(data.datetime ?? ""),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttendanceDetailPage(
                            id: data.id!,
                            source: Source.detail.name,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        } else if (state.listStatus == ListStatus.failure) {
          return const Center(child: Text("Please refresh"));
        } else if (state.listStatus == ListStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("Wait..."));
        }
      },
    );
  }
}
