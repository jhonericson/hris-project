import 'package:flutter/material.dart';
import 'package:hris_skripsi/leave/leave_request_page.dart';

class LeaveListPage extends StatelessWidget {
  const LeaveListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Leave List'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: index % 2 == 0 ? const Text('Cuti') : const Text('Sakit'),
            subtitle: Text('$index/12/2024'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LeaveRequestPage()));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LeaveRequestPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
