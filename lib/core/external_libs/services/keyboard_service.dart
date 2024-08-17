import 'package:employee_attendance/core/utility/trial_utility.dart';
import 'package:employee_attendance/presentation/employee_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class KeyboardService {
  KeyboardService._();

  static bool isVisible(BuildContext context) {
    final bool? visible = catchAndReturn(() {
      BuildContext? scaffoldContext =
          context.findRootAncestorStateOfType<ScaffoldState>()?.context;
      scaffoldContext ??= context;
      if (!scaffoldContext.mounted) return false;
      bool keyboardVisible = false;
      if (MediaQuery.of(scaffoldContext).viewInsets.bottom > 0) {
        keyboardVisible = true;
      }
      return keyboardVisible;
    });
    return visible ?? false;
  }

  static void dismiss({BuildContext? context}) => catchVoid(() {
        final BuildContext anyContext = (context != null && context.mounted)
            ? context
            : EmployeeAttendance.globalContext;
        if (!isVisible(anyContext)) return;
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
        final FocusNode focus = Focus.of(anyContext);
        if (focus.hasFocus || focus.hasPrimaryFocus) focus.unfocus();
      });
}
