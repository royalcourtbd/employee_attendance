import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:employee_attendance/data/repositories/attendance_repository_impl.dart';
import 'package:employee_attendance/data/repositories/auth_repository_impl.dart';
import 'package:employee_attendance/data/repositories/employee_repository_impl.dart';
import 'package:employee_attendance/data/services/backend_as_a_service.dart';
import 'package:employee_attendance/domain/repositories/attendance_repository.dart';
import 'package:employee_attendance/domain/repositories/employee/auth_repository.dart';
import 'package:employee_attendance/domain/repositories/employee_repository.dart';
import 'package:employee_attendance/domain/service/holiday_service.dart';
import 'package:employee_attendance/domain/service/pdf_generation_service.dart';
import 'package:employee_attendance/domain/usecases/add_employee_use_case.dart';
import 'package:employee_attendance/domain/usecases/attendance_usecases.dart';
import 'package:employee_attendance/domain/usecases/change_password_use_case.dart';
import 'package:employee_attendance/domain/usecases/create_demo_user_use_case.dart';
import 'package:employee_attendance/domain/usecases/fetch_user_data_use_case.dart';
import 'package:employee_attendance/domain/usecases/generate_attendance_pdf_usecase.dart';
import 'package:employee_attendance/domain/usecases/generate_new_employee_id_use_case.dart';
import 'package:employee_attendance/domain/usecases/get_all_attendance_usecase.dart';
import 'package:employee_attendance/domain/usecases/get_all_employees_use_case.dart';
import 'package:employee_attendance/domain/usecases/get_device_token_use_case.dart';
import 'package:employee_attendance/domain/usecases/get_greeting_usecase.dart';
import 'package:employee_attendance/domain/usecases/get_user_stream_use_case.dart';
import 'package:employee_attendance/domain/usecases/login_use_case.dart';
import 'package:employee_attendance/domain/usecases/logout_usecase.dart';
import 'package:employee_attendance/domain/usecases/update_user_use_case.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/todays_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/attendance/presenter/all_attendance_presenter.dart';
import 'package:employee_attendance/presentation/admin/dashboard/presenter/admin_dashboard_presenter.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/add_employee_presenter.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/employees_presenter.dart';
import 'package:employee_attendance/presentation/admin/settings/presenter/settings_presenter.dart';
import 'package:employee_attendance/presentation/authentication/presenter/auth_wrapper_presenter.dart';
import 'package:employee_attendance/presentation/history/presenter/history_page_presenter.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_presenter.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';
import 'package:employee_attendance/presentation/notification/presenter/notification_presenter.dart';
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
    await locator._setupRepository();
    await locator._setUpDataSources();
    await locator._setupUseCase();
    await locator._setupPresenter();
  }

  Future<void> _setupUseCase() async {
    _serviceLocator
      ..registerLazySingleton(() => GetGreetingUseCase())
      ..registerLazySingleton(() => AttendanceUseCases(locate()))
      ..registerLazySingleton(() => LogoutUseCase(locate()))
      ..registerLazySingleton(() => CreateDemoUserUseCase(locate()))
      ..registerLazySingleton(() => AddEmployeeUseCase(locate()))
      ..registerLazySingleton(() => FetchUserDataUseCase(locate()))
      ..registerLazySingleton(() => GenerateNewEmployeeIdUseCase(locate()))
      ..registerLazySingleton(() => GetAllEmployeesUseCase(locate()))
      ..registerLazySingleton(() => GetDeviceTokenUseCase(locate()))
      ..registerLazySingleton(() => GetUserStreamUseCase(locate()))
      ..registerLazySingleton(() => LoginUseCase(locate()))
      ..registerLazySingleton(() => UpdateUserUseCase(locate()))
      ..registerLazySingleton(() => ChangePasswordUseCase(locate()))
      ..registerLazySingleton(() => GetAllAttendanceUseCase(locate()))
      ..registerLazySingleton(() => GenerateAttendancePdfUseCase(locate()));
  }

  Future<void> _setupService() async {
    _serviceLocator
      ..registerLazySingleton<FirebaseService>(() => FirebaseService())
      ..registerLazySingleton(() => BackendAsAService(locate()))
      ..registerLazySingleton(() => HolidayService())
      ..registerLazySingleton(() => PdfGenerationService());
  }

  Future<void> _setUpDataSources() async {
    _serviceLocator.registerLazySingleton(() => AuthRemoteDataSource(locate()));
  }

  Future<void> _setupRepository() async {
    _serviceLocator
      ..registerLazySingleton<EmployeeRepository>(
          () => EmployeeRepositoryImpl(locate()))
      ..registerLazySingleton<AttendanceRepository>(
          () => AttendanceRepositoryImpl(locate()))
      ..registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(locate()));
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
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(NotificationPresenter()))
      ..registerLazySingleton(() => loadPresenter(MainPagePresenter()))
      ..registerLazySingleton(() => loadPresenter(
          LoginPagePresenter(locate(), locate(), locate(), locate())))
      ..registerLazySingleton(
          () => loadPresenter(AdminDashboardPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(EmployeesPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(SettingsPresenter(locate())))
      ..registerLazySingleton(
          () => loadPresenter(AllAttendancePresenter(locate(), locate())))
      ..registerLazySingleton(
          () => loadPresenter(AddEmployeePresenter(locate(), locate())))
      ..registerLazySingleton(() => loadPresenter(TodaysAttendancePresenter(
            locate(),
            locate(),
          )))
      ..registerLazySingleton(() => loadPresenter(AuthWrapperPresenter()));
  }
}
