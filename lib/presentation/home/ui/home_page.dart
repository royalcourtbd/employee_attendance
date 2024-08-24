import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:employee_attendance/presentation/home/widgets/attendance_time_widget.dart';
import 'package:employee_attendance/presentation/home/widgets/custom_appbar.dart';
import 'package:employee_attendance/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePresenter homePresenter = locate<HomePresenter>();
  final ProfilePagePresenter _profilePagePresenter =
      locate<ProfilePagePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: homePresenter,
      builder: () {
        final user = _profilePagePresenter.currentUiState.user;
        final homeState = homePresenter.currentUiState;

        return Scaffold(
          appBar: CustomAppBar(
            theme: theme,
            userName: user!.name ?? '',
            greetingMessage:
                '${homePresenter.currentUiState.greetingMessage} Mark your attendance',
            profileImageUrl: user.image ?? '',
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('hh:mm:ss a')
                      .format(homePresenter.currentUiState.nowTimeIsIt),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: fiftyPx,
                  ),
                ),
                gapH5,
                Text(
                  DateFormat('MMM dd, yyyy - EEEE').format(DateTime.now()),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: fourteenPx,
                    color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
                  ),
                ),
                gapH50,
                NeumorphicButton(
                  onPressed: homePresenter.isCheckInButtonEnabled()
                      ? () => homePresenter.handleAttendanceAction()
                      : null,
                  style: const NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 50,
                    intensity: 0.7,
                    lightSource: LightSource.topLeft,
                    surfaceIntensity: 0.5,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(fiftyPx),
                  child: Column(
                    children: [
                      Image.asset(
                        SvgPath.icTouch,
                        color: homeState.canCheckIn
                            ? theme.primaryColor
                            : homeState.canCheckOut
                                ? theme.colorScheme.error
                                : theme.colorScheme.secondary,
                        width: 80,
                      ),
                      gapH10,
                      Text(
                        homePresenter.getCheckButtonText(),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: thirteenPx,
                          color: homePresenter.getCheckButtonColor(theme),
                        ),
                      ),
                    ],
                  ),
                ),
                gapH75,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: tenPx),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AttendanceTimeWidget(
                        iconPath: SvgPath.icTimeIn,
                        time: homePresenter
                            .getFormattedTime(homeState.checkInTime),
                        label: 'Check In',
                      ),
                      gapW10,
                      AttendanceTimeWidget(
                        iconPath: SvgPath.icTimeOut,
                        time: homePresenter
                            .getFormattedTime(homeState.checkOutTime),
                        label: 'Check Out',
                      ),
                      gapW10,
                      AttendanceTimeWidget(
                        iconPath: SvgPath.icTotalHrs,
                        time: homePresenter
                            .getFormattedDuration(homeState.workDuration),
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
