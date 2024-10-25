import 'package:employee_attendance/domain/entities/office_settings_entity.dart';

abstract class AttendanceRepository {
  Stream<OfficeSettingsEntity> getOfficeSettingsStream();
  Future<void> updateOfficeSettings(OfficeSettingsEntity settings);
}
