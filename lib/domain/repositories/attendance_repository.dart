import 'package:employee_attendance/domain/entities/office_settings.dart';

abstract class AttendanceRepository {
  Stream<OfficeSettings> getOfficeSettingsStream();
  Future<void> updateOfficeSettings(OfficeSettings settings);
}
