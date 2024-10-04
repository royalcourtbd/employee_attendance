import 'package:employee_attendance/core/base/base_presenter.dart';
import 'package:employee_attendance/domain/entities/employee.dart';
import 'package:employee_attendance/domain/usecases/employee_usecases.dart';
import 'package:employee_attendance/presentation/admin/employee/presenter/employees_ui_state.dart';

class EmployeesPresenter extends BasePresenter<EmployeesUiState> {
  final EmployeeUseCases _userUseCases;

  EmployeesPresenter(this._userUseCases);

  final Obs<EmployeesUiState> uiState = Obs(EmployeesUiState.empty());
  EmployeesUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    await toggleLoading(loading: true);

    _userUseCases.getAllEmployees().listen(
      (List<Employee> employees) {
        uiState.value = currentUiState.copyWith(employees: employees);
      },
      onError: (error) {
        addUserMessage('কর্মচারীদের তথ্য লোড করতে সমস্যা হয়েছে: $error');
      },
      onDone: () {
        toggleLoading(loading: false);
      },
    );
  }

  void editEmployee(Employee employee) {
    // Implement edit employee logic
  }

  void addEmployee() {
    // Implement add employee logic
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
