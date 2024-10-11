import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/home/widgets/attendance_time_widget.dart';
import 'package:employee_attendance/presentation/home/widgets/check_button.dart';
import 'package:employee_attendance/presentation/home/widgets/custom_appbar.dart';
import 'package:employee_attendance/presentation/main/presenter/main_page_presenter.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePresenter homePresenter = locate<HomePresenter>();
  final ProfilePagePresenter _profilePagePresenter =
      locate<ProfilePagePresenter>();
  late final MainPagePresenter _mainPagePresenter = locate<MainPagePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: homePresenter,
      builder: () {
        final user = _profilePagePresenter.currentUiState.employee;
        final homeState = homePresenter.currentUiState;

        return Scaffold(
          appBar: CustomAppBar(
            theme: theme,
            userName: user!.name ?? '',
            greetingMessage:
                '${homePresenter.currentUiState.greetingMessage} Mark your attendance',
            profileImageUrl: user.image ?? '',
            onProfileTap: () => _mainPagePresenter.updateIndex(index: 2),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homePresenter.getFormattedCurrentTime(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: fiftyPx,
                  ),
                ),
                gapH5,
                Text(
                  getFormattedCurrentDate(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: fourteenPx,
                    color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
                  ),
                ),
                gapH50,
                CheckButton(
                  homePresenter: homePresenter,
                  homeState: homeState,
                  theme: theme,
                ),

                gapH50,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: tenPx),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AttendanceTimeWidget(
                        iconPath: SvgPath.icTimeIn,
                        time: getFormattedTime(homeState.checkInTime),
                        label: 'Check In',
                      ),
                      gapW10,
                      AttendanceTimeWidget(
                        iconPath: SvgPath.icTimeOut,
                        time: getFormattedTime(homeState.checkOutTime),
                        label: 'Check Out',
                      ),
                      gapW10,
                      AttendanceTimeWidget(
                        iconPath: SvgPath.icTotalHrs,
                        time: getFormattedDuration(homeState.workDuration),
                        label: 'Total Hrs',
                      ),
                    ],
                  ),
                ),
                // TextButton(
                //     onPressed: () => homePresenter.initializeSettings(),
                //     child: const Text('Initialize Settings')),
              ],
            ),
          ),
        );
      },
    );
  }
}
