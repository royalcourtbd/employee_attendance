import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('attendance')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .orderBy('checkInTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Check-in Time')),
                DataColumn(label: Text('Check-out Time')),
                DataColumn(label: Text('Status')),
              ],
              rows: data.map((attendance) {
                final checkInTime =
                    (attendance['checkInTime'] as Timestamp).toDate();
                final checkOutTime = attendance['checkOutTime'] != null
                    ? (attendance['checkOutTime'] as Timestamp).toDate()
                    : null;

                return DataRow(cells: [
                  DataCell(Text(DateFormat('yyyy-MM-dd').format(checkInTime))),
                  DataCell(Text(DateFormat('HH:mm:ss').format(checkInTime))),
                  DataCell(Text(checkOutTime != null
                      ? DateFormat('HH:mm:ss').format(checkOutTime)
                      : 'Not checked out')),
                  DataCell(Text(attendance['isLate'] ? 'Late' : 'On Time')),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
