import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/presentation/home/presenter/home_page_ui_state.dart';
import 'package:employee_attendance/presentation/home/presenter/home_presenter.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({
    super.key,
    required this.homePresenter,
    required this.homeState,
    required this.theme,
  });

  final HomePresenter homePresenter;
  final HomePageUiState homeState;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
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
    );
  }
}
