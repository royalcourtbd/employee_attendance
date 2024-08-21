import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';

import 'package:employee_attendance/presentation/history/ui/history_page.dart';
import 'package:employee_attendance/presentation/home/ui/home_page.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';
import 'package:employee_attendance/presentation/main/widgets/custom_bottom_navigation_bar.dart';
import 'package:employee_attendance/presentation/main/widgets/double_back_to_exit_app.dart';
import 'package:employee_attendance/presentation/profile/ui/profile_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainPagePresenter _mainPagePresenter = locate<MainPagePresenter>();

  final List<Widget> _pages = [
    HomePage(),
    const HistoryPage(),
     ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _setSystemUIOverlayStyle(context);

    return DoubleTapBackToExitApp(
      child: PresentableWidgetBuilder(
        presenter: _mainPagePresenter,
        builder: () => Scaffold(
          body: _pages[_mainPagePresenter.uiState.value.currentNavIndex],
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: twentyFivePx),
            child: CustomBottomNavigationbar(
              mainPagePresenter: _mainPagePresenter,
              theme: theme,
            ),
          ),
        ),
      ),
    );
  }

  void _setSystemUIOverlayStyle(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }
}
