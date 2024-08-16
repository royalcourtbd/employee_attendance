import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:employee_attendance/core/config/employee_attendance_app_color.dart';
import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/history/ui/history_page.dart';
import 'package:employee_attendance/presentation/home/ui/home_page.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';
import 'package:employee_attendance/presentation/main/widgets/double_back_to_exit_app.dart';
import 'package:employee_attendance/presentation/profile/ui/profile_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final MainPagePresenter mainPagePresenter = locate<MainPagePresenter>();

  final List<Widget> _pages = [
    HomePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    final ThemeData theme = Theme.of(context);
    return DoubleTapBackToExitApp(
      child: PresentableWidgetBuilder(
          presenter: mainPagePresenter,
          builder: () {
            return Scaffold(
              body: _pages[mainPagePresenter.currentUiState.currentNavIndex],
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: twentyFivePx),
                child: BottomBarSalomon(
                  radiusSalomon: radius20,
                  borderRadius: radius50,
                  items: const [
                    TabItem(
                      key: 'Home',
                      icon: Icons.home_filled,
                      title: 'Home',
                    ),
                    TabItem(
                      key: 'Attendance',
                      icon: Icons.calendar_month,
                      title: 'History',
                    ),
                    TabItem(
                      key: 'Profile',
                      icon: Icons.person,
                      title: 'Profile',
                    ),
                  ],
                  iconSize: twentyFivePx,
                  colorSelected: Colors.white,
                  color: Colors.white,
                  indexSelected:
                      mainPagePresenter.currentUiState.currentNavIndex,
                  backgroundColor: theme.primaryColor,
                  backgroundSelected: EmployeeAttendanceAppColor.secondaryColor,
                  titleStyle: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: fourteenPx,
                    color: Colors.white,
                  ),
                  onTap: (index) => mainPagePresenter.updateIndex(index),
                ),
              ),
            );
          }),
    );
  }
}
