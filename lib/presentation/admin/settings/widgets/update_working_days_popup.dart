import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/admin/settings/presenter/settings_presenter.dart';
import 'package:employee_attendance/presentation/common/loading_button_widget.dart';
import 'package:flutter/material.dart';

class UpdateWorkingDaysPopup extends StatelessWidget {
  UpdateWorkingDaysPopup({super.key, required this.updateWorkingDays});

  final VoidCallback updateWorkingDays;

  static Future<void> show({
    required BuildContext context,
    required VoidCallback updateWorkingDays,
  }) async {
    showAnimatedDialog(
      context: context,
      builder: (context) => UpdateWorkingDaysPopup(
        updateWorkingDays: updateWorkingDays,
      ),
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      barrierDismissible: true,
    );
  }

  final SettingsPresenter _settingsPresenter = locate<SettingsPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _settingsPresenter,
      builder: () {
        final uiState = _settingsPresenter.uiState.value;
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: twentyPx),
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: radius10,
          ),
          child: Container(
            padding: padding20,
            decoration: BoxDecoration(
              borderRadius: radius10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Update Working Days',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: twentyPx,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                gapH20,
                Wrap(
                  spacing: tenPx,
                  children: _settingsPresenter.listOfDays.map((day) {
                    final isSelected = uiState.workDays.contains(day);
                    return FilterChip(
                      label: Text(
                        day,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      checkmarkColor: Colors.white,
                      color: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return theme.primaryColor;
                          }
                          return theme.primaryColor.withValues(alpha: .2);
                        },
                      ),
                      shape: const StadiumBorder(),
                      side: BorderSide.none,
                      selected: uiState.workDays.contains(day),
                      selectedColor: theme.colorScheme.primary,
                      onSelected: (value) {
                        _settingsPresenter.toggleWorkDay(day);
                      },
                    );
                  }).toList(),
                ),
                gapH30,
                LoadingButtonWidget(
                  isLoading: _settingsPresenter.currentUiState.isLoading,
                  theme: theme,
                  buttonText: 'Update',
                  onPressed: () {
                    updateWorkingDays();
                    context.navigatorPop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
