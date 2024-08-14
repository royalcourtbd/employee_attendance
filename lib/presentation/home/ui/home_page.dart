import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/home/widgets/double_back_to_exit_app.dart';
import 'package:employee_attendance/presentation/home/widgets/mini_setting_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePresenter homePresenter = Get.put(HomePresenter());

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DoubleBackToExitApp(
      child: PresentableWidgetBuilder(
        presenter: homePresenter,
        builder: () {
          return PopScope(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Jobs BD',
                ),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              drawer: MiniSettingsDrawer(theme: theme),
            ),
          );
        },
      ),
    );
  }
}
