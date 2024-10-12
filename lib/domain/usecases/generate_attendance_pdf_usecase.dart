import 'dart:io';

import 'package:employee_attendance/domain/service/pdf_generation_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:employee_attendance/domain/entities/all_attendance.dart';

class GenerateAttendancePdfUseCase {
  final PdfGenerationService _pdfService;

  GenerateAttendancePdfUseCase(
    this._pdfService,
  );
  Future<File> execute(
    List<AllAttendance> attendances,
    String fileName, {
    required String officeName,
    required String officeLocation,
    required DateTime startDate,
    required DateTime endDate,
    required String dateRange,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          _pdfService.buildHeader(officeName, officeLocation, dateRange),
          pw.SizedBox(height: 20),
          _pdfService.buildAttendanceTable(attendances),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
