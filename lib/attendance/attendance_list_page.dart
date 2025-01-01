import 'package:flutter/material.dart';

import 'attendance_request_page.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance List'),
      ),
      body: ListView.builder(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AttendanceRequestPage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
