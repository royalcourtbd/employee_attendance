import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/di/service_locator.dart';
import 'package:employee_attendance/core/external_libs/presentable_widget_builder.dart';
import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:employee_attendance/core/utility/utility.dart';
import 'package:employee_attendance/presentation/common/loading_button_widget.dart';
import 'package:employee_attendance/presentation/login/presenter/login_page_presenter.dart';
import 'package:employee_attendance/presentation/login/widgets/custom_text_field.dart';
import 'package:employee_attendance/presentation/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginPagePresenter _loginPresenter = locate<LoginPagePresenter>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: theme.scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: theme.scaffoldBackgroundColor,
      systemNavigationBarDividerColor: theme.scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    );

    return PresentableWidgetBuilder(
      presenter: _loginPresenter,
      builder: () {
        final loginState = _loginPresenter.currentUiState;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Form(
                    key: _loginPresenter.formKey,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: paddingH16,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              gapH40,
                              SvgPicture.asset(
                                SvgPath.icTimeManagement,
                                width: EmployeeAttendanceScreen.width * 0.6,
                                height: EmployeeAttendanceScreen.width * 0.6,
                              ),
                              gapH15,
                              LoginHeader(theme: theme),
                              gapH40,
                              CustomTextField(
                                textEditingController: _emailController,
                                theme: theme,
                                hintText: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  _loginPresenter.updateEmail(email: value);
                                  _loginPresenter.formKey.currentState!
                                      .validate();
                                },
                                validator: _loginPresenter.validateEmail,
                                icon: Icons.email,
                              ),
                              gapH25,
                              CustomTextField(
                                textEditingController: _passwordController,
                                theme: theme,
                                hintText: 'Enter your password',
                                isPassword: true,
                                icon: Icons.lock,
                                onChanged: (value) {
                                  _loginPresenter.updatePassword(
                                      password: value);
                                  _loginPresenter.formKey.currentState!
                                      .validate();
                                },
                                validator: validatePassword,
                              ),
                              const Spacer(),
                              LoadingButtonWidget(
                                isLoading: loginState.isLoading,
                                theme: theme,
                                buttonText: 'Login',
                                onPressed: () =>
                                    _loginPresenter.handleLogin(context),
                              ),
                              gapH20,
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
