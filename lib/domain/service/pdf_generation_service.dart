// lib/domain/services/pdf_generation_service.dart
import 'package:employee_attendance/core/config/employee_attendance_screen.dart';

import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerationService {
  pw.Widget buildHeader(
      String officeName, String officeLocation, String dateRange) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(officeName,
            style: pw.TextStyle(
                fontSize: eighteenPx, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: fivePx),
        pw.Text(officeLocation, style: pw.TextStyle(fontSize: fourteenPx)),
        pw.SizedBox(height: tenPx),
        pw.Text(
          'Attendance Report: $dateRange',
          style: pw.TextStyle(
              fontSize: fourteenPx, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  pw.Widget buildAttendanceTable(List<AllAttendance> attendances) {
    final List<pw.TableRow> rows = [
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey300),
        children: [
          buildTableCell('Date', isHeader: true),
          buildTableCell('Name', isHeader: true),
          buildTableCell('Employee ID', isHeader: true),
          buildTableCell('Check In', isHeader: true),
          buildTableCell('Check Out', isHeader: true),
          buildTableCell('Duration', isHeader: true),
        ],
      ),
    ];
    for (final attendance in attendances) {
      rows.add(pw.TableRow(
        children: [
          buildTableCell(getFormattedDate(attendance.attendance.checkInTime)),
          buildTableCell(attendance.employee.name ?? ''),
          buildTableCell(attendance.employee.employeeId ?? ''),
          buildTableCell(
            getFormattedTime(attendance.attendance.checkInTime),
            textColor: attendance.attendance.isLate ? PdfColors.red : null,
          ),
          buildTableCell(getFormattedTime(attendance.attendance.checkOutTime)),
          buildTableCell(
              getFormattedDuration(attendance.attendance.workDuration)),
        ],
      ));
    }

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: rows,
    );
  }

  pw.Widget buildTableCell(String text,
      {bool isHeader = false, PdfColor? textColor}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: textColor,
        ),
      ),
    );
  }
}
