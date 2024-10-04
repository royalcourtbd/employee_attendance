import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/data/repositories/attendance_repository_impl.dart';
import 'package:employee_attendance/data/repositories/employee_repository_impl.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:employee_attendance/domain/service/holiday_service.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/domain/usecases/get_greeting_usecase.dart';
import 'package:employee_attendance/domain/usecases/employee_usecases.dart';
import 'package:employee_attendance/domain/usecases/logout_usecase.dart';

import 'package:employee_attendance/presentation/admin/attendance/presenter/view_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/dashboard/presenter/admin_dashboard_presenter.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/employees_presenter.dart';
import 'package:employee_attendance/presentation/admin/settings/presenter/settings_presenter.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_presenter.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_presenter.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';
import 'package:employee_attendance/presentation/notification/presenter/notification_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/edit_profile_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';

import 'package:get_it/get_it.dart';

final GetIt _serviceLocator = GetIt.instance;

T locate<T extends Object>() => _serviceLocator.get<T>();

void dislocate<T extends BasePresenter>() => unloadPresenterManually<T>();

class ServiceLocator {
  ServiceLocator._();

  static Future<void> setup({bool startOnlyService = false}) async {
    final ServiceLocator locator = ServiceLocator._();
    await locator._setupService();
    if (startOnlyService) return;
    await locator._setupPresenter();
    await locator._setupRepository();
    await locator._setupUseCase();
  }

  Future<void> _setupUseCase() async {
    _serviceLocator
      ..registerLazySingleton(() => EmployeeUseCases(locate()))
      ..registerLazySingleton(() => GetGreetingUseCase())
      ..registerLazySingleton(() => AttendanceUseCases(locate()))
      ..registerLazySingleton(() => LogoutUseCase(locate()));
  }

  Future<void> _setupService() async {
    _serviceLocator
      ..registerLazySingleton<FirebaseService>(() => FirebaseService())
      ..registerLazySingleton(() => HolidayService());
  }

  Future<void> _setupRepository() async {
    _serviceLocator
      ..registerLazySingleton<EmployeeRepository>(
          () => EmployeeRepositoryImpl(locate()))
      ..registerLazySingleton<AttendanceRepository>(
          () => AttendanceRepositoryImpl(locate()));
  }

  Future<void> _setupPresenter() async {
    _serviceLocator
      ..registerFactory(() => loadPresenter(HomePresenter(
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() =>
          loadPresenter(HistoryPagePresenter(locate(), locate(), locate())))
      ..registerLazySingleton(() => loadPresenter(ProfilePagePresenter(
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(NotificationPresenter()))
      ..registerLazySingleton(() => loadPresenter(MainPagePresenter()))
      ..registerLazySingleton(() => loadPresenter(LoginPagePresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(EditProfilePresenter()))
      ..registerLazySingleton(
          () => loadPresenter(AdminDashboardPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(EmployeesPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(SettingsPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(ViewAttendancePresenter()));
  }
}
