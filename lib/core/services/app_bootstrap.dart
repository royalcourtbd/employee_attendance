import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/services/firebase_service.dart';
import 'package:employee_attendance/domain/entities/employee_entity.dart';
import 'package:employee_attendance/domain/usecases/fetch_user_data_use_case.dart';

const Duration _userSessionTimeout = Duration(seconds: 10);

enum AppDestination {
  login,
  adminDashboard,
  employeeHome,
}

class AppBootstrapResult {
  const AppBootstrapResult({
    required this.destination,
    this.employee,
  });

  final AppDestination destination;
  final EmployeeEntity? employee;
}

Future<AppBootstrapResult> resolveInitialAppDestination() async {
  final FirebaseService firebaseService = locate<FirebaseService>();
  final currentUser = firebaseService.auth.currentUser;

  if (currentUser == null) {
    return const AppBootstrapResult(destination: AppDestination.login);
  }

  try {
    final EmployeeEntity? employee =
        await locate<FetchUserDataUseCase>().execute(currentUser.uid).timeout(
              _userSessionTimeout,
            );

    if (employee == null) {
      await firebaseService.auth.signOut();
      return const AppBootstrapResult(destination: AppDestination.login);
    }

    return AppBootstrapResult(
      destination: employee.role == 'admin'
          ? AppDestination.adminDashboard
          : AppDestination.employeeHome,
      employee: employee,
    );
  } catch (_) {
    return const AppBootstrapResult(destination: AppDestination.login);
  }
}
