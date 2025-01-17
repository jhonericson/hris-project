import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendanceListPage extends StatefulWidget {
  const AttendanceListPage({super.key});

  @override
  State<AttendanceListPage> createState() => _AttendanceListPageState();
}

class _AttendanceListPageState extends State<AttendanceListPage> {
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    await [
      Permission.location,
      Permission.camera,
    ].request();
  }

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
            ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: const Text('Absen Masuk'),
                  subtitle: Text('$index/12/2024'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                );
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
                  onTap: () {},
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
