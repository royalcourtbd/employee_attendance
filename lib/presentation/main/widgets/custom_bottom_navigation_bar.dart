import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:employee_attendance/core/config/employee_attendance_app_color.dart';
import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  const CustomBottomNavigationbar({
    super.key,
    required MainPagePresenter mainPagePresenter,
    required this.theme,
  }) : _mainPagePresenter = mainPagePresenter;

  final MainPagePresenter _mainPagePresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BottomBarSalomon(
      radiusSalomon: radius20,
      borderRadius: radius50,
      items: _bottomNavItems,
      iconSize: twentyFivePx,
      colorSelected: Colors.white,
      color: Colors.white,
      indexSelected: _mainPagePresenter.uiState.value.currentNavIndex,
      backgroundColor: theme.primaryColor,
      backgroundSelected: EmployeeAttendanceAppColor.secondaryColor,
      titleStyle: theme.textTheme.bodyMedium!.copyWith(
        fontSize: fourteenPx,
        color: Colors.white,
      ),
      onTap: (index) => _mainPagePresenter.updateIndex(index: index),
    );
  }

  final List<TabItem> _bottomNavItems = const [
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
  ];
}
