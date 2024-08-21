// domain/usecases/get_greeting_usecase.dart
class GetGreetingUseCase {
  String execute() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else if (hour < 20) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }
}
