import 'package:flutter/material.dart';

class LeaveDetailPage extends StatelessWidget {
  final String leaveType = 'Cuti Tahunan'; // Contoh tipe cuti
  final String leaveDate = '2025-01-16'; // Contoh tanggal cuti
  final String leaveNote = 'Liburan keluarga ke Bali.'; // Contoh catatan cuti

  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                leaveType,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),

            // Field Tanggal
            Text(
              'Tanggal:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                leaveDate,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),

            // Field Note
            Text(
              'Catatan:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                leaveNote,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
