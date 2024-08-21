import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/data/repositories/user_repository_impl.dart';
import 'package:employee_attendance/domain/repositories/user_repository.dart';
import 'package:employee_attendance/domain/usecases/get_greeting_usecase.dart';
import 'package:employee_attendance/domain/usecases/user_usecases.dart';
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
      ..registerLazySingleton(() => UserUseCases(locate()))
      ..registerLazySingleton(() => GetGreetingUseCase());
  }

  Future<void> _setupService() async {
    _serviceLocator
        .registerLazySingleton<FirebaseService>(() => FirebaseService());
  }

  Future<void> _setupRepository() async {
    _serviceLocator.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(locate()));
  }

  Future<void> _setupPresenter() async {
    _serviceLocator
      ..registerFactory(() => loadPresenter(HomePresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(HistoryPagePresenter()))
      ..registerLazySingleton(
          () => loadPresenter(ProfilePagePresenter(locate(), locate())))
      ..registerLazySingleton(() => loadPresenter(NotificationPresenter()))
      ..registerLazySingleton(() => loadPresenter(MainPagePresenter()))
      ..registerLazySingleton(() => loadPresenter(LoginPagePresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(EditProfilePresenter()));
  }
}
