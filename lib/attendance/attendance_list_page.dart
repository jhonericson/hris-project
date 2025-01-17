import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_skripsi/attendance/attendance_detail_page.dart';

import 'controller/attendance_bloc.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc()..add(LoadAttendance()),
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
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceSuccess) {
                  final datas = state.attendanceListModel.result;
                  if (state.attendanceListModel.result!.isNotEmpty) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: datas!.length,
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
                                builder: (context) =>
                                    const AttendanceDetailPage(),
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
            ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: const Text('Absen Masuk'),
                  subtitle: Text('$index/12/2024'),
                  trailing: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          showOkCancelAlertDialog(
                            context: context,
                            title: 'Approve',
                            message: 'Are you sure to approve this request?',
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
                            message: 'Are you sure to reject this request?',
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
                        builder: (context) => const AttendanceDetailPage(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const AttendanceRequestPage(),
        //         ));
        //   },
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
