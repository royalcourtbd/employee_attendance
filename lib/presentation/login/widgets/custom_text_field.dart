import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController emailController,
    required this.theme,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.icon,
  }) : _emailController = emailController;

  final TextEditingController _emailController;
  final ThemeData theme;
  final String hintText;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) => closeKeyboard(),
      onChanged: onChanged,
      obscureText: isPassword!,
      keyboardType: keyboardType,
      controller: _emailController,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: fourteenPx,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
        ),
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium!.copyWith(
          fontSize: fourteenPx,
          color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
        ),
        border: _outlineInputBorder(theme: theme),
        errorBorder: _outlineInputBorder(theme: theme),
        enabledBorder: _outlineInputBorder(theme: theme),
        focusedBorder:
            _outlineInputBorder(theme: theme, borderColor: theme.primaryColor),
        disabledBorder: _outlineInputBorder(theme: theme),
        focusedErrorBorder: _outlineInputBorder(theme: theme),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder(
      {required ThemeData theme, Color? borderColor}) {
    return OutlineInputBorder(
      borderRadius: radius10,
      borderSide: BorderSide(
        color:
            borderColor ?? theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
      ),
    );
  }
}
