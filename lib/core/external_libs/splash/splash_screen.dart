import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen {
  SplashScreen._();

  static bool _appAlreadyOpen = false;

  static Future<void> show() async {
    if (_appAlreadyOpen) return;

    final WidgetsBinding widgetsBinding =
        WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    _appAlreadyOpen = true;
  }

  static void hide() {
    FlutterNativeSplash.remove();
  }
}
